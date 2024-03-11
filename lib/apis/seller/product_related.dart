import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:services_provider_application/constants.dart';
import 'package:services_provider_application/main.dart';
import 'package:services_provider_application/views/seller/models/product_size_model.dart';
import '../../helpers/network_helper.dart' as R;

class ProductsRelate {
  // Future<R.Response> addProduct(
  //     String name, List size, String price, String random, String clearCut, String catId, String width, String thickness, String height, String diameter) async {
  //   print("$name,$size,$price,$random,$clearCut");
  //   print(myConstants.bearerToken);
  //   var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
  //   var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.sellerAddProduct));
  //   request.fields.addIf(name.isNotEmpty, 'name', name);
  //   request.fields.addIf(price.isNotEmpty, 'price', price);
  //   request.fields.addIf(random.isNotEmpty, 'random', random);
  //   request.fields.addIf(size.isNotEmpty, 'sizes[]', size.join(', '));
  //   request.fields.addIf(catId.isNotEmpty, 'category_id', catId);
  //   request.fields.addIf(clearCut.isNotEmpty, 'clear_cut', clearCut);
  //   request.fields.addIf(width.isNotEmpty, 'width_in_mm', width);
  //   request.fields.addIf(thickness.isNotEmpty, 'thickness_in_mm', thickness);
  //   request.fields.addIf(height.isNotEmpty, 'height_in_mm', height);
  //   request.fields.addIf(diameter.isNotEmpty, 'diameter_in_mm', diameter);
  //
  //   print(request.fields);
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   String responseBody = await response.stream.bytesToString();
  //   return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  // }

