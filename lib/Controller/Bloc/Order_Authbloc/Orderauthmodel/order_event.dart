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
  final String? shopid;
  final String? Deliverd;
  final String? Riderid;
  FetchPlaceorderEvent(
      {required this.searchQuery, this.status, this.shopid, this.Deliverd,this.Riderid});
}

class OrderDelete extends OrderEvent {
  final String? orderid;
  OrderDelete({required this.orderid});
}
