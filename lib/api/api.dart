

import 'dart:convert';
import 'dart:developer';

import 'package:taller_2/models/api_response_list_model.dart';
import 'package:http/http.dart' as http;

class ApiService {


  Future<ApiResponseListModel> getEpisodes({int page=1}) async{
    Map<dynamic, dynamic> response={};
    try{
      final responseApi= await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character').
        replace(queryParameters: {
          'page':'$page'
        })
      );
      response=jsonDecode(responseApi.body);
      // inspect(response);
    }catch(e){
      response={};
    }
    return ApiResponseListModel.fromJson(
      response: response
    );
  }
}