import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_reposotory.dart';
import 'package:whatsapp_clone/models/user_model.dart';

final authControllerProvider=Provider(
        (ref) {
          final authRepository=ref.watch(authRepositoryProvider);
          return AuthController(authRepository: authRepository,ref:ref);
        });

final userDataAuthProvider =FutureProvider((ref)  {
  final authContoller=ref.watch(authControllerProvider);
  return authContoller.getUserData();
});


class AuthController{
  final ProviderRef ref;
  final AuthRepository authRepository;
  AuthController( {required this.ref,required this.authRepository});

  Future<UserModel?>getUserData()async{
    UserModel? user=await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithPhone(BuildContext context,String phoneNumber){
    authRepository.signInWithPhone(context, phoneNumber);
  }
  void verifyOTP(BuildContext context,String verificationId, String userOTP){
    authRepository.verifyOTP(context: context, verificationId: verificationId, userOTp: userOTP);
  }
  void saveUserDataToFirebase(BuildContext context,String name,File? profilePic,){
    authRepository.saveUserDataToFirebase(name: name, profilePic: profilePic, ref: ref, context: context);

  }
  Stream<UserModel> userDataById(String userId){
    return authRepository.userData(userId);
  }
}