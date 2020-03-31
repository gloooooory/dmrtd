//  Created by smlu, copyright © 2020 ZeroPass. All rights reserved.
import 'package:dmrtd/extensions.dart';

// Class contains information eMRTD application applet (DF1)
class DF1 {
  // See: Section 3.1 https://www.icao.int/publications/Documents/9303_p10_cons_en.pdf
  static final AID  = "A0000002471001".parseHex();
  static const name = "eMRTD Application";
}