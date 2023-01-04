import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clone/common/enums/messages_enum.dart';
import 'package:whatsapp_clone/features/chat/widgets/video_player_item.dart';

class DisplayTextImageGif extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayTextImageGif({Key? key, required this.message, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type==MessageEnum.text?Text(
      message,
      style: TextStyle(
        fontSize: 16,
      ),
    ):type ==MessageEnum.video? VideoPlayerItem(videoUrl: message,):CachedNetworkImage(imageUrl: message,width: 200,height: 200,);
  }
}
