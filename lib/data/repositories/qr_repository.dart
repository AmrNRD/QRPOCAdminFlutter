
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../main.dart';
import '../sources/remote/base/api_caller.dart';

abstract class QrRepository{
  Future<String> updateQR();
}

class QrDataRepository extends QrRepository{
  @override
  Future<String> updateQR() async{

    final extractedData = await APICaller.postData("/refresh-qr",body: {'firebase_token':Root.firebaseToken}, authorizedHeader: true);
    String qrCode=extractedData["device"]["qr_code"];
    return qrCode;
  }



  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
}