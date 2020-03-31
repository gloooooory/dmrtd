//  Created by smlu, copyright © 2020 ZeroPass. All rights reserved.
import 'dart:typed_data';
import 'dg.dart';

class EfDG3 extends DataGroup {
  static const FID = 0x0103;
  static const SFI = 0x03;
  static const TAG = DgTag(0x63);

  EfDG3.fromBytes(Uint8List data) : super.fromBytes(data);

  @override
  int get fid => FID;
  
  @override
  int get sfi => SFI;

  @override
  int get tag => TAG.value;
}
