import 'package:http/http.dart' as http;
import 'package:services_provider_application/constants.dart';
import '../../helpers/network_helper.dart';
import '../../main.dart';

class HomeApis {
  Future<Response> getAllProducts() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('GET', Uri.parse(Constants.baseUrl + Constants.buyerAllProducts));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<Response> searchProduct(String search) async {
    var headers = {
      'Authorization': myConstants.bearerToken
    };
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.searchProduct+ search));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase,serverStatusCode: response.statusCode);
  }

  Future<Response> getBanners() async {
    var headers = {
      'Authorization': "Bearer "+myConstants.bearerToken
    };
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.buyerHomeBanners));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase,serverStatusCode: response.statusCode);
  }

  Future<Response> getCategories() async {
    var headers = {
      'Authorization': myConstants.bearerToken
    };
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.categoryList));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase,serverStatusCode: response.statusCode);
  }

  Future<Response> getStores() async {
    var headers = {
      'Authorization': myConstants.bearerToken
    };
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.buyerStoresList));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase,serverStatusCode: response.statusCode);
  }

  Future<Response> getTransports() async {
    var headers = {
      'Authorization': myConstants.bearerToken
    };
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.transportList));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase,serverStatusCode: response.statusCode);
  }

  Future<Response> getStoreCategoriesById(String StoreId) async {
    var headers = {
      'Authorization': "Bearer "+myConstants.bearerToken
    };
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.buyerCategoriesByStoreId + "$StoreId/category/list"));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase,serverStatusCode: response.statusCode);
  }

  Future<Response> getStoreProductsById(String StoreId) async {
    var headers = {
      'Authorization': myConstants.bearerToken
    };
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.buyerProductsByStoreId + "$StoreId"));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase,serverStatusCode: response.statusCode);
  }

}