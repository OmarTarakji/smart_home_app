import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:udp/udp.dart';

import '../domain/udp_device.dart';
import 'encrypt.dart';

abstract class UdpService {
  static const String DISCOVER = 'Discover ESP32';
  static const Port port = Port(12345);
  final _discoveryController = StreamController<UdpDevice>();

  void dispose() {
    _discoveryController.close();
  }
}

class DeviceUdpService extends UdpService {
  static const String _CREDENTIALS = 'Credentials';

  Future<void> discoverDevices() async {
    // Random local port
    final UDP udp = await UDP.bind(Endpoint.any(port: const Port(0)));

    // Create discovery packet
    final packet = Uint8List.fromList(
      utf8.encode(
        jsonEncode({
          'type': UdpService.DISCOVER,
          'app': 'com.omar.smart_home',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        }),
      ),
    );
    debugPrint('log: Sending discovery request');
    // Send to broadcast address
    await udp.send(packet, Endpoint.broadcast(port: UdpService.port));

    final subscription = udp.asStream().listen((datagram) {
      debugPrint('log: Received discovery response');
      if (datagram != null) {
        debugPrint('log: ${String.fromCharCodes(datagram.data)}');
        try {
          final response = String.fromCharCodes(datagram.data);
          final deviceIp = datagram.address.address;
          final device = UdpDevice.fromJson(jsonDecode(response), deviceIp);
          // devices.add(device);
          _discoveryController.add(device);
        } catch (e) {
          debugPrint("Error parsing device response: $e");
        }
      }
    });

    // Wait for responses for 5 seconds
    await Future.delayed(const Duration(seconds: 5));
    await subscription.cancel();
    udp.close();
  }

  Stream<UdpDevice> get deviceStream => _discoveryController.stream;

  Future<bool> sendDatabaseCredentials({
    required String deviceIP,
    required String mac,
    required Map<String, dynamic> credentials,
  }) async {
    try {
      // Bind UDP socket to any available port
      final UDP udp = await UDP.bind(Endpoint.any(port: const Port(0)));
      final ipAddress = InternetAddress(deviceIP);

      // Create packet with credentials
      final packet = {
        'type': _CREDENTIALS,
        'target_mac': mac,
        'payload': credentials,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      debugPrint('log: packet: $packet');

      // Encrypt the packet
      final Uint8List encryptedPacket = await encryptPayload(
        mac,
        jsonEncode(packet),
      );

      // Send the encrypted packet to the target device
      await udp.send(
        encryptedPacket,
        Endpoint.unicast(ipAddress, port: UdpService.port),
      );

      // Listen for confirmation with a timeout
      const timeoutDuration = Duration(seconds: 5); // Adjust timeout as needed
      try {
        final datagram = await udp.asStream().first.timeout(timeoutDuration);
        udp.close();
        if (datagram != null && datagram.address == ipAddress) {
          debugPrint(
            'log: Received confirmation from $deviceIP ${String.fromCharCodes(datagram.data)}',
          );

          if (String.fromCharCodes(datagram.data) ==
              'Credentials stored securely') {
            return true;
          }
        }
      } on TimeoutException {
        debugPrint('log: Timeout waiting for confirmation from $deviceIP');
        udp.close();
        return false;
      }
    } catch (e) {
      debugPrint('log: Error sending credentials to $deviceIP: $e');
      return false;
    }
    debugPrint(
      'log: Packet received is either not from the targeted device or is not a confirmation packet',
    );
    return false;
  }
}
