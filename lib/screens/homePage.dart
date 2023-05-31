// import 'package:fasa7ny/models/posts.dart';
// import 'package:flutter/material.dart';
// import 'rating.dart';
// import 'reviews.dart';
// import 'descriptions.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage();

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Widget build(BuildContext context) {
//     if (ModalRoute.of(context)!.settings.arguments is Map<String, Post>) {
//       final routeArgs =
//           ModalRoute.of(context)!.settings.arguments as Map<String, Post>;
//       final data = routeArgs['snapshot'];

//       return Scaffold(
//         backgroundColor: Color.fromARGB(255, 207, 130, 75),
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 207, 530, 75),
//           bottomOpacity: 0.0,
//           elevation: 0.0,
//           scrolledUnderElevation: 0,
//         ),
//         body: SingleChildScrollView(
//             child: Padding(
//                 padding: EdgeInsets.only(left: 20, right: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Description(
//                       title: data!.title,
//                       urlImage: data.imageUrl,
//                       description: data.description,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [Rating()],
//                     ),
//                     SizedBox(
//                       height: 7,
//                     ),
//                     Reviews()
//                   ],
//                 )
//                 //               IconButton(
//                 //                   onPressed: () async {
//                 //                     var result = Server().getPosts();
//                 //                     Navigator.of(context).push(
//                 //                       Text(result);
//                 //                     );

//                 )),
//       );
//     } else {
//       return Center(child: CircularProgressIndicator());
//     }
//   }
// }

import 'package:fasa7ny/models/posts.dart';
import 'package:flutter/material.dart';
import 'rating.dart';
import 'reviews.dart';
import 'descriptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isUserLoggedIn = false; // Variable to track user login status

  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  void checkUserLoginStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await auth.currentUser;
    setState(() {
      isUserLoggedIn = user != null; // Update the login status
    });
  }

  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments is Map<String, Post>) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, Post>;
      final data = routeArgs['snapshot'];

      return Scaffold(
        backgroundColor: Color.fromARGB(255, 207, 130, 75),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 207, 530, 75),
          bottomOpacity: 0.0,
          elevation: 0.0,
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Description(
                  title: data!.title,
                  urlImage: data.imageUrl,
                  description: data.description,
                ),
                if (isUserLoggedIn) // Render the Rating widget only if the user is logged in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Rating()],
                  ),
                SizedBox(
                  height: 7,
                ),
                Reviews(),
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