  Future<R.Response> addProduct(
    String categoryId,
    String productName,
    String productDesc,
    String productPricePerKg,
    String productPricePerMt,
    String gstPercent,
    String productPriceType,
    String random,
    String clearCut,
    String imagePath,
    List<Size> selectedSizesList,
  ) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.sellerAddProduct));
    request.fields.addIf(categoryId.isNotEmpty, "category_id", categoryId);
    request.fields.addIf(productName.isNotEmpty, "name", productName);
    request.fields.addIf(productPricePerKg.isNotEmpty, "price_per_kg", productPricePerKg);
    request.fields.addIf(productPricePerKg.isNotEmpty, "price_per_mt", productPricePerMt);
    request.fields.addIf(gstPercent.isNotEmpty, "gst", gstPercent);
    request.fields.addIf(random.isNotEmpty, "random", random);
    request.fields.addIf(clearCut.isNotEmpty, "clear_cut", clearCut);
    request.fields.addIf(productDesc.isNotEmpty, "description", productDesc);
    request.fields.addIf(productPriceType.isNotEmpty, "price_type", productPriceType);

    selectedSizesList.asMap().forEach((index, element) {
      if (element.widthInMm != null) {
        request.fields.addIf(element.widthInMm != null, "sizes[$index][size][width_in_mm]", element.widthInMm!);
      }
      if (element.heightInMm != null) {
        request.fields.addIf(element.heightInMm != null, "sizes[$index][size][height_in_mm]", element.heightInMm!);
      }
      if (element.thicknessInMm != null) {
        request.fields.addIf(element.thicknessInMm != null, "sizes[$index][size][thickness_in_mm]", element.thicknessInMm!);
      }
      if (element.diameterInMm != null) {
        request.fields.addIf(element.diameterInMm != null, "sizes[$index][size][diameter_in_mm]", element.diameterInMm!);
      }
      if (element.lengthInMm != null) {
        request.fields.addIf(element.lengthInMm != null, "sizes[$index][size][length_in_mm]", element.lengthInMm!);
      }
      if (element.description != null) {
        request.fields.addIf(element.description != null, "sizes[$index][size][description]", element.description!);
      }
      request.fields.addIf(element.price != null, "sizes[$index][price]", element.price!);
    });

    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  /// SEEMS INCORRECT API, NO BEARER TOKEN FOUND
  Future<R.Response> getSizeList() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.sellerProductSizeList));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();

    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> getCategories() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.sellerCategoryList));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();

    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> getProductsList() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.sellerProductsList));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();

    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> deleteProduct(String productId) async {
    print(Constants.baseUrl + Constants.deleteProduct + '$productId');
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('POST', Uri.parse(Constants.baseUrl + Constants.deleteProduct + '$productId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();

    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> updateProduct(String productId, String name, String price, String random, String clearCut, String description, String imagePath) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.updateProduct + '$productId'));

    request.fields.addAll({
      'name': name,
      'price': price,
      'random': random,
      "clear_cut": clearCut,
      // "description": description
    });
    request.headers.addAll(headers);

    if (imagePath.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();
    print(responseBody);
    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> updateProductSizePrice(String productId, String price, String sizeId) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.updateProductSize));

    request.fields.addAll({
      'product_id': productId,
      'size_id': sizeId,
      'price': price
      // "description": description
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();
    print(responseBody);
    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> updateStock(String stockId, String productId, String basePrice, String brandType, String sizeId, String length, String loadingAmount, String quantity,
      List<String> imagePath) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.updateStock));

    request.fields.addAll({
      "id": stockId,
      'product_id': productId,
      'basic_price': basePrice,
      'brand_type': brandType,
      'size_id': sizeId,
      'length': length,
      'loading_amount': loadingAmount,
      'quantity': quantity,
    });

    if (imagePath.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('product_image[]', imagePath.join(', ')));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();
    print(responseBody);
    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> getProductOrdersList() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.sellerProductOrderList));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();

    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> addStock(String productId, String productBasePrice, String isiOrNot, String size, String length, String loadingAmount, String quantity,
      String description, List<XFile> imagePaths) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.sellerAddStock));
    request.fields.addAll({
      'product_id': productId,
      'basic_price': productBasePrice,
      'brand_type': isiOrNot,
      'size_id': size,
      'length': length,
      'loading_amount': loadingAmount,
      'quantity': quantity,
      // 'description': description
    });

    for (var a in imagePaths) {
      print(a.path);
      request.files.add(await http.MultipartFile.fromPath('product_image[]', a.path));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();
    print(responseBody);
    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> addCategory(String name, String description, String width, String thickness, String height, String diameter, String imagePath, String length) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.sellerAddCategory));
    request.fields.addIf(name.isNotEmpty, 'name', name);
    request.fields.addIf(description.isNotEmpty, 'description', description);
    request.fields.addIf(width.isNotEmpty, 'measurement_attributes[]', width);
    request.fields.addIf(thickness.isNotEmpty, 'measurement_attributes[]', thickness);
    request.fields.addIf(height.isNotEmpty, 'measurement_attributes[]', height);
    request.fields.addIf(diameter.isNotEmpty, 'measurement_attributes[]', diameter);
    request.fields.addIf(diameter.isNotEmpty, 'measurement_attributes[]', diameter);
    request.fields.addIf(length.isNotEmpty, 'measurement_attributes[]', length);
    request.files.addIf(imagePath.isNotEmpty, await http.MultipartFile.fromPath('image', imagePath));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> addMoreProductSizes(
    String productId,
    List<Size> selectedSizesList,
  ) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.sellerAddMoreProductSize));
    request.fields.addIf(productId.isNotEmpty, "product_id", productId);

    selectedSizesList.asMap().forEach((index, element) {
      if (element.widthInMm != null) {
        request.fields.addIf(element.widthInMm != null, "sizes[$index][size][width_in_mm]", element.widthInMm!);
      }
      if (element.heightInMm != null) {
        request.fields.addIf(element.heightInMm != null, "sizes[$index][size][height_in_mm]", element.heightInMm!);
      }
      if (element.thicknessInMm != null) {
        request.fields.addIf(element.thicknessInMm != null, "sizes[$index][size][thickness_in_mm]", element.thicknessInMm!);
      }
      if (element.diameterInMm != null) {
        request.fields.addIf(element.diameterInMm != null, "sizes[$index][size][diameter_in_mm]", element.diameterInMm!);
      }
      if (element.lengthInMm != null) {
        request.fields.addIf(element.lengthInMm != null, "sizes[$index][size][length_in_mm]", element.lengthInMm!);
      }
      request.fields.addIf(element.price != null, "sizes[$index][price]", element.price!);
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<R.Response> getSellerBanners() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.sellerGetBanners));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();

    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
