// Created by smlu, copyright © 2020 ZeroPass. All rights reserved.
import 'dart:io';
import 'dart:typed_data';
import 'package:dmrtd/dmrtd.dart';
import 'package:dmrtd/extensions.dart';
import 'package:logging/logging.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';


enum NfcStatus {
  notSupported,
  disabled,
  enabled
}


class NfcProviderError extends ComProviderError {
  NfcProviderError([String message = ""]) : super(message);
  NfcProviderError.fromException(Exception e) : super(e.toString());

  @override
  String toString() => 'NfcProviderError: $message';
}


class NfcProvider extends ComProvider {
  static final _log = Logger('nfc.provider');
  NfcProvider() : super(_log);

  NFCTag _tag;

  /// On iOS, sets NFC reader session alert message.
  Future<void> setIosAlertMessage(String message) async {
    if(Platform.isIOS) {
      return await FlutterNfcKit.setIosAlertMessage(message);
    }
  }

  static Future<NfcStatus> get nfcStatus async {
    NFCAvailability a = await FlutterNfcKit.nfcAvailability;
    switch(a) {
      case NFCAvailability.not_supported: return NfcStatus.notSupported;
      case NFCAvailability.disabled:      return NfcStatus.disabled;
      case NFCAvailability.available:     return NfcStatus.enabled;
    }
  }

  @override
  Future<void> connect({ String iosAlertMessage }) async {
    if(isConnected()) {
      return;
    }

    try {
      _tag = await FlutterNfcKit.poll(iosAlertMessage: iosAlertMessage);
      if(_tag.type != NFCTagType.iso7816) {
        _log.info("Ignoring non ISO-7816 tag: ${_tag.type}");
        return await disconnect();
      }
    } on Exception catch(e) {
      throw NfcProviderError.fromException(e);
    }
  }

  @override
  Future<void> disconnect({ String iosAlertMessage, String iosErrorMessage }) async {
    if(isConnected()) {
      _log.debug("Disconnecting");
      try {
        _tag = null;
        return await FlutterNfcKit.finish(
          iosAlertMessage: iosAlertMessage,
          iosErrorMessage: iosErrorMessage
        );
      } on Exception catch(e) {
        throw NfcProviderError.fromException(e);
      }
    }
  }

  @override
  bool isConnected() {
    return _tag != null;
  }

  @override
  Future<Uint8List> transceive(final Uint8List data) async {
    try {
      String r = await FlutterNfcKit.transceive(data.hex());
      return r.parseHex();
    } catch(e) {
      throw NfcProviderError.fromException(e);
    }
  }
}