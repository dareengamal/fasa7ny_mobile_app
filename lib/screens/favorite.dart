

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FavoriteScreen extends StatefulWidget {
//   @override
//   State<FavoriteScreen> createState() => _FavoriteState();
// }

// class _FavoriteState extends State<FavoriteScreen> {
//   User? userCred;
//   var images = [];
//   void checkUserLoginStatus() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user = await auth.currentUser;
//     setState(() {
//       userCred = user; // Update the login status
//     });
//   }

//   Future<dynamic> getImages(int index) async {
//     try {
//       FirebaseAuth auth = FirebaseAuth.instance;
//       User? user = await auth.currentUser;

//       final DocumentReference _users =
//           FirebaseFirestore.instance.collection('users').doc(user!.uid);
//       DocumentSnapshot snapshot = await _users.get();
//       dynamic attributeValue = snapshot['favorites'];
//       images = attributeValue.toSet().toList();
//       final DocumentReference _posts = FirebaseFirestore.instance
//           .collection('posts')
//           .doc(attributeValue[index]);
//       DocumentSnapshot snapshot2 = await _posts.get();

//       return snapshot2['image'];
//     } catch (err) {
//       return "errror";
//     }
//   }

//   Color hexStringToColor(String hexColor) {
//     final buffer = StringBuffer();
//     if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
//     buffer.write(hexColor.replaceFirst('#', ''));
//     return Color(int.parse(buffer.toString(), radix: 16));
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               hexStringToColor("E59400"),
//               hexStringToColor("FFE5B4"),
//               hexStringToColor("C37F00"),
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           'FASA7NY',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.account_circle),
//                       onPressed: () {
//                         // TODO: Implement profile icon functionality
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Center(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Text(
//                     'Favourite Destinations',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Center(
//                   child: ListView.builder(
//                     itemCount: 3,
//                     itemBuilder: (context, index) {
//                       return FutureBuilder(
//                         future: getImages(index),
//                         builder: (BuildContext context,
//                             AsyncSnapshot<dynamic> snapshot) {
//                           if (snapshot.hasData) {
//                             return Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 10,
//                               ),
//                               margin: const EdgeInsets.only(
//                                 right: 50,
//                                 top: 10,
//                                 bottom: 10,
//                               ),
//                               width: double.infinity,
//                               height: 364,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30),
//                                 color: Colors.white,
//                                 image: DecorationImage(
//                                   image: NetworkImage(snapshot.data),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             );
//                           } else {
//                             return Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           }
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteState();
}

class _FavoriteState extends State<FavoriteScreen> {
  User? userCred;
  var images = [];
  void checkUserLoginStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await auth.currentUser;
    setState(() {
      userCred = user; // Update the login status
    });
  }

  Future<dynamic> getImages(int index) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = await auth.currentUser;

      final DocumentReference _users =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);
      DocumentSnapshot snapshot = await _users.get();
      dynamic attributeValue = snapshot['favorites'];
      images = attributeValue.toSet().toList();
      final DocumentReference _posts = FirebaseFirestore.instance
          .collection('posts')
          .doc(attributeValue[index]);
      DocumentSnapshot snapshot2 = await _posts.get();

      return snapshot2['image'];
    } catch (err) {
      return "errror";
    }
  }

  Color hexStringToColor(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("E59400"),
              hexStringToColor("FFE5B4"),
              hexStringToColor("C37F00"),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Theme(
            data: ThemeData.dark(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'FASA7NY',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () {
                          // TODO: Implement profile icon functionality
                        },
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Favourite Destinations',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          future: getImages(index),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                margin: const EdgeInsets.only(
                                  right: 50,
                                  top: 10,
                                  bottom: 10,
                                ),
                                width: 231,
                                height: 364,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.data),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      },
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

