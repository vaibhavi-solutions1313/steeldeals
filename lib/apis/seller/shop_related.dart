import 'package:get/get.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/main.dart';
import '../../helpers/network_helper.dart' as NH;
import 'package:http/http.dart' as http;

class ShopRelate {
  /// time format 24:00
  Future<NH.Response> createShop(
      String shopName,
      String shopNumber,
      String shopDescription,
      String shopAddress,
      String openTime,
      String closeTime,
      String mobileNumber,
      String shopImgPath,
      String bannerImgPath,
      String shopVideoPath) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest(
        'POST', Uri.parse(Constants.baseUrl + Constants.sellerCreateShop));
    request.fields.addAll({
      'shop_name': shopName,
      'shop_number': shopNumber,
      'description': shopDescription,
      'address': shopAddress,
      'open_time': openTime,
      'close_time': closeTime,
      'mobile': mobileNumber
    });

    request.files
        .add(await http.MultipartFile.fromPath('shop_image', shopImgPath));
    request.files
        .add(await http.MultipartFile.fromPath('banner[]', bannerImgPath));
    request.files
        .add(await http.MultipartFile.fromPath('shop_video', shopVideoPath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print("responseee"+responseBody);
    return NH.Response(
        responseBody: responseBody,
        responseStatusCode: response.statusCode,
        serverStatusText: response.reasonPhrase,
        serverStatusCode: response.statusCode);
  }

  Future<NH.Response> getShopInfo() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request(
        'GET', Uri.parse(Constants.baseUrl + Constants.sellerMyShopInfo));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return NH.Response(
        responseBody: responseBody,
        responseStatusCode: response.statusCode,
        serverStatusText: response.reasonPhrase,
        serverStatusCode: response.statusCode);
  }

  Future<NH.Response> getShopTimings() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request(
        'GET', Uri.parse(Constants.baseUrl + Constants.sellerStoreTimings));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return NH.Response(
        responseBody: responseBody,
        responseStatusCode: response.statusCode,
        serverStatusText: response.reasonPhrase,
        serverStatusCode: response.statusCode);
  }

  Future<NH.Response> postShopTimings(String openTime, String closeTime) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST',
        Uri.parse(Constants.baseUrl + Constants.sellerStoreTimingsUpdate));
    request.fields.addAll({'open_time': openTime, 'close_time': closeTime});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return NH.Response(
        responseBody: responseBody,
        responseStatusCode: response.statusCode,
        serverStatusText: response.reasonPhrase,
        serverStatusCode: response.statusCode);
  }

  Future<NH.Response> postShopGenInfo(String storeId) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            Constants.baseUrl + Constants.sellerStoreGenUpdate + storeId));

    request.fields.addIf(addShopController.shopName.text.isNotEmpty,
        "shop_name", addShopController.shopName.text);
    request.fields.addIf(addShopController.shopDescription.text.isNotEmpty,
        "description", addShopController.shopDescription.text);
    request.fields.addIf(addShopController.phoneNumber.text.isNotEmpty,
        "mobile", addShopController.phoneNumber.text);
    request.fields.addIf(addShopController.address.text.isNotEmpty, "address",
        addShopController.address.text);
    request.fields.addIf(
        customerAddControl.addressDraggedCoordinates.value.latitude != 30.7333,
        "latitude",
        customerAddControl.addressDraggedCoordinates.value.latitude.toString());
    request.fields.addIf(
        customerAddControl.addressDraggedCoordinates.value.longitude != 76.7794,
        "longitude",
        customerAddControl.addressDraggedCoordinates.value.longitude
            .toString());
    if (addShopController.shopProfilePicPath.isNotEmpty)
      request.files.addIf(
          addShopController.isShopProfilePicSelected,
          await http.MultipartFile.fromPath(
              'shop_image[0]', addShopController.shopProfilePicPath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return NH.Response(
        responseBody: responseBody,
        responseStatusCode: response.statusCode,
        serverStatusText: response.reasonPhrase,
        serverStatusCode: response.statusCode);
  }

  Future<NH.Response> updateShopOpenStatus(String status) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest(
        'POST', Uri.parse(Constants.baseUrl + Constants.sellerShopOpenStatus));
    request.fields.addAll({'status': status});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return NH.Response(
        responseBody: responseBody,
        responseStatusCode: response.statusCode,
        serverStatusText: response.reasonPhrase,
        serverStatusCode: response.statusCode);
  }
}
