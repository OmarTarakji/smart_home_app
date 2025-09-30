import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:smart_home/core/utils/exceptions.dart';
import 'package:smart_home/features/fingerprint/domain/add_fingerprint_response.dart';
import 'package:smart_home/features/fingerprint/domain/add_fingerprint_state.dart';
import 'package:udp/udp.dart';

import '../../devices/data/encrypt.dart';
import '../../devices/data/udp_service.dart';

class FingerprintUdpService extends UdpService {
  static const String _ADD_FINGERPRINT = 'add fingerprint';
  static const String _DELETE_FINGERPRINT = 'delete fingerprint';
  static const String _DELETE_ALL_FINGERPRINTS = 'delete all fingerprints';
  static const String _COMMAND = 'Command';

  Stream<AddFingerprintResponse> startFingerprintAddingSequence({
    required String apiKey,
    required String name,
    required int sensorId,
    required String deviceIP,
    required String mac,
  }) async* {
    // Bind UDP socket to any available port
    final UDP udp = await UDP.bind(Endpoint.any(port: const Port(0)));
    final ipAddress = InternetAddress(deviceIP);

    // Create packet with credentials
    final packet = {
      'target_mac': mac,
      'type': _COMMAND,
      'payload': {
        'api_key': apiKey,
        'command': _ADD_FINGERPRINT,
        'name': name,
        'sensor_id': sensorId,
      },
    };
    final jsonPacket = jsonEncode(packet);
    debugPrint('log: packet: $jsonPacket, length: ${jsonPacket.length}');

    // Encrypt the packet
    final Uint8List encryptedPacket = await encryptPayload(
      mac,
      jsonEncode(packet),
    );
    debugPrint('LOG: encrypted packet: ${encryptedPacket.length}');

    // Send the encrypted packet to the target device
    await udp.send(
      encryptedPacket,
      Endpoint.unicast(ipAddress, port: UdpService.port),
    );
    //==============================================================================
    // Listen for confirmation with a timeout
    const timeoutDuration = Duration(seconds: 60); // Adjust timeout as needed
    try {
      final stream = udp.asStream().timeout(timeoutDuration);
      await for (var datagram in stream) {
        if (datagram != null && datagram.address == ipAddress) {
          debugPrint(
            'log: Received confirmation from $deviceIP ${String.fromCharCodes(datagram.data)}',
          );
          final response = String.fromCharCodes(datagram.data);
          final json = jsonDecode(response);

          if (json['status'] == 'info') {
            if (json['message'] == 'Started') {
              yield AddFingerprintResponse(AddFpState.started);
            }
            if (json['message'] == 'Remove your finger') {
              yield AddFingerprintResponse(AddFpState.removeFinger);
            }
            if (json['message'] == 'Place the same finger again') {
              yield AddFingerprintResponse(AddFpState.placeFinger);
            }
          } else if (json['status'] == 'success') {
            yield AddFingerprintResponse.success(int.parse(json['id']));
            udp.close();
            return; // Exit the stream processing
          } else if (json['status'] == 'error') {
            throw FingerprintException(
              'Failed to add fingerprint',
              json['message'],
            );
          }
        }
      }
    } on TimeoutException {
      udp.close();
      throw FingerprintException(
        'Failed to start process',
        'Timeout waiting for confirmation from $deviceIP',
      );
    }

    throw const FingerprintException(
      'Failed to start process',
      'Packet received is either not from the targeted device or is not a confirmation packet',
    );
  }

  Future<String?> getDeviceIpByMac(String targetMac) async {
    final UDP udp = await UDP.bind(Endpoint.any(port: const Port(0)));
    final completer = Completer<String?>();
    StreamSubscription<Datagram?>? subscription;

    try {
      final packet = Uint8List.fromList(
        utf8.encode(
          jsonEncode({
            'type': UdpService.DISCOVER,
            'app': 'com.omar.smart_home',
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          }),
        ),
      );
      await udp.send(packet, Endpoint.broadcast(port: UdpService.port));

      subscription = udp.asStream().listen((datagram) {
        if (datagram != null) {
          final response = String.fromCharCodes(datagram.data);
          final deviceJson = jsonDecode(response);
          if (deviceJson['mac_address'] == targetMac) {
            final foundIp = datagram.address.address;
            debugPrint('LOG: found IP: $foundIp');
            if (!completer.isCompleted) {
              completer.complete(foundIp);
            }
          }
        }
      });

      return await Future.any([
        completer.future,
        Future.delayed(const Duration(seconds: 5)).then((_) => null),
      ]);
    } finally {
      await subscription?.cancel();
      udp.close();
    }
  }

