import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../../constants.dart';
import '../../helpers/network_helper.dart' as RR;
import '../../main.dart';

class AddressesApis {
  Future<RR.Response> getDefaultAddress() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.buyerAddressesLists));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> getAddresses() async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('GET', Uri.parse(Constants.baseUrl + Constants.buyerAddressesLists));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> addAddress(String address1, String address2, String landmark, String city, String state, String pinCode, String isDefault, LatLng coordinates) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.buyerAddNewAddress));

    request.fields.addAll({
      'address_line_1': address1,
      'address_line_2': address2,
      'landmark': landmark,
      'city': city,
      'state': state,
      'pin_code': pinCode,
      'latitude': coordinates.latitude.toString(),
      'longitude': coordinates.longitude.toString(),
      'is_default': isDefault
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> updateAddress(
      String addressId, String address1, String address2, String landmark, String city, String state, String pinCode, String isDefault, LatLng coordinates) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.MultipartRequest('POST', Uri.parse(Constants.baseUrl + Constants.buyerUpdateAddress + addressId));

    request.fields.addAll({
      'address_line_1': address1,
      'address_line_2': address2,
      'landmark': landmark,
      'city': city,
      'state': state,
      'pin_code': pinCode,
      'latitude': coordinates.latitude.toString(),
      'longitude': coordinates.longitude.toString(),
      'is_default': isDefault
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }

  Future<RR.Response> deleteAddress(String id) async {
    var headers = {'Authorization': 'Bearer ' + myConstants.bearerToken};
    var request = http.Request('POST', Uri.parse(Constants.baseUrl + Constants.buyerDeleteAddress + id));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    return RR.Response(responseBody: responseBody, responseStatusCode: response.statusCode, serverStatusText: response.reasonPhrase, serverStatusCode: response.statusCode);
  }
}
