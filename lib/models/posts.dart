import 'appUser.dart';
import 'comment.dart';

class Post {
  final String postID;
  //final User user;
  String title;
  String description;
  double avg_review;
  List<Comment> comments;
  String imageUrl;
  Post(
      {required this.postID,
      //required this.user,
      required this.title,
      required this.imageUrl,
      this.description: "",
      this.avg_review: 0,
      List<Comment>? comments})
      : comments = comments ?? [];
}
