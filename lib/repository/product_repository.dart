import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/productModels.dart';

class ProductRepository {
  getProducts() async {
    try {
      var headers = {
        "token":
            "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz"
      };

      final response = await http.get(
        Uri.parse(
          'http://205.134.254.135/~mobile/MtProject/public/api/product_list.php',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final jsonResponse = json.decode(response.body);
        List<Products> products = jsonResponse['data']
            .map<Products>((json) => Products.fromJson(json))
            .toList();
        // List data = [];
        // for (int i = 0; i < jsonResponse['data'].length; i++) {
        //   data.add(CountryModel.fromJson(response.body['data']![i]));
        // }
        // data.add(CountryModel.fromJson(jsonDecode(response.body)));
        return products;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // return false;
      rethrow;
    }
  }
}
