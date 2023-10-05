import 'dart:convert';

import 'package:blog_explorer/models/blogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class blog_provider extends ChangeNotifier {
  static String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
  bool isloading = true;
  String error = "";
  Blog blog = Blog(blogs: []);
  Blog serachedPets = Blog(blogs: []);
  String searchText = '';

  void fetchBlogs() async {
  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    // ignore: dead_code
    if (response.statusCode == 200) {
      //Request successful, handle the response data here
    //final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

     // return parsed.map<Blog>((json) => parsed.fromMap(json)).toList();
      print('Response data: ${response.body}');
      blog = blogFromJson(response.body);
    } else {
      // Request failed
      print('Request failed with status code: ${response.statusCode}');
     // print('Response data: ${response.body}');
      error = response.statusCode.toString();
    }
  } catch (e) {
    // Handle any errors that occurred during the request
    error = e.toString();
  }
  isloading= false;
  notifyListeners();
}
updateData() {
    serachedPets.blogs.clear();
    if (searchText.isEmpty) {
      serachedPets.blogs.addAll(blog.blogs);
    } else {
      serachedPets.blogs.addAll(blog.blogs
          .where((element) =>
              element.title!.toLowerCase().startsWith(searchText))
          .toList());
    }
    notifyListeners();
  }

  search(String username) {
    searchText = username;
    updateData();
  }

}

