//  Created by smlu, copyright © 2020 ZeroPass. All rights reserved.
import 'dart:typed_data';
import 'dg.dart';

class EfDG16 extends DataGroup {
  static const FID = 0x0110;
  static const SFI = 0x10;
  static const TAG = DgTag(0x70);

  EfDG16.fromBytes(Uint8List data) : super.fromBytes(data);

  @override
  int get fid => FID;
  
  @override
  int get sfi => SFI;

  @override
  int get tag => TAG.value;
}