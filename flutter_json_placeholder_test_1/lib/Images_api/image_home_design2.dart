import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class ImageHomeDesign2 extends StatefulWidget {
  const ImageHomeDesign2({super.key});

  @override
  State<ImageHomeDesign2> createState() => _ImageHomeDesign2State();
}

class _ImageHomeDesign2State extends State<ImageHomeDesign2> {
  List<Photos> photosList = [];
  Future<List<Photos>> getPhotos() async {
    final response =
    await get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

    var data = jsonDecode(response.body.toString());
    photosList.clear();

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i["title"], url: i["url"], id: i["id"]);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4298b5),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Flutter Json PlaceHolder \nImage Api Testing Design 2",
          textAlign: TextAlign.center,
          style: GoogleFonts.aBeeZee(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
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
                    itemCount: photosList.length,
                    itemBuilder: (context, index){
                      return Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 3.0,
                              spreadRadius: 1.0,
                              offset: const Offset(2.0, 2.0),
                            )
                          ]
                        ),
                        margin: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.network(
                                photosList[index].url.toString(),
                                height: 80,
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Image Id : ${photosList[index].id.toString()}", style: GoogleFonts.aBeeZee(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),),
                                  Text("Image Id : ${photosList[index].title.toString()}", style: GoogleFonts.aBeeZee(
                                    textStyle: const TextStyle(
                                      // fontSize: 18,
                                    ),
                                  ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Photos {
  String? title, url;
  int? id;
  Photos({required this.title, required this.url, required this.id});
}
