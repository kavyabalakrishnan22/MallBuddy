import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';

import '../../../Controller/Bloc/Order_Authbloc/Orderauthmodel/order_bloc.dart';
import '../../../Widgets/Constants/Loading.dart';
import '../../Bottomnav/Shop_Bottom.dart';
String buttonText = "View Details"; // Set the appropriate text



class Shoporderstatuswrapper extends StatelessWidget {
  const Shoporderstatuswrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc()
        ..add(
          FetchPlaceorderEvent(
            searchQuery: null,
            status: '0',
          ),
        ),
      child: ShopOrderhistory(),
    );
  }
}
class ShopOrderhistory extends StatefulWidget {
  const ShopOrderhistory({super.key});

  @override
  State<ShopOrderhistory> createState() => _ShopOrderhistoryState();
}

class _ShopOrderhistoryState extends State<ShopOrderhistory> {
  // Active Tab
  String activeTab = "All orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ShopBottomnavwrapper(),));},
        ),
        title: const Text(
          "My orders",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/logo.png"),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OrderLoading) {
              return Center(child: Loading_Widget());
            } else if (state is Orderfailerror) {
              return Text(state.error.toString());
            } else if (state is Ordersloaded) {
              if (state.Orders.isEmpty) {
                return Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: state.Orders.length,
                  itemBuilder: (context, index) {
                    final Order = state.Orders[index];
                    return Card(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${Order.riderid.toString()}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                const Text("Status ",
                                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                                Text(
                                  "Status : ${Order.status}",
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${Order.riderid.toString()}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Total items : 9",
                                style: TextStyle(fontSize: 14, color: Colors.black)),
                            Text(
                              "${Order.payment.toString()}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: defaultBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: defaultBlue == Colors.black
                                        ? BorderSide(color: Colors.black)
                                        : BorderSide.none,
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(buttonText,
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );

  }
  Widget _buildTabButton(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTab = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: activeTab == text ? defaultBlue : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: activeTab == text ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


}