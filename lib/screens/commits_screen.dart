// Importing necessary Dart packages and external libraries
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:github_repository/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// List to store commit history
List<CommitsModel> historyCommits = [];

// Widget for displaying commit history screen
class CommitsScreen extends StatefulWidget {
  static const String routeName = 'CommitsScreen';

  const CommitsScreen({Key? key}) : super(key: key);

  @override
  State<CommitsScreen> createState() => _CommitsScreenState();
}

// State class for the CommitsScreen widget
class _CommitsScreenState extends State<CommitsScreen> {

  @override
  void initState() {
    // Fetch commits when the widget is initialized
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
          // App bar with a back button and the title 'History of Commits'
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
            // List view to display commit history
            itemCount: historyCommits.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  // Container for individual commit details
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
                        // List tile for displaying commit author and message
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
                          'Message: ${historyCommits[index].commit.message}. Tap the arrow to see more details.',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                          maxLines: 3,
                          maxFontSize: 14,
                          minFontSize: 8,
                        ),
                        trailing: IconButton(
                          // Arrow icon button for launching URL
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded, 
                            color: Colors.blueAccent[900],
                            size: 30,
                          ),
                          onPressed: () {
                            // Confirm and launch URL
                            confirmLaunchUrl(context, historyCommits[index].htmlUrl, size);
                          }
                        ),
                      ),
                      Container(
                        // Container for displaying commit date and time
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

// Function to fetch commit history from GitHub API
Future getCommits() async {
  const String baseUrl = 'api.github.com';
  const String segmentUrl = '/repos/pomarmcdrac/GitHub-Repository/commits';

  // Make a GET request to fetch commit data
  final response = await http.get(
    Uri.https(baseUrl, segmentUrl),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/vnd.github+json',
    },
  );

  if (response.statusCode == 200) {
    // If the request is successful, parse and return the list of commits
    final List<dynamic> commitsJson = jsonDecode(response.body);
    final List<CommitsModel> commits = commitsJson.map((json) => CommitsModel.fromJson(json)).toList();
    return commits;
  } else {
    // If the request fails, throw an exception
    throw Exception('Failed to load commits');
  }
}

// Function to confirm and launch a URL
void confirmLaunchUrl(BuildContext context, String url, Size size) async {
  showDialog(
    // Show a dialog with confirmation message
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.black38,
        ),
        height: size.height * 0.2,
        width: size.width * 0.8,
        child: AlertDialog(
          backgroundColor: Colors.black38,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(15),
            side: const BorderSide(
              color: Colors.grey,
              width: 2,
            )
          ),
          content: Material(
            color: Colors.black38,
            child: Container(
              alignment: Alignment.center,
              height: size.height * 0.15,
              child: const Text(
                'Do you want to proceed? This will take you out of the application to view the changes.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actions: [
            TextButton(
              // Cancel button
              onPressed: () => Navigator.pop(context), 
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              // Continue button, launch URL
              onPressed: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication), 
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 14
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    },
  );
}
