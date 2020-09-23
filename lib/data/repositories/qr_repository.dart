
import '../sources/remote/base/api_caller.dart';

abstract class QrRepository{
  Future<String> updateQR();
}

class QrDataRepository extends QrRepository{
  @override
  Future<String> updateQR() async{
    final extractedData = await APICaller.getData("/refresh-qr", authorizedHeader: true);
    return extractedData["device"]["qr_code"];
  }

}