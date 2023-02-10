import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labbaik/app/2chat/helpers/data_util.dart';
import 'package:labbaik/app/2chat/model/chatUser.dart';
import 'package:labbaik/app/2chat/model/message.dart';
import 'package:labbaik/app/2chat/widgets/message_card.dart';
import 'package:labbaik/main.dart';
import 'package:labbaik/shared/constant/colors.dart';

import '../api/apis.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for storing all messages
  List<Message> _list = [];

  //for handling message text changes
  final _textController = TextEditingController();

  //showEmoji -- for storing value of showing or hiding emoji
  //isUploading -- for checking if image is uploading or not?
  bool _showEmoji = false, _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          //if emojis are shown & back button is pressed then hide emojis
          //or else simple close current screen on back button click
          onWillPop: () {
            if (_showEmoji) {
              setState(() => _showEmoji = !_showEmoji);
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            //app bar
            appBar: AppBar(
              backgroundColor: color1,
              automaticallyImplyLeading: false,
              flexibleSpace: _appBar(),
            ),

            backgroundColor: const Color.fromARGB(255, 234, 248, 255),

            //body
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: APIs.getAllMessages(widget.user),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        //if data is loading
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const SizedBox();

                        //if some or all data is loaded then show it
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          _list = data
                                  ?.map((e) => Message.fromJson(e.data()))
                                  .toList() ??
                              [];

                          if (_list.isNotEmpty) {
                            return ListView.builder(
                                reverse: true,
                                itemCount: _list.length,
                                padding: EdgeInsets.only(top: mq.height * .01),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return MessageCard(message: _list[index]);
                                });
                          } else {
                            return const Center(
                              child: Text('',
                                  style: TextStyle(fontSize: 20)),
                            );
                          }
                      }
                    },
                  ),
                ),

                //progress indicator for showing uploading
                if (_isUploading)
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: CircularProgressIndicator(strokeWidth: 2))),

                //chat input filed
                _chatInput(),

                //show emojis on keyboard emoji button click & vice versa
                if (_showEmoji)
                  SizedBox(
                    height: mq.height * .35,
                    child: EmojiPicker(
                      textEditingController: _textController,
                      config: Config(
                        bgColor: const Color.fromARGB(255, 234, 248, 255),
                        columns: 8,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // app bar widget
  Widget _appBar() {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => ViewProfileScreen(user: widget.user)));
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamBuilder(
              stream: APIs.getUserInfo(widget.user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list =
                    data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                        [];

                return Row(
                  children: [
                    //back button
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_outlined, color:white,size:28)),

                    //user profile picture
                    ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .03),
                      child: CachedNetworkImage(
                        width: mq.height * .05,
                        height: mq.height * .05,
                        imageUrl:
                            list.isNotEmpty ? list[0].image : 'https://i.ibb.co/mRFd2v8/Labbaik.png',
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                                child: Icon(CupertinoIcons.person)),
                      ),
                    ),

                    //for adding some space
                    const SizedBox(width: 10),

                    //user name & last seen time
                    Padding(
                      padding: const EdgeInsets.only(top:4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //user name
                          Text(list.isNotEmpty ? list[0].name : widget.user.name,
                              style:  TextStyle(
                                  fontSize: 16,
                                  color: white,
                                  fontWeight: FontWeight.w500)),
                    
                          //for adding some space
                          const SizedBox(height: 2),
                    
                          //last seen time of user
                          Text(
                              list.isNotEmpty
                                  ? list[0].isOnline
                                      ? 'متصل الان'
                                      : MyDateUtil.getLastActiveTime(
                                          context: context,
                                          lastActive: list[0].lastActive)
                                  : MyDateUtil.getLastActiveTime(
                                      context: context,
                                      lastActive: widget.user.lastActive),
                              style:   TextStyle(
                                  fontSize: 13, color:white)),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ));
  }

  // bottom chat input field
  Widget _chatInput() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: mq.height * .01, horizontal: mq.width * .025),
        child: Row(
          children: [
            //input field & buttons
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    //emoji button
                    IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          setState(() => _showEmoji = !_showEmoji);
                        },
                        icon:  Icon(Icons.emoji_emotions,
                            color: color1, size: 25)),

                    Expanded(
                        child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onTap: () {
                        if (_showEmoji)
                          setState(() => _showEmoji = !_showEmoji);
                      },
                      decoration:  InputDecoration(
                          hintText: 'رساله جديده...',
                          hintStyle: TextStyle(color: color1),
                          border: InputBorder.none),
                    )),

                    //pick image from gallery button
                    IconButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();

                          // Picking multiple images
                          final List<XFile> images =
                              await picker.pickMultiImage(imageQuality: 70);

                          // uploading & sending image one by one
                          for (var i in images) {
                            log('Image Path: ${i.path}');
                            setState(() => _isUploading = true);
                            await APIs.sendChatImage(widget.user, File(i.path));
                            setState(() => _isUploading = false);
                          }
                        },
                        icon:  Icon(Icons.image,
                            color: color1, size: 26)),

                    //take image from camera button
                    IconButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();

                          // Pick an image
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.camera, imageQuality: 70);
                          if (image != null) {
                            log('Image Path: ${image.path}');
                            setState(() => _isUploading = true);

                            await APIs.sendChatImage(
                                widget.user, File(image.path));
                            setState(() => _isUploading = false);
                          }
                        },
                        icon:  Icon(Icons.camera_alt_rounded,
                            color: color1, size: 26)),

                    //adding some space
                    SizedBox(width: mq.width * .02),
                  ],
                ),
              ),
            ),

            //send message button
            MaterialButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  if (_list.isEmpty) {
                    //on first message (add user to my_user collection of chat user)
                    APIs.sendFirstMessage(
                        widget.user, _textController.text, Type.text);
                  } else {
                    //simply send message
                    APIs.sendMessage(
                        widget.user, _textController.text, Type.text);
                  }
                  _textController.text = '';
                }
              },
              minWidth: 0,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 10, left: 5),
              shape: const CircleBorder(),
              color: white,
              child:  Icon(Icons.send, color: color1, size: 24),
            )
          ],
        ),
      ),
    );
  }
}
