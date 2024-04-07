import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'Models/UserModel.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUser() async {
    final response =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    var data = jsonDecode(response.body.toString());
    userList.clear();

    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
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
            if (!snapshot.hasData) {
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
                itemCount: userList.length,
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
                          value: userList[index].id.toString(),
                        ),
                        ResueableRow(
                          title: 'Name : ',
                          value: userList[index].name.toString(),
                        ),
                        ResueableRow(
                          title: 'username : ',
                          value: userList[index].username.toString(),
                        ),
                        ResueableRow(
                          title: 'email : ',
                          value: userList[index].email.toString(),
                        ),
                        ResueableRow(
                          title: 'Phone : ',
                          value: userList[index].phone.toString(),
                        ),
                        ResueableRow(
                          title: 'Company : ',
                          value: userList[index].company!.name.toString(),
                        ),
                        ResueableRow(
                          title: 'Website : ',
                          value: userList[index].website.toString(),
                        ),
                        ResueableRow(
                          title: 'Address : ',
                          value: userList[index].address!.city.toString(),
                        ),
                        ResueableRow(
                          title: 'Street : ',
                          value: userList[index].address!.street.toString(),
                        ),
                        ResueableRow(
                          title: 'ZipCode : ',
                          value: userList[index].address!.zipcode.toString(),
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
