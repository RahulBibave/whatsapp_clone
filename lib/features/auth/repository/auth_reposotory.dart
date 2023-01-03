import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/repositories/common_firebase_storage_repository.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_information_screen.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/mobile_screen_layout.dart';

final authRepositoryProvider=Provider(
        (ref) => AuthRepository(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));
class AuthRepository{
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  Future<UserModel?>getCurrentUserData()async{
    var userData = await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if(userData.data()!=null){
      user =UserModel.fromMap(userData.data()!);
    }
    return user;
  }


  void signInWithPhone(BuildContext context, String phoneNumber)async {
    try{
        await auth.verifyPhoneNumber(phoneNumber: phoneNumber,verificationCompleted: (PhoneAuthCredential credential) async{
          await auth.signInWithCredential(credential);
        },verificationFailed: (e){throw Exception(e.message);},
        codeSent: ((String verificationID,int? resendToken)async{
          Navigator.pushNamed(context, OTPScreen.routeName,arguments: verificationID);
        }),codeAutoRetrievalTimeout: (String verificationID){

            });
    }on FirebaseAuthException catch(e){
        showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP({required BuildContext context,required String verificationId,required String userOTp})async{
    try{
      PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOTp);
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(context, UserInformationScreen.routeName, (route) => false);
    }on FirebaseAuthException catch(e){
      showSnackBar(context: context, content: e.message!);
    }

  }
  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  })async{
    try{
      String uid=auth.currentUser!.uid;
      String photoUrl='https://images.unsplash.com/photo-1624700636207-a02b569c9457?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';
      if(profilePic!=null){
        photoUrl=await ref.read(commonFirebaseStorageRepositoryProvider).storeFileToFirebase('profilrPic/$uid', profilePic);
      }
      var user = UserModel(name: name, uid: uid, profilePic: photoUrl, isOnline: true, phoneNumber: auth.currentUser!.phoneNumber.toString(), groupId: []);
      await firestore.collection('users').doc(uid).set(user.toMap());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const MobileScreenLayout(),), (route) => false);
    }catch(e){
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<UserModel>userData(String userId){
    return firestore.collection('users').doc(userId).snapshots().map((event) => UserModel.fromMap(event.data()!));
  }
  void setUserState(bool isOnline)async{
    await firestore.collection('users').doc(auth.currentUser!.uid).update(

      {
        'isOnline':isOnline,
      }
    );
  }

}