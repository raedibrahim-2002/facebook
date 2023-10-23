import 'package:facebook/chats.dart';
import 'package:facebook/login_page.dart';
import 'package:facebook/post_model.dart';
import 'package:facebook/profile_screen.dart';
import 'package:facebook/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayHome extends StatefulWidget {
  const DisplayHome({super.key});

  @override
  State<DisplayHome> createState() => _DisplayHomeState();
}

class _DisplayHomeState extends State<DisplayHome> {
  static List<Widget> myIcons = <Widget>[
    const Icon(Icons.home),
    const Icon(CupertinoIcons.person_2_fill),
    const Icon(Icons.notifications),
    const CircleAvatar(
      radius: 20, // Image radius
      backgroundImage: NetworkImage(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJm7YkuR53TP9u5W6a9Wt_pWbC8JtQPDRcQ&usqp=CAU'),
    )
  ];
  List<PostsModel> posts = [
    PostsModel(
        imageForPosterMan:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYc9I8HDq9-QBh4DzboxCR3F4uaJGMwYkkGA&usqp=CAU',
        textPoster: 'Dracula',
        imagePoster:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYXfNm71DdRde5ETp-7H0q0ApnJwQAFBWK4w&usqp=CAU",
        time: "24 h ago",
        textOfThePost: 'hello bro',
        online: true,
        shown: true),
    PostsModel(
        imageForPosterMan:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKJwhBpP9dO9A_yH_FVIKC-wCDh5v4r-OXWQ&usqp=CAU',
        textPoster: 'Pistol',
        imagePoster:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXXZG3T5MB9OmOTef9Gz35kAdeuJghYEuwRw&usqp=CAU",
        time: "12 min ago",
        textOfThePost: 'world is small',
        online: true,
        shown: false),
    PostsModel(
        imageForPosterMan:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8j1phplfUkt-F1EAB3ieH1liY7MD_GvOg3Q&usqp=CAU',
        textPoster: 'Hacker',
        imagePoster:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4YD9Iq0ji9YmUF33Mp_AAEBz_YOrzHmq66GcG3JorrJOLivD7R1dMoIikeWkwDkL6rjk&usqp=CAU",
        time: "Now",
        textOfThePost: 'Good Night',
        online: true,
        shown: true),
    PostsModel(
        imageForPosterMan:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3EHGiEqMRNji7t6t6kgRP6MSLneCAaTouqKrdU3aNv-LWPa-954lguKifSgTnVLZ5Sq4&usqp=CAU',
        textPoster: 'Wise Man',
        imagePoster:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjYFV-bwRLTx5vbXeIRyRZDH86KNG-4ktGcg&usqp=CAU",
        time: "22 h ago",
        textOfThePost: 'شيئان ما انفك يثير في نفسي الإعجاب والاحترام: السماء ذات النجوم من فوقي، وسمو الأخلاق في نفسي.',
        online: false,
        shown: true),
    PostsModel(
        imageForPosterMan:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSO7LHrv4Pbc4L5ZJrMN0FVO-Xz6Jn4N_1CSGwQ5zV8gAatbNZQfUaqv4aQ0VuugpEkBTY&usqp=CAU',
        textPoster: 'Josef',
        imagePoster:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScQe5o2EWYXini5N9qD3ouO4RvF6IFWA-Rlw&usqp=CAU",
        time: "15 h ago",
        textOfThePost: 'the moon',
        online: false,
        shown: false)
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myIcons.length,
      child: Scaffold(
        backgroundColor: const Color(0xFF313131),
        appBar: AppBar(
          backgroundColor: const Color(0xFF565656),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileScreen();
                },));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Chats();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                // delete current user data
                FirebaseAuth.instance.signOut();
                 saveLoggedOut();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Login();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.login,
                color: Colors.white,
              ),
            ),

          ],
          automaticallyImplyLeading: false,
          title: const Row(
            children: [
              CircleAvatar(
                radius: 19,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqZ44-o3rhiqOsulWIKXP-82Elr-7-VBDks-y-7UILuyMzhz2D3iFLReno4MNzmdh2Pz4&usqp=CAU'),
              ),
              Text(
                '  facebook',
                style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: myIcons,
          ),
        ),
        body: TabBarView(
          children: [
// Note: Same code is applied for the TextFormField as well
            buildColumnForTabBar(),
            const Text(' '),
            const Text(' '),
            const Text(' ')
          ],
        ),
      ),
    );
  }

  Widget buildColumnForTabBar() {
    return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0,right: 5),
                child: Container(
                  color: const Color(0xFF313131),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ProfileScreen();
                          },));
                        },
                        child: const CircleAvatar(
                          radius: 23, // Image radius
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJm7YkuR53TP9u5W6a9Wt_pWbC8JtQPDRcQ&usqp=CAU',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: 150, // تحديد العرض
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              color: const Color(0xFF565656),
                              borderRadius: BorderRadius.circular(
                                  40), // جعل الحاوية دائرية
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: '  What in your mind',
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none, // إزالة الحدود
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.save_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const Divider(
                color: Color(0xFF565656),
                thickness: 1,
                height: 2,
              ),
              postsView(),
            ],
          );
  }


  Widget postsView() {
    return Expanded(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8, top: 16, bottom: 10),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blue,
                            ),
                            CircleAvatar(
                              maxRadius: posts[index].shown ? 25 : 22,
                              backgroundImage:
                                  NetworkImage(posts[index].imageForPosterMan),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: posts[index].online ? 7 : 0,
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(posts[index].textPoster,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(posts[index].time,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0,left: 5),
                child: Text(maxLines: 5,
                  posts[index].textOfThePost,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
              Image.network(
                posts[index].imagePoster,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 350,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                      const Text("Like", style: TextStyle(color: Colors.white))
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.comment,
                          color: Colors.white,
                        ),
                      ),
                      const Text("Comment",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                      const Text("Share", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 2,
                thickness: 5,
                color: Colors.black,
              )
            ],
          );
        },
      ),
    );
  }

  void saveLoggedOut()
  async{
    PreferenceUtils.setBool('loggedIn',false);
  }

  void isLoggedOut()async {
    final loggedOut = PreferenceUtils.getBool('loggedOut');
    print("loggedIn => $loggedOut");
  }
}
