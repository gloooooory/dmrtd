//  Created by smlu, copyright © 2020 ZeroPass. All rights reserved.
import 'dart:typed_data';
import 'dg.dart';

/// As specified in ICAO9303-p10 is not used and reserved for future.
class EfDG6 extends DataGroup {
  static const FID = 0x0106;
  static const SFI = 0x06;
  static const TAG = DgTag(0x66);

  EfDG6.fromBytes(Uint8List data) : super.fromBytes(data);

  @override
  int get fid => FID;
  
  @override
  int get sfi => SFI;

  @override
  int get tag => TAG.value;
}