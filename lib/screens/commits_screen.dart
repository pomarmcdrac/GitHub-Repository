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
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0.5,
                        offset: Offset(0, 0),
                        color: Colors.grey,
                      )
                    ],
                    color: Colors.black
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: AutoSizeText(
                          'Author: ${historyCommits[index].commit.author.name}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          maxFontSize: 18,
                          minFontSize: 12,
                        ),
                        subtitle: AutoSizeText(
                          'Message: ${historyCommits[index].commit.message}',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                          maxLines: 3,
                          maxFontSize: 14,
                          minFontSize: 8,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded, 
                            color: Colors.blueAccent[900],
                            size: 30,
                          ),
                          onPressed: () => Navigator.of(context).pushNamed(
                            CommitsScreen.routeName,
                            arguments: historyCommits,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AutoSizeText(
                              'Date: ${historyCommits[index].commit.author.date.toString().substring(0,10)}',
                              style:  TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              maxFontSize: 10,
                              minFontSize: 6,
                            ),
                            const SizedBox(width: 10,),
                            AutoSizeText(
                              'Time: ${historyCommits[index].commit.author.date.toString().substring(11,19)} hrs',
                              style:  TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              maxFontSize: 10,
                              minFontSize: 6,
                            ),
                          ],
                        ),
                      ),
                    ],
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