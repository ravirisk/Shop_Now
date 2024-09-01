
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../model/product_model.dart';

class ProductListRepo {
  Future<List<ProductModel>> fetchProducts() async {
    const baseUrl = 'https://fakestoreapi.com/products';
    var request = http.Request('GET', Uri.parse(baseUrl));

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString(); // Store the response body

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(responseBody);
      }
      final jsonData = jsonDecode(responseBody);
      return jsonData.map<ProductModel>((e) => ProductModel.fromJson(e)).toList();

    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      return [];
    }
  }
}