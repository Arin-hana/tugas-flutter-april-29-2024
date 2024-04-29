import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rest_api/models/post_model.dart';
import 'package:rest_api/service/api_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(100, 160, 200, 1),
            title: const Text(
              "Rest API",
              style: TextStyle(
                  color: Color.fromRGBO(19, 19, 56, 1),
                  fontWeight: FontWeight.w600),
            ),
          ),
          body: _body()),
    );
  }

  FutureBuilder _body() {
    final apiservice =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
        future: apiservice.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<PostModel> posts = snapshot.data!;
            return _posts(posts);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _posts(List<PostModel> posts) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: const Color.fromARGB(255, 1, 63, 134))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  posts[index].title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(posts[index].body)
              ],
            ),
          );
        });
  }
}