  Future<void> deleteFingerprint({
    required String apiKey,
    required int fingerprintId,
    required int sensorId,
    required String deviceIP,
    required String mac,
  }) async {
    // Bind UDP socket to any available port
    final UDP udp = await UDP.bind(Endpoint.any(port: const Port(0)));
    final ipAddress = InternetAddress(deviceIP);

    // Create packet with credentials
    final packet = {
      'target_mac': mac,
      'type': _COMMAND,
      'payload': {
        'api_key': apiKey,
        'command': _DELETE_FINGERPRINT,
        'fingerprint_id': fingerprintId,
        'sensor_id': sensorId,
      },
    };
    final jsonPacket = jsonEncode(packet);
    debugPrint('log: packet: $jsonPacket, length: ${jsonPacket.length}');

    // Encrypt the packet
    final Uint8List encryptedPacket = await encryptPayload(
      mac,
      jsonEncode(packet),
    );
    debugPrint('LOG: encrypted packet: ${encryptedPacket.length}');

    // Send the encrypted packet to the target device
    await udp.send(
      encryptedPacket,
      Endpoint.unicast(ipAddress, port: UdpService.port),
    );

    // Listen for confirmation with a timeout
    const timeoutDuration = Duration(seconds: 10); // Adjust timeout as needed
    try {
      final datagram = await udp.asStream().first.timeout(timeoutDuration);
      udp.close();
      if (datagram != null && datagram.address == ipAddress) {
        debugPrint(
          'log: Received confirmation from $deviceIP ${String.fromCharCodes(datagram.data)}',
        );
        final response = String.fromCharCodes(datagram.data);
        final json = jsonDecode(response);
        debugPrint('LOG: Delete response: $json');

        if (json['status'] == 'success') {
          return;
        } else {
          throw FingerprintException(
            'Failed to delete fingerprint',
            json['message'],
          );
        }
      }
    } on TimeoutException {
      udp.close();
      throw FingerprintException(
        'Failed to start process',
        'Timeout waiting for confirmation from $deviceIP',
      );
    }

    throw const FingerprintException(
      'Failed to start process',
      'Packet received is either not from the targeted device or is not a confirmation packet',
    );
  }

  Future<void> deleteAllFingerprints({
    required String apiKey,
    required int sensorId,
    required String deviceIP,
    required String mac,
  }) async {
    // Bind UDP socket to any available port
    final UDP udp = await UDP.bind(Endpoint.any(port: const Port(0)));
    final ipAddress = InternetAddress(deviceIP);

    // Create packet with credentials
    final packet = {
      'target_mac': mac,
      'type': _COMMAND,
      'payload': {
        'api_key': apiKey,
        'command': _DELETE_ALL_FINGERPRINTS,
        'sensor_id': sensorId,
      },
    };
    final jsonPacket = jsonEncode(packet);
    debugPrint('log: packet: $jsonPacket, length: ${jsonPacket.length}');

    // Encrypt the packet
    final Uint8List encryptedPacket = await encryptPayload(
      mac,
      jsonEncode(packet),
    );
    debugPrint('LOG: encrypted packet: ${encryptedPacket.length}');

    // Send the encrypted packet to the target device
    await udp.send(
      encryptedPacket,
      Endpoint.unicast(ipAddress, port: UdpService.port),
    );

    // Listen for confirmation with a timeout
    const timeoutDuration = Duration(seconds: 10); // Adjust timeout as needed
    try {
      final datagram = await udp.asStream().first.timeout(timeoutDuration);
      udp.close();
      if (datagram != null && datagram.address == ipAddress) {
        debugPrint(
          'log: Received confirmation from $deviceIP ${String.fromCharCodes(datagram.data)}',
        );
        final response = String.fromCharCodes(datagram.data);
        final json = jsonDecode(response);
        debugPrint('LOG: Delete response: $json');

        if (json['status'] == 'success') {
          return;
        } else {
          throw FingerprintException(
            'Failed to delete fingerprint',
            json['message'],
          );
        }
      }
    } on TimeoutException {
      udp.close();
      throw FingerprintException(
        'Failed to start process',
        'Timeout waiting for confirmation from $deviceIP',
      );
    }

    throw const FingerprintException(
      'Failed to start process',
      'Packet received is either not from the targeted device or is not a confirmation packet',
    );
  }
}
