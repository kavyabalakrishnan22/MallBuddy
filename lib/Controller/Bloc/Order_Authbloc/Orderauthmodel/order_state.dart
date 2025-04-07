part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderSuccess extends OrderState {}

final class OrderRefresh extends OrderState {}

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
