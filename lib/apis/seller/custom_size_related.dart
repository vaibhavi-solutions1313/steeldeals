import 'package:http/http.dart' as http;
import 'package:services_provider_application/constants.dart';
import '../../helpers/network_helper.dart' as R;
import '../../main.dart';

class SellerCustomSizeRequestsApis {
  Future<R.Response> getRequestsList() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('GET', Uri.parse(Constants.baseUrl + Constants.sellerSizeRequestLists));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> updateStatus(String statusUpdate, String id) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.sellerSizeRequestUpdate + '$id/handle'));
    request.fields.addAll({'status': statusUpdate});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
