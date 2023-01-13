// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/homeServices.dart';
import '../models/rechargePlans.dart';
import '../utils/export_file.dart';

class HomeServices extends GetxService {
  final String allProviders = 'AllProviders/';
  final String getCirclesAPI = 'all_circles/';
  final String getScratchAPI = 'Myscratchcards';
  final String getKycTypes = 'KyvTypes';
  final String addWallentMoney = 'AddMoney';

  static var client = http.Client();

  Future<Services?> services(String token, String name, int type) async {
    var url = Uri.parse("$NewDEVURL$allProviders$name/$type/");
    var headers = {'Authorization': token};
    //'http://97.74.81.248:2020/api/AllProviders/Landline/0'
    var response = await client.get(url, headers: headers);
    Services? services;
    if (response.statusCode == 200) {
      debugPrint(response.body);
      services = Services.fromJson(jsonDecode(response.body));
    } else {
      debugPrint("API Calling Failed");
    }
    return services;
  }

  Future<Circles?> getCircles(String token, String modules) async {
    var url = Uri.parse("$NewDEVURL$allProviders$getCirclesAPI$modules/");
    var headers = {'Authorization': token};
    //'http://97.74.81.248:2020/api/all_circles/PrePaid'
    var response = await client.get(url, headers: headers);
    Circles? circlesData;
    if (response.statusCode == 200) {
      debugPrint(response.body);
      circlesData = Circles.fromJson(jsonDecode(response.body));
    } else {
      debugPrint("API Calling Failed");
    }
    return circlesData;
  }

  Future<MyScratchCards?> getScratchCards(String token) async {
    var url = Uri.parse("$NewDEVURL$allProviders$getScratchAPI");
    var headers = {'Authorization': token};
    var response = await client.get(url, headers: headers);
    MyScratchCards? myScratchCards;
    if (response.statusCode == 200) {
      debugPrint(response.body);
      myScratchCards = MyScratchCards.fromJson(jsonDecode(response.body));
    } else {
      debugPrint("API Calling Failed");
    }
    return myScratchCards;
  }

  Future<KycTypes?> getKycType(String token) async {
    var url = Uri.parse("$NewDEVURL$allProviders$addWallentMoney");
    var headers = {'Authorization': token};
    var data = {
    "amount":100,
    "coupon_code":"1234"
};
    var response = await client.post(url, headers: headers,body: jsonEncode(data));
    KycTypes? kycTypes;
    if (response.statusCode == 200) {
      debugPrint(response.body);
      kycTypes = KycTypes.fromJson(jsonDecode(response.body));
    } else {
      debugPrint("API Calling Failed");
    }
    return kycTypes;
  }
  Future<AddWalletPayment?> addWalletAmount(String token) async {
    var url = Uri.parse("$NewDEVURL$allProviders$getKycTypes");
    var headers = {'Authorization': token};
    var response = await client.get(url, headers: headers);
    AddWalletPayment? addWalletPayment;
    if (response.statusCode == 200) {
      debugPrint(response.body);
      addWalletPayment = AddWalletPayment.fromJson(jsonDecode(response.body));
    } else {
      debugPrint("API Calling Failed");
    }
    return addWalletPayment;
  }
}
