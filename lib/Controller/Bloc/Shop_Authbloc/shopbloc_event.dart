

import 'package:flutter/cupertino.dart';

import 'Shopauthmodel/Shopauthmodel.dart';

@immutable
sealed class ShopAuthEvent {}

class checkShoploginstateevent extends ShopAuthEvent {}

// login

class ShopLoginEvent extends ShopAuthEvent {
  final String Email;
  final String Password;

  ShopLoginEvent({required this.Email, required this.Password});
}

// Signup
class ShopSignupEvent extends ShopAuthEvent {
  final ShopModel user;
  ShopSignupEvent({required this.user});
}

//signout

class ShopSigOutEvent extends ShopAuthEvent {}

//fetch details from shops
class FetchShopDetailsById extends ShopAuthEvent {}
