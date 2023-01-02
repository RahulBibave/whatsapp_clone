
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/widget/error.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_clone/features/select_contact/screens/select_contact_screen.dart';
import 'package:whatsapp_clone/features/chat/screens/mobile_chat_screen.dart';

Route<dynamic>generateRaute(RouteSettings settings){
  switch(settings.name){
    case LoginScreen.routeName:
      return MaterialPageRoute(
          builder: (context)=> const LoginScreen()
      );

    case OTPScreen.routeName:
      final verificationId=settings.arguments as String;
      return MaterialPageRoute(
          builder: (context)=>  OTPScreen(verificationId: verificationId,)
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
          builder: (context)=>  const UserInformationScreen()
      );
    case SelectContactScreen.routeName:
      return MaterialPageRoute(
          builder: (context)=>  const SelectContactScreen()
      );
    case MobileChatScreen.routeName:
      final arguments=settings.arguments as Map<String, dynamic>;
      final name=arguments['name'];
      final uid=arguments['uid'];
      return MaterialPageRoute(
          builder: (context)=>   MobileChatScreen(uid: uid,name: name,)
      );
    default:
      return MaterialPageRoute(builder: (context)=> const Scaffold(
        body: ErrorScreen(error: 'Page does not exist'),
      ));
  }
}