import 'package:get/get.dart';

import '../../constants.dart';
import '../../helpers/network_helper.dart' as NH;
import 'package:http/http.dart' as http;
import '../../main.dart';

class BuyerProductApis {

  Future<NH.Response> getProductsByCatId(String catId) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.buyerProductsByCatId + catId));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return NH.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<NH.Response> getProductsByProductId(String productId) async {
    print('Calling getProductsByProductId method...');
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('GET', Uri.parse(Constants.baseUrl + Constants.buyerProductsByProductId + productId));

    request.headers.addAll(headers);
    // request.fields['productId'] = productId;
    print(request);
    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print("Response: $responseBody");
    return NH.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<NH.Response> getFilteredProducts(String minPrice, String maxPrice, String certifyType, String quantity) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.buyerProductFilter));
    request.fields.addIf(certifyType.isNotEmpty, 'brand_type', certifyType);
    request.fields.addIf(minPrice.isNotEmpty, 'min_price', minPrice);
    request.fields.addIf(maxPrice.isNotEmpty, 'max_price', maxPrice);
    request.fields.addIf(quantity.isNotEmpty, 'qty', quantity);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return NH.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<NH.Response> counterPrice(String productId, String stockId, String sizeId, String counterPrice, String quantity) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.buyerProductCounterPrice));
    request.fields.addAll({'product_id': productId, 'stock_id': stockId, 'size_id': sizeId, 'counter_price': counterPrice, 'counter_qty': quantity});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return NH.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
