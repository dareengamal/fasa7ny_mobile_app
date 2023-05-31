import 'package:flutter/material.dart';

import '../models/posts.dart';
 import 'package:flutter_profile_picture/flutter_profile_picture.dart';
// import 'package:fasa7ny/services/postsProvider.dart';
import 'package:fasa7ny/models/posts.dart';


class Reviews extends StatefulWidget {
  @override
  State<Reviews> createState() => _Reviews();
}

class _Reviews extends State<Reviews> {
  late Future<List<Post>> posts;
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Reviews"),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.white70,
              ))
        ]),
        Row(
          children: [
            ProfilePicture(
              name: 'Dees K',
              radius: 20,
              fontsize: 21,
            ),
            Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text("Dima K",
                    style: TextStyle(fontSize: 16, color: Colors.white70))),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(left: 3, top: 2),
            child: Text("Amazing places ddloved it, Would totalyy visit again"))
      ],
    );
  }
}
