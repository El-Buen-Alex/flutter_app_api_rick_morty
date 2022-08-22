

class  EpisodeModel {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final String url;
  const EpisodeModel({
    this.id=0, this.airDate='', this.episode='', this.name='', this.url=''
  });

  factory EpisodeModel.fromJson({required Map<dynamic, dynamic> episodeJson}){

    return EpisodeModel(
      airDate: episodeJson['air_date']??'',
      episode: episodeJson['episode']??'' ,
      id: episodeJson['id']??0 ,
      name: episodeJson['name']??'',
      url: episodeJson['url']??'',
    );
  }
}