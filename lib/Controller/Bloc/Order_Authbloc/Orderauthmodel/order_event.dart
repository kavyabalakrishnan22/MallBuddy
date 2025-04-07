part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class PlaceorderEvent extends OrderEvent {
  final OrderModel order;
  PlaceorderEvent({required this.order});
}
class FetchPlaceorderEvent extends OrderEvent {
  final String? searchQuery;
  final String? status;
  FetchPlaceorderEvent({required this.searchQuery, required this.status});
}
class OrderDelete extends OrderEvent {
  final String? orderid;
  OrderDelete({required this.orderid});
}




















