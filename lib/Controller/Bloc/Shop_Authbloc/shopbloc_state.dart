

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


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
