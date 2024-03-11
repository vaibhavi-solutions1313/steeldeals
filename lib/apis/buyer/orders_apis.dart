import '../../constants.dart';
import '../../helpers/network_helper.dart' as RR;
import 'package:http/http.dart' as http;
import '../../main.dart';

class OrderApis {
  Future<RR.Response> getOrdersList() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.buyerOrdersLists));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> getPendingOrdersList() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.buyerPendingOrdersLists));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
