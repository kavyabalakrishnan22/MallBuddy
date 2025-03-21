import 'package:flutter/cupertino.dart';

import 'order_auth_model.dart';

@immutable
sealed class OrderAuthEvent {}

class checkOrderloginstateevent extends OrderAuthEvent {}

// login

class OrderLoginEvent extends OrderAuthEvent {
  final String Email;
  final String Password;

  OrderLoginEvent({required this.Email, required this.Password});
}

// Signup
class OrderSignupEvent extends OrderAuthEvent {
  final OrderModel user;
  OrderSignupEvent({required this.user});
}

//signout

class OrderSigOutEvent extends OrderAuthEvent {}

//fetch details from shops
class FetchOrderDetailsById extends OrderAuthEvent {}

//fetch all shop

class FetchOrderDetailsEvent extends OrderAuthEvent {
  final String? searchQuery;
  final String? status;
  FetchOrderDetailsEvent({required this.searchQuery, required this.status});
}
