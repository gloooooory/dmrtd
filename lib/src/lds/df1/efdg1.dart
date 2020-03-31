//  Created by smlu, copyright © 2020 ZeroPass. All rights reserved.
import 'dart:typed_data';

import 'dg.dart';
import '../ef.dart';
import '../mrz.dart';
import '../tlv.dart';

class EfDG1 extends DataGroup {
  static const FID = 0x0101;
  static const SFI = 0x01;
  static const TAG = DgTag(0x61);

  MRZ _mrz;
  MRZ get mrz => _mrz;

  EfDG1.fromBytes(Uint8List data) : super.fromBytes(data);

  @override
  int get fid => FID;
  
  @override
  int get sfi => SFI;

  @override
  int get tag => TAG.value;

  @override
  void parseContent(final Uint8List content) {
    final tlv = TLV.fromBytes(content);
    if(tlv.tag != 0x5F1F) {
      throw EfParseError(
        "Invalid data object tag=${tlv.tag.toRadixString(16)}, expected object with tag=5F1F"
      );
    }
    _mrz = MRZ(tlv.value);
  }
}
