

import 'package:taller_2/models/character_model.dart';

class ApiResponseListModel {

  final bool status;
  List<CharacterModel> characters;
  final int count;
  final int pages;
  final String next;
  final String prev;

   ApiResponseListModel({
    this.count=0,
    this.characters=const [],
    this.next='',
    this.prev='',
    this.pages=0,
    this.status=false
  });

  factory ApiResponseListModel.fromJson({required Map<dynamic, dynamic> response}){
    List<CharacterModel> characters=[];
    List<dynamic> results=response['results']??[];
    for (final e in results) {
      characters.add(CharacterModel.fromJson(charJson: e));
    }
    return ApiResponseListModel( 
      count: response['info']!=null?response['info']['count']??0:0 ,
      characters: characters,
      next:response['info']!=null?response['info']['next']??'':'' ,
      pages:response['info']!=null?response['info']['pages']??0:0 ,
      prev:response['info']!=null?response['info']['prev']??'':'',
      status: response['info']!=null?true:false,
    );
  }


}