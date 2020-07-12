import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/models/Address.dart';
import 'package:truck/models/CommodityOwner.dart';
import 'package:http/http.dart' as http;
import 'package:truck/models/Place.dart';
import 'package:truck/models/Reciver.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/models/user.dart';

class HttpService {
  static Future<Request> saveRequest(
    Request request,
    CommodityOwner commodityOwner,
    Reciver reciver,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "https://truck-api.azurewebsites.net/api/requests";
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    CommodityOwner newCo;
    await saveCommodityOwner(
      commodityOwner,
      commodityOwner.address,
      commodityOwner.address.places,
    ).then((value) {
      newCo = value;
    });
    Reciver newRe;
    await saveRevicer(
      reciver,
      reciver.address,
      reciver.address.places,
    ).then((value) {
      newRe = value;
    });

    if (newCo != null && newRe != null) {
      request.commodityOwnerId = newCo.commodityOwnerId;
      request.reciverId = newRe.reciverId;
      request.requestId = 0;
      request.dateCreate = DateTime.now();
      request.statusId = 1;
      request.userId = prefs.getString('userId');
      var response = await http.post(url,
          headers: headers, body: jsonEncode(request.toJson()));
      Request newRequest = Request.fromJson(json.decode(response.body));
      return newRequest;
    }
    return null;
  }

  static Future<CommodityOwner> saveCommodityOwner(
      CommodityOwner commodityOwner,
      Address address,
      List<Place> places) async {
    if (commodityOwner.commodityOwnerId != null &&
        commodityOwner.commodityOwnerId > 0) {
      return commodityOwner;
    } else {
      var address1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await saveAddress(address).then((value) {
        address1 = value;
      });

      commodityOwner.commodityOwnerId = 0;
      commodityOwner.userId = prefs.getString('userId');
      commodityOwner.isDefault = true;
      commodityOwner.addressId = address1.addressId;

      savePlace(places, address1.addressId);
      String commodityUrl =
          "https://truck-api.azurewebsites.net/api/commodity-owners";
      Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      //Create CommodityOwner Info
      var response = await http.post(
        commodityUrl,
        headers: headers,
        body: jsonEncode(commodityOwner.toJson()),
      );
      CommodityOwner coResponse =
          CommodityOwner.fromJson(json.decode(response.body));
      return coResponse;
    }
  }

  static Future<Reciver> saveRevicer(
      Reciver reciver, Address address, List<Place> places) async {
    if (reciver.reciverId != null && reciver.reciverId > 0) {
      return reciver;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var address1;
      await saveAddress(address).then((value) {
        address1 = value;
      });
      reciver.reciverId = 0;
      reciver.addressId = address1.addressId;
      reciver.userId = prefs.getString('userId');
      reciver.isDefault = true;
      savePlace(places, address1.addressId);
      String commodityUrl = "https://truck-api.azurewebsites.net/api/recivers";
      Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      //Create CommodityOwner Info
      var response = await http.post(
        commodityUrl,
        headers: headers,
        body: jsonEncode(reciver.toJson()),
      );

      Reciver reResponse = Reciver.fromJson(json.decode(response.body));
      return reResponse;
    }
  }

  static Future<Address> saveAddress(Address address) async {
    address.addressId = 0;
    String commodityUrl = "https://truck-api.azurewebsites.net/api/addresses";
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    //Create CommodityOwner Info
    var response = await http.post(
      commodityUrl,
      headers: headers,
      body: jsonEncode(address.toJson()),
    );
    Address adResponse = Address.fromJson(json.decode(response.body));
    return adResponse;
  }

  static Future savePlace(List<Place> places, int addressId) async {
    String commodityUrl = "https://truck-api.azurewebsites.net/api/places";
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    for (var i = 0; i < places.length; i++) {
      places[i].id = 0;
      places[i].addressId = addressId;
      //Create CommodityOwner Info
      await http.post(
        commodityUrl,
        headers: headers,
        body: jsonEncode(places[i].toJson()),
      );
    }
  }

  static Future<List<Request>> getRequest(String userId, int statusId) async {
    String url = "https://truck-api.azurewebsites.net/api/requests?status=" +
        statusId.toString();
    var response = await http.get(url);
    List<Request> requests = new List<Request>();
    if (response.statusCode == 200) {
      var jsonRe = json.decode(response.body);
      if (jsonRe != null) {
        var list = jsonRe as List;
        if (list.length > 0) {
          requests = list.map((e) => Request.fromJson(e)).toList();
        }
      }
      return requests;
    }
    return null;
  }

  static Future<User> getUser(String userId) async {
    String url = "https://truck-api.azurewebsites.net/api/users/" + userId;
    var response = await http.get(url);
    User user;
    if (response.statusCode == 200) {
      user = User.fromJson(json.decode(response.body));
    }
    return user;
  }

  static Future<List<CommodityOwner>> getCommodityOwner(
      String userId, bool isDefault) async {
    String url =
        "https://truck-api.azurewebsites.net/api/commodity-owners?userId=" +
            userId +
            "&isDefault=" +
            isDefault.toString();
    var response = await http.get(url);
    List<CommodityOwner> commodityOwners = new List<CommodityOwner>();
    if (response.statusCode == 200) {
      var jsonCO = json.decode(response.body);
      var list = jsonCO as List;
      if (list.length > 0) {
        commodityOwners = list.map((e) => CommodityOwner.fromJson(e)).toList();
      }
    }
    return commodityOwners;
  }
}
