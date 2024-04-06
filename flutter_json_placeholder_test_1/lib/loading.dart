import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_json_placeholder_test_1/Posts_api/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Images_api/image_home.dart';
import 'Images_api/image_home_design2.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ImageHomeDesign2()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const  BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/api2.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
            ),

            Text("Flutter Api Testing", style: GoogleFonts.yellowtail(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 52.0,
              )
            ),),
            const SizedBox(height: 20,),

            SpinKitFadingFour(
              size: 100.0,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.white : Colors.blue,
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}


