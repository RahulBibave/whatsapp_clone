import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/enums/messages_enum.dart';


import '../../../colors.dart';
import 'display_text_image_gif.dart';



class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  const MyMessageCard({Key? key,required this.message,required this.date, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width-45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: messageColor,
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Stack(
            children: [
              Padding(padding: type==MessageEnum.text? EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20
              ):EdgeInsets.only(left: 5,top: 5,right: 5,bottom: 25),
                child: DisplayTextImageGif(message: message,type: type,)
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(date,style: TextStyle(fontSize: 13,color: Colors.white60),),
                    SizedBox(width: 5,),
                    Icon(Icons.done_all,size: 20,color: Colors.white60,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
