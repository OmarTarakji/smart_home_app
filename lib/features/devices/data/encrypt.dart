import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:pointycastle/export.dart';

/// Encrypts the payload using AES-128-CBC and signs it with HMAC-SHA256.
Future<Uint8List> encryptPayload(String macAddress, String jsonPayload) async {
  // print('ENCRYPT FUNCTION CALLED');
  // print('--- FLUTTER: Starting Encryption ---');
  final upperMac = macAddress.toUpperCase();
  // print('FLUTTER: MAC for Key Derivation: $upperMac');

  // 1. Derive keys from MAC address string
  final sha256 = crypto.sha256.convert(utf8.encode(upperMac));
  final hashBytes = Uint8List.fromList(sha256.bytes);
  // print('FLUTTER: SHA-256 Hash: ${_bytesToHex(hashBytes)}');

  final aesKey = Uint8List.fromList(hashBytes.sublist(0, 16));
  final hmacKey = Uint8List.fromList(hashBytes);
  // print('FLUTTER: AES Key: ${_bytesToHex(aesKey)}');
  // print('FLUTTER: HMAC Key: ${_bytesToHex(hmacKey)}');

  // 2. Generate a random 16-byte IV
  final iv = Uint8List(16);
  final random = Random.secure();
  for (int i = 0; i < iv.length; i++) {
    iv[i] = random.nextInt(256);
  }
  // print('FLUTTER: IV: ${_bytesToHex(iv)}');

  // 3. Prepare the payload
  final plaintext = Uint8List.fromList(utf8.encode(jsonPayload));
  // print('FLUTTER: Plaintext: $jsonPayload');
  // print('FLUTTER: Plaintext HEX: ${_bytesToHex(plaintext)}');

  // 4. Encrypt the data using AES-128-CBC with PKCS7 padding
  final cbc = CBCBlockCipher(AESEngine())
    ..init(true, ParametersWithIV(KeyParameter(aesKey), iv));
  final paddedPlaintext = _pkcs7pad(plaintext, 16);
  // print('FLUTTER: Padded Plaintext: ${_bytesToHex(paddedPlaintext)}');

  // FIX: Encrypt all blocks, not just one
  Uint8List encryptedData = Uint8List(paddedPlaintext.length);
  int offset = 0;
  while (offset < paddedPlaintext.length) {
    offset += cbc.processBlock(paddedPlaintext, offset, encryptedData, offset);
  }
  // print('FLUTTER: Encrypted Data: ${_bytesToHex(encryptedData)}');

  // 5. Create HMAC signature
  final hmac = crypto.Hmac(crypto.sha256, hmacKey);
  final hmacInput = Uint8List.fromList(iv + encryptedData);
  // print('FLUTTER: HMAC Input (IV+Cipher): ${_bytesToHex(hmacInput)}');

  final hmacSignature = hmac.convert(hmacInput).bytes;
  // print(
  //   'FLUTTER: HMAC Signature: ${_bytesToHex(Uint8List.fromList(hmacSignature))}',
  // );

  // 6. Assemble the final packet: IV + Encrypted Data + HMAC
  final finalPacket = Uint8List.fromList(iv + encryptedData + hmacSignature);
  // print('FLUTTER: Payload JSON: $jsonPayload');
  // print('FLUTTER: Payload length: ${jsonPayload.length}');
  // print('FLUTTER: Padded Plaintext length: ${paddedPlaintext.length}');
  // print('FLUTTER: Encrypted Data length: ${encryptedData.length}');
  // print('FLUTTER: Final UDP Packet length: ${finalPacket.length}');
  // print('FLUTTER: Final UDP Packet: ${_bytesToHex(finalPacket)}');
  // print('--- FLUTTER: Encryption Finished ---');

  return finalPacket;
}

// Helper function for PKCS7 padding
Uint8List _pkcs7pad(Uint8List data, int blockSize) {
  final padLength = blockSize - (data.length % blockSize);
  final padded = Uint8List(data.length + padLength)..setAll(0, data);
  for (int i = data.length; i < padded.length; i++) {
    padded[i] = padLength;
  }
  return padded;
}
