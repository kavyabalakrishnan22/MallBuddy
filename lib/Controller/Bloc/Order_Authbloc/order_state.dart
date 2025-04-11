part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderSuccess extends OrderState {}

final class OrderRefresh extends OrderState {}

final class BuddyOrderAcceptloading extends OrderState {}

final class BuddyOrderRefresh extends OrderState {}

final class UserSendComplaintSuccess extends OrderState {

}


final class UserSendComplaintloading extends OrderState {}

final class UserSendComplaintRefresh extends OrderState {}

final class Orderfailerror extends OrderState {
  final String error;

  Orderfailerror(this.error);
}

class Ordersloaded extends OrderState {
  final List<OrderModel> Orders;

  Ordersloaded(
    this.Orders,
  );
}

class scanndeliverdLoading extends OrderState {}

class Scannersuccess extends OrderState {}

class Deliverderror extends OrderState {
  final String error;
  Deliverderror({required this.error});
}
