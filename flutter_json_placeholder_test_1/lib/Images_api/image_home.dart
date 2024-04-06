import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class ImageHome extends StatefulWidget {
  const ImageHome({super.key});

  @override
  State<ImageHome> createState() => _ImageHomeState();
}

class _ImageHomeState extends State<ImageHome> {
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
          "Flutter Json PlaceHolder \nImage Api Testing",
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
              builder: (context, snapshot) {
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
                    itemBuilder: (context, index) {
                      return ListTile(

                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(photosList[index].url.toString()),
                        ),

                        title: Text("Note Id : ${photosList[index].id.toString()}", style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(),
                        ),),

                        subtitle: Text(photosList[index].title.toString(), style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(),
                        ),),


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
