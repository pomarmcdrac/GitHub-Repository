import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:github_repository/models/models.dart';
import 'package:http/http.dart' as http;

CommitsModel historyCommits = CommitsModel(
  sha: '',
  nodeId: '',
  commit: Commit(
    author: CommitAuthor(
      name: '',
      email: '',
      date: DateTime.now(),
    ),
    committer: CommitAuthor(
      name: '',
      email: '',
      date: DateTime.now(),
    ),
    message: '',
    tree: Tree(
      sha: '',
      url: '',
    ),
    url: '',
    commentCount: 0,
    verification: Verification(
      verified: false,
      reason: '',
      signature: '',
      payload: '',
    ), 
  ),
  url: '',
  htmlUrl: '',
  commentsUrl: '',
  author: CommitsModelAuthor(
    login: '',
    id: 0,
    nodeId: '',
    avatarUrl: '',
    gravatarId: '',
    url: '',
    htmlUrl: '',
    followersUrl: '',
    followingUrl: '',
    gistsUrl: '',
    starredUrl: '',
    subscriptionsUrl: '',
    organizationsUrl: '',
    reposUrl: '',
    eventsUrl: '',
    receivedEventsUrl: '',
    type: '',
    siteAdmin: false,
  ),
  committer: CommitsModelAuthor(
    login: '',
    id: 0,
    nodeId: '',
    avatarUrl: '',
    gravatarId: '',
    url: '',
    htmlUrl: '',
    followersUrl: '',
    followingUrl: '',
    gistsUrl: '',
    starredUrl: '',
    subscriptionsUrl: '',
    organizationsUrl: '',
    reposUrl: '',
    eventsUrl: '',
    receivedEventsUrl: '',
    type: '',
    siteAdmin: false,
  ),
  parents: [],
);

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
      print(commits);
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

  final commits = CommitsModel.fromRawJson(response.body).toJson();

  print(commits);
}