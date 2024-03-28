import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:http/http.dart' as http;
import 'package:placed_mobile_app/widgets/back_arrow.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _chatHistory = [];
  bool isLoading = false;

  void toggleLoading(){
    setState(() {
      isLoading = !isLoading;
    });
  }

  void getAnswer() async {
    final url = "https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=AIzaSyAZMaIwWvxMf_X_WO27lfbp8sZbqgA5aQQ";
    final uri = Uri.parse(url);
    List<Map<String,String>> msg = [];
    for (var i = 0; i < _chatHistory.length; i++) {
      msg.add({"content": _chatHistory[i]["message"]});
    }

    Map<String, dynamic> request = {
      "prompt": {
        "messages": [msg]
      },
      "temperature": 0.25,
      "candidateCount": 1,
      "topP": 1,
      "topK": 1
    };

    final response = await http.post(uri, body: jsonEncode(request));

    setState(() {
      _chatHistory.add({
        "time": DateTime.now(),
        "message": json.decode(response.body)["candidates"][0]["content"],
        "isSender": false,
      });
      isLoading = !isLoading;
    });

    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: BackArrow(),
        title: Text("Placed AI", style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
      ),
      bottomSheet: isLoading ? Container(
        color: Colors.white,
        height: 70, width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LinearProgressIndicator(color: Color(0xFF3269FF),),
            Text('Placed AI is thinking...')
          ],
        ),
      ) : Container(height: 1, width: 1,),
      body: Stack(
        children: [
          Container(
            //get max height
            height: MediaQuery.of(context).size.height - 160,
            child: ListView.builder(
              itemCount: _chatHistory.length,
              shrinkWrap: false,
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index){
                return Container(
                  padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                  child: Align(
                    alignment: (_chatHistory[index]["isSender"]?Alignment.topRight:Alignment.topLeft),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: (_chatHistory[index]["isSender"]?const Color(0xFF3269FF):Colors.white),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(_chatHistory[index]["message"], style: TextStyle(fontSize: 15, color: _chatHistory[index]["isSender"]?Colors.white:Colors.black)),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              height: 70,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0XFF2D64FA), Color(0XFF43D2DF)
                              ]
                          ),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Center(
                          child: SingleChildScrollView(
                            child: TextFormField(
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: "Type a message",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              controller: _chatController,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0,),
                  MaterialButton(
                    onPressed: (){
                      setState(() {
                        isLoading = !isLoading;
                        if(_chatController.text.isNotEmpty){
                          _chatHistory.add({
                            "time": DateTime.now(),
                            "message": _chatController.text,
                            "isSender": true,
                          });
                          _chatController.clear();
                        }
                      });
                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );
                      getAnswer();
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0XFF2D64FA), Color(0XFF43D2DF)
                            ]
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Container(
                          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Icon(Icons.send, color: Colors.white,)
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
