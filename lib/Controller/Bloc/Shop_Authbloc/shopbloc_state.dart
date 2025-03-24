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

//Get all shopes

final class ShopgetLoading extends ShopAuthState {}

final class ShopGetSuccess extends ShopAuthState {}

final class Shopesfailerror extends ShopAuthState {
  final String error;

  Shopesfailerror(this.error);
}

class Shopesloaded extends ShopAuthState {
  final List<ShopModel> Shopes;

  Shopesloaded(
    this.Shopes,
  );
}

// Acept reject

final class ShopAcceptloading extends ShopAuthState {}

final class ShopRefresh extends ShopAuthState {}
