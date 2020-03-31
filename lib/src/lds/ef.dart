//  Created by smlu, copyright © 2020 ZeroPass. All rights reserved.

import 'dart:typed_data';
import 'package:meta/meta.dart';
import 'tlv.dart';

class EfParseError implements Exception {
  String message;
  EfParseError(this.message);
  String toString() => message;
}

abstract class ElementaryFile{

  int get fid; // file id
  int get sfi; // short file id
  final Uint8List _encoded;

  ElementaryFile.fromBytes(final Uint8List data) : _encoded = data {
    parse(data);
  }

  Uint8List toBytes() {
    return _encoded;
  }

  @protected
  void parse(final Uint8List content) {}
}