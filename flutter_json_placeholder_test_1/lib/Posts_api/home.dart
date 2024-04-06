import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'models/PostsModel.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi()async{
    final response = await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    var data = jsonDecode(response.body.toString());
    postList.clear();

    if(response.statusCode == 200){
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4298b5),
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Flutter Json Api Test", style: GoogleFonts.aBeeZee(
          textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: SpinKitWave(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? const Color(0xff4298b5) : Colors.lightBlueAccent,
                          ),
                        );
                      },
                    ),
                  );
                }else{
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index){
                      return Container(
                        height: 300.0,
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xff4298b5),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            bottomLeft: Radius.circular(50.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffd7dcdd).withOpacity(0.5),
                              // offset: const Offset(4.0, 4.0),
                              blurRadius: 3.0,
                              spreadRadius: 3.0,
                            ),
                            BoxShadow(
                              color: const Color(0xffd7dcdd).withOpacity(0.5),
                              // offset: const Offset(4.0, 4.0),
                              blurRadius: 3.0,
                              spreadRadius: 3.0,
                            ),
                          ]
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      color: Colors.lightBlueAccent,

                                    ),
                                    child: Center(
                                      child: Text(postList[index].id.toString(), style: GoogleFonts.aBeeZee(
                                        textStyle: const TextStyle(color: Colors.white),
                                      ),),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10,),
                              Text(
                                "Title",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.aBeeZee(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10,),
                              Text(
                                postList[index].title.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                  color: Colors.black45,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0,),

                              Text(
                                "Description",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.aBeeZee(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20.0,),
                              Text(
                                postList[index].body.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.aBeeZee(
                                  textStyle: const TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                      );
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

