
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

  var data;
  Future getUser() async {
    final response = await get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {
      return data;
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
          "Flutter Json PlaceHolder \nUser Api Testing",
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
      body: Expanded(
        child: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      border: Border.all(
                        color: const Color(0xff4298b5).withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      children: [
                        ResueableRow(
                          title: 'Id : ',
                          value: data[index]["id"].toString(),
                        ),
                        ResueableRow(
                          title: 'Name : ',
                          value: data[index]["name"].toString(),
                        ),
                        ResueableRow(
                          title: 'username : ',
                          value: data[index]["username"].toString(),
                        ),
                        ResueableRow(
                          title: 'email : ',
                          value: data[index]["email"].toString(),
                        ),
                        ResueableRow(
                          title: 'Phone : ',
                          value: data[index]["phone"].toString(),
                        ),
                        ResueableRow(
                          title: 'Company : ',
                          value: data[index]["company"]["name"].toString(),
                        ),
                        ResueableRow(
                          title: 'Website : ',
                          value: data[index]["website"].toString(),
                        ),
                        ResueableRow(
                          title: 'Address : ',
                          value: data[index]["address"]["city"].toString(),
                        ),
                        ResueableRow(
                          title: 'Street : ',
                          value: data[index]["address"]["street"].toString(),
                        ),
                        ResueableRow(
                          title: 'ZipCode : ',
                          value: data[index]["address"]["zipcode"].toString(),
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
    );
  }
}


class ResueableRow extends StatelessWidget {
  String title, value;
  ResueableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10,),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.aBeeZee(
              textStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.aBeeZee(
              textStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
