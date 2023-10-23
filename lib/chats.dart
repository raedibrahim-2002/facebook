import 'package:flutter/material.dart';

import 'chat_model.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List<StoryModel> chatListsHorizonta = [
    StoryModel(
       imageUrl:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn8MGGp2GLriO3hhhZnZuvffVlgTn3Vh9xIQ&usqp=CAU",
       personAccountName:  'messi',
       shown:  true,online: true),
    StoryModel(
       imageUrl:  "https://cnn-arabic-images.cnn.io/cloudinary/image/upload/w_1920,h_1080,c_fill,q_auto,g_center/cnnarabic/2018/06/04/images/95913.jpg",
      personAccountName:   'mosalah',
      shown:   true,online: false),
    StoryModel(
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkcXfUMNwesmyZR1HSU2ky6LTP4rNsR8Z1BA&usqp=CAU',
       personAccountName:  "therock",
      shown:   false,online: true),
    StoryModel(
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZcrODvNv2lghXYWtmVRK5WxQZowfa6oQEyw&usqp=CAU',
      personAccountName:   'karimma',
        online: true,shown: true),
    StoryModel(
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY_eaON-aRIn7XMEY9hizsxSCmFu66FPC_eQ&usqp=CAU',
        personAccountName: 'mohamed',
        shown: true,online: true),

    StoryModel(
       imageUrl:  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8P7xNA0OHwxr0Bk3gyySGt6ZNUEjM0hUh1A&usqp=CAU',
       personAccountName:  'a.ashoru',
       shown:  true,online: true)
  ];
  List<ChatsModel> chatLists = [
    ChatsModel(
        imageUrlChat:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn8MGGp2GLriO3hhhZnZuvffVlgTn3Vh9xIQ&usqp=CAU",
        personAccountNameChat:  'messi',
        onlineBlue: true,ChatText: 'how are you',onlineInTheChat: true),
    ChatsModel(
        imageUrlChat:  "https://cnn-arabic-images.cnn.io/cloudinary/image/upload/w_1920,h_1080,c_fill,q_auto,g_center/cnnarabic/2018/06/04/images/95913.jpg",
        personAccountNameChat:  'mosalah',
        onlineBlue: true,ChatText: 'hiiiiiii',onlineInTheChat: true),
    ChatsModel(
        imageUrlChat:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlmp7PiMFWsMlv1-mshHFmPBIDgiypF5RjlA&usqp=CAU",
        personAccountNameChat:  'Happy Person',
        onlineBlue: false,ChatText: 'السلام عليكم',onlineInTheChat: true),
    ChatsModel(
        imageUrlChat:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSk9VUBAOPaRCLL3hMt605BBSNNKNy4ykMCgg&usqp=CAU",
        personAccountNameChat:  'John Weak',
        onlineBlue: true,ChatText: 'together',onlineInTheChat: false),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
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
              '  Chat',
              style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(children: [
          chatList(),
          chatListVertical(),
        ],),
      ),
    );
  }


  Widget chatList() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 150, // تحديد العرض
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: const Color(0xFFA4A4A4),
                    borderRadius: BorderRadius.circular(
                        40), // جعل الحاوية دائرية
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.black87),
                        border: InputBorder.none, // إزالة الحدود
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 87,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: chatListsHorizonta.length,
              itemBuilder: (context, index) {
                return index == 0
                    ? yourStoryView()
                    : InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Stack(alignment: Alignment.bottomRight,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Visibility(
                                  visible: chatListsHorizonta[index].shown,
                                  child: CircleAvatar(
                                    radius: 33,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      color: Colors.blue
                                      ),
                                    ),
                                  ),
                                ),
                                const CircleAvatar(
                                  radius: 31,
                                  backgroundColor: Colors.white,
                                ),
                                CircleAvatar(
                                  radius: chatListsHorizonta[index].shown ? 30 : 33,
                                  backgroundImage:
                                  NetworkImage(chatListsHorizonta[index].imageUrl),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: chatListsHorizonta[index].online ? 7 : 0,
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                        Text(chatListsHorizonta[index].personAccountName),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
  Widget yourStoryView() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 29,
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvIzpE0RtC7z7mNKlGCfZVu-76ycBg8B0nPw&usqp=CAU'),
              ),
              CircleAvatar(
                radius: 9,
                backgroundColor: Colors.white,
              ),
              CircleAvatar(
                radius: 8,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.add,
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Text('Add Story'),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget chatListVertical() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 9,top: 10),
        child: ListView.builder(
          itemCount: chatLists.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage:
                          NetworkImage(chatLists[index].imageUrlChat),
                        ),
                        CircleAvatar(
                          radius: chatLists[index].onlineInTheChat ? 7 : 0,
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chatLists[index].personAccountNameChat,
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                          ),
                          Text(
                            maxLines: 1,
                            chatLists[index].ChatText,
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: chatLists[index].onlineBlue ? 7 : 0,
                      backgroundColor: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 9.0),
                //   child: RichText(
                //     text: TextSpan(
                //       text: '',
                //       style: DefaultTextStyle.of(context).style,
                //       children: <TextSpan>[
                //         TextSpan(
                //             text: posts[index].textPoster,
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //             )),
                //         TextSpan(
                //             text: posttext[index],
                //             style: TextStyle(
                //               fontWeight: FontWeight.normal,
                //             )),
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 12,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

