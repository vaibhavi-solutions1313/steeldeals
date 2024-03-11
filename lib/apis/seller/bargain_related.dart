import 'package:http/http.dart' as http;
import '../../../helpers/network_helper.dart' as R;
import '../../constants.dart';
import '../../main.dart';

class SellerBargainRelated {
  Future<R.Response> getBargainList() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.sellerBargainList));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();

    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> updateBargainPrice(String bargainId, String bargainPrice) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.sellerBargainUpdatePrice + bargainId));
    request.fields.addAll({'counter_price': bargainPrice});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();

    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> acceptBargain(String bargainId) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.sellerAcceptBargain + bargainId));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();

    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
