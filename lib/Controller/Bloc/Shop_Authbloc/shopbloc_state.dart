

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'Shopauthmodel/Shopauthmodel.dart';


@immutable
sealed class ShopAuthState {}

final class ShopAuthInitial extends ShopAuthState {}

class ShopAuthloading extends ShopAuthState {}

class ShopAuthenticated extends ShopAuthState {
  User? user;
  ShopAuthenticated(this.user);
}

class ShopUnAuthenticated extends ShopAuthState {}

class ShopAuthenticatedError extends ShopAuthState {
  final String message;

  ShopAuthenticatedError({required this.message});
}

//
final class ShopByidLoaded extends ShopAuthState {
  final ShopModel Userdata;
  ShopByidLoaded(this.Userdata);
}

class Shoploading extends ShopAuthState {}

class Shoperror extends ShopAuthState {
  String error;
  Shoperror({required this.error});
}