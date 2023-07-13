import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/drawer.dart';
import 'package:the_wall/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_wall/components/wall_post.dart';
import 'package:the_wall/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final postcontroller = TextEditingController();

  void postMessage() {
    if (postcontroller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("posts").add({
        "Message": postcontroller.text,
        "User": user.email,
        "Timestamp": DateTime.now(),
        "Likes": []
      });
      postcontroller.clear();
    }
  }

  void goToProfilePage() {
    Navigator.pop(context);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfilePage()));
  }

  void userSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "The Wall",
        ),
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onLogoutTap: userSignOut,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .orderBy("Timestamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No posts yet"));
                  } //new
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                          message: post["Message"],
                          user: post["User"],
                          timestamp: post["Timestamp"].toDate(),
                          postId: post.id,
                          likes: List<String>.from(post["Likes"]));
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MyTextField(
                      controller: postcontroller,
                      hintText: "Post something...",
                      obscureText: false),
                ),
                IconButton(
                  onPressed: postMessage,
                  icon: const Icon(Icons.arrow_circle_up, size: 30),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("logged in as ${user.email}"),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
