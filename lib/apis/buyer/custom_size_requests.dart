import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../helpers/network_helper.dart' as R;
import '../../main.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/views/seller/models/product_size_model.dart';

class CustomSizeRequestsApis {
  Future<R.Response> requestCustomSize(
    String productId,
    Size sizeInfo,
  ) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.buyerCustomSizeRequest));
    request.fields.addIf(productId.isNotEmpty, "product_id", productId);

    if (sizeInfo.widthInMm != null) {
      request.fields.addIf(sizeInfo.widthInMm != null, "size[width_in_mm]", sizeInfo.widthInMm!);
    }
    if (sizeInfo.heightInMm != null) {
      request.fields.addIf(sizeInfo.heightInMm != null, "size[height_in_mm]", sizeInfo.heightInMm!);
    }
    if (sizeInfo.thicknessInMm != null) {
      request.fields.addIf(sizeInfo.thicknessInMm != null, "size[thickness_in_mm]", sizeInfo.thicknessInMm!);
    }
    if (sizeInfo.diameterInMm != null) {
      request.fields.addIf(sizeInfo.diameterInMm != null, "size[diameter_in_mm]", sizeInfo.diameterInMm!);
    }

    if (sizeInfo.lengthInMm != null) {
      request.fields.addIf(sizeInfo.lengthInMm != null, "size[length_in_mm]", sizeInfo.lengthInMm!);
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    print(responseBody);
    return R.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
