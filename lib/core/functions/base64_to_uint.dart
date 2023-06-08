import 'dart:convert';
import 'dart:typed_data';

Uint8List ImageFromBase64String(String base64String) {
  return Base64Decoder().convert(base64String);
}