import 'package:blog_explorer/provider/favorite_provider.dart';
import 'package:blog_explorer/screens/home.dart';

import 'package:flutter/material.dart';
import 'package:blog_explorer/provider/blog_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:sizer/sizer.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _user = FavoriteProvider();
    return MultiProvider(providers: [ChangeNotifierProvider(create: ((context) =>blog_provider() )),ChangeNotifierProvider<FavoriteProvider>.value(value: _user)],
    
      child: Sizer(
        builder: (context,orientation,deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blog Explorer',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            home: const Home(),
          );
        }
      ),
    );
  }
}


