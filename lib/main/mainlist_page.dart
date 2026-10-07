import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage>{

  Future<String> loadAsset() async{
    return await rootBundle.loadString('res/api/list.json');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:FutureBuilder<String>(
        future : loadAsset(),
        builder : (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
              return const Center(
                child : CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if(snapshot.hasData){
                Map<String, dynamic> list = jsonDecode(snapshot.data!);
                return ListView.builder(
                  itemCount: list['count'],
                  itemVuilder: (context,index){
                    return InkWell(
                      onTap: (){

                      },
                      child : SizedBox(
                        height : 50,
                        child : Card(
                          child : Text(
                            list['question'][index]['title'].toString(),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }else if (snapshot.hasError){
                return Center(
                  child : Text('Error : $snapshot.error'),
                );
              }else {
                return const Center(
                  child : Text('No Data'),
                );
              }
            default:
              return const Center(
                child : Text('No Data'),
              );
          }
        }
      )
    );
  }
}