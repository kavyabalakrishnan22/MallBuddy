import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mall_bud/Controller/Bloc/Order_Authbloc/Orderauthmodel/order_model.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});

    on<PlaceorderEvent>(
      (event, emit) async {
        emit(OrderLoading());
        try {
          var orderRef = FirebaseFirestore.instance
              .collection("Orders")
              .doc(); // Generate ID
          String orderId = orderRef.id; // Get the generated ID

          await orderRef.set({
            "useremail": event.order.useremail,
            "uid": event.order.userid,
            "invoiceid": event.order.invoiceid,
            "orderid": orderId,
            "riderid": event.order.riderid,
            "ownername": event.order.Ownername,
            "userphone": event.order.userphone,
            "Timestamp": DateTime.now(),
            "shopid": event.order.shopid,
            "selectfloor": event.order.Selectfloor,
            "vehicle_name": event.order.vehicle_name,
            "vehicle_color": event.order.vehicle_color,
            "vehicle_number": event.order.vehicle_number,
            "ridername": event.order.Ridername,
            "contact_rider": event.order.conatctrider,
            "status": "0",
            "payment": "0",
            "Deliverd": "0",
          });

          emit(OrderSuccess());
        } catch (e) {
          emit(Orderfailerror(e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );

    on<OrderDelete>((event, emit) async {
      emit(OrderLoading());
      try {
        FirebaseFirestore.instance
            .collection("Orders")
            .doc(event.orderid)
            .delete();
        emit(OrderRefresh());
      } catch (e) {
        emit(Orderfailerror(e.toString()));
      }
    });

    on<FetchPlaceorderEvent>((event, emit) async {
      emit(OrderLoading());

      try {
        CollectionReference OrderCollection =
            FirebaseFirestore.instance.collection('Orders');

        Query query = OrderCollection;
        query = query.where("status", isEqualTo: event.status);
        query = query.where("shopid", isEqualTo: event.shopid);
        query = query.where("Deliverd", isEqualTo: event.Deliverd);
        query = query.where("riderid", isEqualTo: event.Riderid);

        QuerySnapshot snapshot = await query.get();

        List<OrderModel> Orders = snapshot.docs.map((doc) {
          return OrderModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          Orders = Orders.where((driver) {
            return driver.Ownername!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Ordersloaded(Orders));
      } catch (e) {
        emit(Orderfailerror(e.toString()));
      }
    });
  }
}
