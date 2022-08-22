import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taller_2/api/api.dart';
import 'package:taller_2/models/api_response_list_model.dart';
import 'package:taller_2/widgets/character_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Api Rick And Morty: Episodios'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool gettingInit=true;
  bool gettingMore=false;
  int currentPage=1;
  final ApiService _apiService = ApiService();
  ApiResponseListModel data=ApiResponseListModel();
  final ScrollController scrollController=ScrollController();

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels+100>= scrollController.position.maxScrollExtent
      && data.next.isNotEmpty && !gettingMore){
        setState(() {
          gettingMore=true;
        });
        currentPage++;
        getEpisodes(page: currentPage);
      }
    });
    getEpisodes();

  }
  getEpisodes({int page=1}) async{

    currentPage=page;
    await _apiService.getEpisodes(page: page).then((value){
        setState(() {
          if(gettingInit){
            gettingInit=false;
             data=value;
          }
          if(gettingMore){
            gettingMore=false;
            dynamic currentValues=[...data.characters];
            data=value;
            inspect(currentValues);
            data.characters=[...currentValues, ...data.characters];
          }
         
        });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.3,
            child: const Image(image: AssetImage('assets/banner.png',), fit: BoxFit.cover),
          ),
          Expanded(
            child:
             gettingInit?
              const Center(
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: CircularProgressIndicator()
                ),
              ) :
          
             Stack(
               children: [
                 RefreshIndicator(
                  onRefresh: ()async{
                    setState(() {
                      gettingInit=true;
                    });
                    getEpisodes(page: 0);
                  },
                  child:  ListView.separated(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.characters.length,
                    separatorBuilder: (_,i)=> const Divider(), 
                    itemBuilder: (_, index){
                      return CharacterCardWidegt(characterModel: data.characters[index],num: index+1,);
                    }, 
                  ), 
                ),
                 if(gettingMore) 
                 Positioned(
                    bottom: 40,
                    left:( MediaQuery.of(context).size.width*0.5) - 30,
                  child: Container(
                    width: 60,
                     padding: const EdgeInsets.all(10),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                )
               ],
             )
          )
         
        ],
      ),
       
    );
  }
}
