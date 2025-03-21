// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'order_auth_model.dart';

@immutable
sealed class OrderAuthState {}

final class OrderAuthInitial extends OrderAuthState {}

class OrderAuthloading extends OrderAuthState {}

class OrderAuthenticated extends OrderAuthState {
  User? user;
  OrderAuthenticated(this.user);
}

class OrderUnAuthenticated extends OrderAuthState {}

class OrderAuthenticatedError extends OrderAuthState {
  final String message;

  OrderAuthenticatedError({required this.message});
}

//
final class OrderByidLoaded extends OrderAuthState {
  final OrderModel Userdata;
  OrderByidLoaded(this.Userdata);
}

class Orderloading extends OrderAuthState {}

class Ordererror extends OrderAuthState {
  String error;
  Ordererror({required this.error});
}

//Get all Order

final class OrdergetLoading extends OrderAuthState {}

final class OrderGetSuccess extends OrderAuthState {}

final class Orderfailerror extends OrderAuthState {
  final String error;

  Orderfailerror(this.error);
}

class Orderloaded extends OrderAuthState {
  final List<OrderModel> Orders;

  Orderloaded(
      this.Orders,
      );
}
