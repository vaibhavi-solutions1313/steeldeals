import '../../constants.dart';
import '../../helpers/network_helper.dart' as RR;
import 'package:http/http.dart' as http;
import '../main.dart';

class ChatApis {
  Future<RR.Response> getChatList() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.chatList));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> getMsgs(String userId) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.chatMsgs + userId));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> sendMsg(String userId, String msg) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.chatSendMsg));
    request.fields.addAll({'user_id': userId, 'message': msg});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> deleteMsg(String msgId) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('DELETE', Uri.parse(Constants.baseUrl + Constants.chatDelete + msgId + '/delete'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
