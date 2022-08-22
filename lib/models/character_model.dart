class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;


  const CharacterModel(
    {
      this.gender='',
      this.id=0,
      this.image='',
      this.name='',
      this.species='',
      this.status=''
    }
  );

  factory CharacterModel.fromJson({required Map<dynamic, dynamic> charJson}){
    return CharacterModel(
      gender: charJson['gender']??'',
      id: charJson['id']??0,
      image:charJson['image']??'' ,
      name:charJson['name']??'' ,
      species: charJson['species']??'',
      status:charJson['status']??'' ,
    );
  }

}