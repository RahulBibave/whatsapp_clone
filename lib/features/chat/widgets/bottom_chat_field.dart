import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_contoller.dart';

import '../../../colors.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  const BottomChatField(this.recieverUserId, {Key? key}) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton=false;
  final TextEditingController _messageController=TextEditingController();
  @override
  void dispose(){
    super.dispose();
    _messageController.dispose();
  }
  void sendTextMessage()async{
    if(isShowSendButton){
      ref.read(chatControllerProvider).sendTextMessage(context, _messageController.text.trim(), widget.recieverUserId);
    };

    setState((){
      _messageController.text='';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _messageController,
            onChanged: (val){
              if(val.isNotEmpty){
                setState((){
                  isShowSendButton=true;
                });
              }else{
                setState((){
                  isShowSendButton=false;
                });
              }
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: mobileChatBoxColor,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: (){},
                          icon: const Icon(
                            Icons.emoji_emotions,color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: (){},
                          icon: const Icon(
                            Icons.gif,color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                suffixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: (){},
                          icon: const Icon(  Icons.camera_alt,color: Colors.grey, )),
                      IconButton(
                          onPressed: (){},
                          icon: const Icon(  Icons.attach_file,color: Colors.grey, )),

                    ],
                  ),
                ),
                hintText: 'Type a message',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none
                    )
                ),
                contentPadding: const EdgeInsets.all(10)
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0,right: 2.0,left: 2.0),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFF128C7E),
            child: GestureDetector(
                onTap: sendTextMessage,
                child: Icon(isShowSendButton?Icons.send:Icons.mic,color: Colors.white,)),
          ),
        )
      ],
    );
  }
}
