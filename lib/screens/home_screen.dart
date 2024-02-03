// Importing required packages
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// Defining a stateless widget for the home screen
class HomeScreen extends StatelessWidget {

  // Defining a constant for the route name
  static const String routeName = 'HomeScreen';

  // Constructor for the HomeScreen widget
  const HomeScreen({Key? key}) : super(key: key);
  
  // Overriding the build method to define the UI of the home screen
  @override
  Widget build(BuildContext context) {

    // Getting the size of the current screen
    final size = MediaQuery.of(context).size;

    // Returning a safe area widget to avoid overlaps with the operating system interface
    return SafeArea(
      child: Scaffold(
        // Setting the background color of the scaffold
        backgroundColor: Colors.black87,
        // Defining the app bar of the scaffold
        appBar: AppBar(
          centerTitle: true,
          title: const AutoSizeText(
            'GitHub Repository',
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
        // Defining the body of the scaffold
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Defining a container for the GitHub logo
                Container(
                  width: size.width * 0.3, 
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
                  child: const Image(
                    image: AssetImage('assets/githubwhite.png'), 
                    fit: BoxFit.contain,
                  ),
                ),
                // Defining a container for the app description
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[800]!,
                        spreadRadius: 0.5,
                        blurRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey[800]!,
                      width: 1,
                    ),
                    color: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  width: size.width * 0.8,
                  child: const AutoSizeText(
                    'On this app you can see the commits of a repository on GitHub. To get started, click the button below.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 4,
                    maxFontSize: 24,
                    minFontSize: 16,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Defining a SizedBox for the down arrow icon
                SizedBox(
                  height: size.height * 0.1,
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                // Defining a container for the "See Commits" button
                Container(
                  padding: const EdgeInsets.all(10),
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigating to the CommitsScreen when the button is pressed
                        Navigator.pushNamed(context, 'CommitsScreen');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black12,
                        elevation: 5,
                        padding: EdgeInsets.zero,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.indigoAccent,
                              Colors.blueAccent,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width,
                          padding: const EdgeInsets.all(10),
                          child: const AutoSizeText(
                            'See Commits',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            maxFontSize: 24,
                            minFontSize: 16,
                            textAlign: TextAlign.center,
                          )
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}