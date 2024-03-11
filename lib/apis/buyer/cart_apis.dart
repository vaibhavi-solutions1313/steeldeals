import 'package:get/get.dart';

import '../../constants.dart';
import '../../helpers/network_helper.dart' as RR;
import '../../main.dart';
import 'package:http/http.dart' as http;

class CartApis {
  Future<RR.Response> addToCart(String productId, String stockId, List SizeId, String quantity, String price, String type) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    print(headers);
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.buyerCart));
    request.fields.addIf(productId.isNotEmpty, 'product_id', productId);
    request.fields.addIf(stockId.isNotEmpty, 'stock_id', stockId);

    // ADDING MULTI SIZES
    SizeId.forEach((element) {
      print(element['id']);
      request.fields.addIf(SizeId.isNotEmpty, 'size_id[]', element['id'].toString());
    });
    request.fields.addIf(quantity.isNotEmpty, 'qty', quantity);
    request.fields.addIf(price.isNotEmpty, 'price', price);
    request.fields.addIf(type.isNotEmpty, 'type', type); // basic, random, clearcut

    print(request.fields);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> getCartItems() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.buyerCartList));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> removeItem(String id) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('POST', Uri.parse(Constants.baseUrl + Constants.buyerRemoveItemCart + id));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> emptyCart() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('POST', Uri.parse(Constants.baseUrl + Constants.buyerEmptyCart));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
