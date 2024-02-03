import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:github_repository/models/models.dart';
import 'package:http/http.dart' as http;

List<CommitsModel> historyCommits = [];

class CommitsScreen extends StatefulWidget {

  static const String routeName = 'CommitsScreen';

  const CommitsScreen({Key? key}) : super(key: key);

  @override
  State<CommitsScreen> createState() => _CommitsScreenState();
}

class _CommitsScreenState extends State<CommitsScreen> {

  @override
  void initState() {
    getCommits().then((commits) {
      setState(() {
        historyCommits = commits;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded, 
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const AutoSizeText(
            'History of Commits',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            maxFontSize: 28,
            minFontSize: 20,
            textAlign: TextAlign.center,
          )
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: ListView.builder(
            itemCount: historyCommits.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: AutoSizeText(
                  historyCommits[index].commit.author.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  historyCommits[index].commit.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded, 
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(
                    CommitsScreen.routeName,
                    arguments: historyCommits,
                  ),
                ),
              );
            }
          ),
        )
      ),
    );
  }
}

Future getCommits() async {

  const String baseUrl = 'api.github.com';
  const String segmentUrl = '/repos/pomarmcdrac/GitHub-Repository/commits';

  final response = await http.get(
    Uri.https(baseUrl, segmentUrl),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/vnd.github+json',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> commitsJson = jsonDecode(response.body);
    final List<CommitsModel> commits = commitsJson.map((json) => CommitsModel.fromJson(json)).toList();
    return commits;
  } else {
    throw Exception('Failed to load commits');
  }

}