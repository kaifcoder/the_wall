import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/commentbtn.dart';
import 'package:the_wall/components/like_buton.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final DateTime timestamp;
  final List<String> likes;
  final String postId;

  const WallPost(
      {super.key,
      required this.message,
      required this.user,
      required this.timestamp,
      required this.postId,
      required this.likes});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController commentController = TextEditingController();

  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(user.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("posts").doc(widget.postId);

    if (isLiked) {
      postRef.update({
        "Likes": FieldValue.arrayUnion([user.email])
      });
    } else {
      postRef.update({
        "Likes": FieldValue.arrayRemove([user.email])
      });
    }
  }

  //add a comment
  void addComment(String commentText) {
    //write comment to firestore
    FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.postId)
        .collection("comments")
        .add({
      "text": commentText,
      "commentedby": user.displayName,
      "time": Timestamp.now(),
    });
  }

  //show a dialog box to add a comment
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          "Add a comment",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: commentController,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            focusColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: "New comment",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => addComment(commentController.text),
            child: Text(
              "Post",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(
                  color: Colors.grey[800],
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.message,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      LikeButton(isLiked: isLiked, onTap: toggleLike),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.likes.length.toString(),
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      CommentBtn(onTap: showCommentDialog),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "0",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
