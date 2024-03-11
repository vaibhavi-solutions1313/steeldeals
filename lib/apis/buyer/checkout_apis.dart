import 'package:http/http.dart' as http;
import 'package:services_provider_application/views/payment_method_view.dart';
import '../../constants.dart';
import '../../helpers/network_helper.dart' as RR;
import '../../main.dart';

class CheckoutApi {
  Future<RR.Response> placeOrder() async {
    checkoutController.payModeSelected.value = "cod"; // Static

    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.buyerCheckout));

    request.fields.addAll({
      // 'delivery_charge': '60',
      'payment_method': checkoutController.payModeSelected.value,
      'address_id': customerAddControl.defaultAddressMap()['id'].toString(),
      'bank_name': paymentMethodControl.bankName.text,
      'acc_no': paymentMethodControl.accountNumber.text,
      'acc_holder_name': paymentMethodControl.accountHolderName.text,
      'ifsc': paymentMethodControl.ifsc.text,
      'branch': paymentMethodControl.branch.text,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);

  }

  Future downloadFileRequest($fileName,$url)async{

  }
}
