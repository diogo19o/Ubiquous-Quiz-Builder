import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:provider/provider.dart';
import 'package:ubiquous_quizz_builder/data/user_service_api.dart';

import 'single_post_page.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chopper Blog'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()  async {

          final response = await Provider.of<ChopperClient>(context).getService<UserService>().postPost({
            "action" : "login",
            "username" : "diogo",
            "password" : "47da36337c9140e2e9f1517a0ddeb0025e0c3310",
          });

          print(response.runtimeType);

          /*final response = await Provider.of<PostServiceApi>(context).postPost(
            /*"username=diogo&password=47da36337c9140e2e9f1517a0ddeb0025e0c3310&action=login"*/
              {
                "action" : "login",
                "username" : "diogo",
                "password" : "47da36337c9140e2e9f1517a0ddeb0025e0c3310",
              });*/

          print("Body: ${json.decode(response.bodyString)['result']}");
        },
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    // FutureBuilder is perfect for easily building UI when awaiting a Future
    // Response is the type currently returned by all the methods of PostApiService
    return FutureBuilder<Response>(
      // In real apps, use some sort of state management (BLoC is cool)
      // to prevent duplicate requests when the UI rebuilds
      future: Provider.of<ChopperClient>(context).getService<UserService>().getAll("utilizadores"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Snapshot's data is the Response
          // You can see there's no type safety here (only List<dynamic>)
          final List posts =
          json.decode(snapshot.data.bodyString)['utilizadores'];
          return _buildPosts(context, posts);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildPosts(BuildContext context, List posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index]['nome'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index]['email']),
            onTap: () => _navigateToPost(context, posts[index]['id']),
          ),
        );
      },
    );
  }

  void _navigateToPost(BuildContext context, String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SinglePostPage(postId: id),
      ),
    );
  }
}
