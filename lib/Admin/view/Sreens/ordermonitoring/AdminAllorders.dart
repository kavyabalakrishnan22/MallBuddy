import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_bud/Admin/Model/ordermonitoring_model/All_order_model.dart';
import '../../../../Controller/Bloc/Order_Authbloc/Orderauthmodel/order_bloc.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../../../Model/User_Management/shop_model.dart';

class Adminallorderswrapper extends StatelessWidget {
  const Adminallorderswrapper({super.key});

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
      child: AdminAllOrders(),
    );
  }
}

class AdminAllOrders extends StatefulWidget {
  const AdminAllOrders({super.key});

  @override
  State<AdminAllOrders> createState() => _AdminAllOrdersState();
}

class _AdminAllOrdersState extends State<AdminAllOrders>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<int, bool> selectedEdit = {};
  Map<int, bool> selectedDelete = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this); // FIXED: length = 4
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Hello,", style: TextStyle(fontSize: 22)),
                    Text("Good Morning Team!",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(
                      "Unlock insights, track growth, and manage performance effortlessly.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 0.5, color: Colors.grey)),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 0.5, color: Colors.grey)),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/profile/girl.png'),
                          ),
                          SizedBox(width: 10),
                          Text("Admin",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // TabBar
            TabBar(
              controller: _tabController, // FIXED: Using only one TabController
              isScrollable: true,
              indicatorColor: Colors.blue,
              indicatorWeight: 3,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "All Orders"),
                // Tab(text: "Complete Order"),
                // Tab(text: "Rider Performance "),
                // Tab(text: "Customer Feedback"),
              ],
            ),

            const SizedBox(height: 10),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics:
                    const BouncingScrollPhysics(), // FIXED: Ensures smooth scrolling
                children: [
                  _buildShopTable("All Shops"),
                  // AdminCompleteOrders(),
                  // AdminRidrPerformnace(),
                  // AdminRejectedShop(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build shop tables dynamically
  Widget _buildShopTable(String title) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderRefresh) {
          context
              .read<OrderBloc>()
              .add(FetchPlaceorderEvent(searchQuery: null, status: '0'));
        }
      },
      builder: (context, state) {
        if (state is OrderLoading) {
          return Center(child: Loading_Widget());
        } else if (state is Orderfailerror) {
          return Text(state.error.toString());
        } else if (state is Ordersloaded) {
          if (state.Orders.isEmpty) {
            // Return "No data found" if txhe list is empty
            return Center(
              child: Text(
                "No data found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: MediaQuery.of(context).size.width),
              child: DataTable(
                dataRowMaxHeight: 100,
                decoration: const BoxDecoration(color: Colors.white),
                columns: [
                  _buildColumn('SL NO'),
                  _buildColumn('Date and Time'),
                  _buildColumn('Order Details'),
                  _buildColumn('Rider Details'),
                  _buildColumn('Customer Details'),
                  _buildColumn('Vehicle Details'),
                  _buildColumn('Total Amount'),
                  _buildColumn('Status'),
                  _buildColumn('Delete'),
                ],
                rows: List.generate(
                  state.Orders.length,
                  (index) {
                    final allorder = state.Orders[index];
                    return DataRow(
                      cells: [
                        DataCell(Text((index + 1).toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(Text(allorder.time.toString())),
                        // DataCell(Text(allorder.Ownername.toString())),
                        // DataCell(Text(allorder.Ridername.toString())),
                        // DataCell(Text(allorder.invoiceid.toString())),

                        //Order Details//
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Order_ID:"),
                                  Text(
                                    allorder.orderid.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Invoice_ID:"),
                                  Text(
                                    allorder.invoiceid.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Floor:"),
                                  Text(
                                    allorder.Selectfloor.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("DelieryTime:"),
                                  Text(
                                    allorder.time.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        //Rider Detaisl//
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Rider_ID:"),
                                  Text(
                                    allorder.riderid.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Rider_Name:"),
                                  Text(
                                    allorder.Ridername.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Mobile:"),
                                  Text(
                                    allorder.conatctrider.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Email:"),
                                  Text("rideremail@gmail.com"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //Customer Details//
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("User_ID:"),
                                  Text(
                                    allorder.userid.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("User_Name:"),
                                  Text(
                                    allorder.Ownername.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Mobile:"),
                                  Text(
                                    allorder.userphone.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Email:"),
                                  Text(
                                    allorder.useremail.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //Vehicle Details//
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Vehicle_Number:"),
                                  Text(
                                    allorder.vehicle_number.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Vehicle_Name:"),
                                  Text(
                                    allorder.vehicle_name.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Vehicle_Color:"),
                                  Text(
                                    allorder.vehicle_color.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text("1000")),
                        DataCell(Text(allorder.status.toString())),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Confirm Delete"),
                                    content: Text(
                                        "Are you sure you want to delete this item?"),
                                    actions: [
                                      TextButton(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close dialog
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          context.read<OrderBloc>().add(
                                                OrderDelete(
                                                    orderid:
                                                        allorder.orderid ?? ''),
                                              );
                                          Navigator.of(context)
                                              .pop(); // Close dialog
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ).then(
                                (value) {
                                  context.read<OrderBloc>()
                                    ..add(FetchPlaceorderEvent(
                                        status: "0", searchQuery: null));
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: BorderSide(color: Colors.red, width: 1.5),
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: Text('Delete'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  DataColumn _buildColumn(String title) {
    return DataColumn(
      label: Text(
        title,
        style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
    );
  }

  // Widget _buildToggleButton(String text, int index, bool isEdit) {
  //   bool isSelected = isEdit
  //       ? (selectedEdit[index] ?? false)
  //       : (selectedDelete[index] ?? false);
  //
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: ElevatedButton(
  //         style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all(
  //               isSelected ? Colors.blue : Colors.white),
  //           foregroundColor: MaterialStateProperty.all(
  //               isSelected ? Colors.white : Colors.black),
  //           padding: MaterialStateProperty.all(
  //               const EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
  //           shape: MaterialStateProperty.all(
  //             RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               side:
  //                   BorderSide(color: isSelected ? Colors.blue : Colors.black),
  //             ),
  //           ),
  //         ),
  //         onPressed: () {
  //           setState(() {
  //             if (isEdit) {
  //               selectedEdit[index] = !(selectedEdit[index] ?? false);
  //             } else {
  //               selectedDelete[index] = !(selectedDelete[index] ?? false);
  //               _showDeleteDialog(index);
  //             }
  //           });
  //         },
  //         child: SizedBox(
  //             width: 90, height: 50, child: Center(child: Text(text)))),
  //   );
  // }

  // void _showDeleteDialog(int index) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("Confirm Delete"),
  //         content: const Text("Are you sure you want to delete this shop?"),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text("Cancel"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 shops.removeAt(index);
  //               });
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text("Delete", style: TextStyle(color: Colors.red)),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Widget _buildOutlinedButton(
  //     String text, Color textColor, Color borderColor, VoidCallback onPressed) {
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: OutlinedButton(
  //       style: OutlinedButton.styleFrom(
  //         foregroundColor: textColor, // Text color
  //         side: BorderSide(color: borderColor), // Border color
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //         padding: const EdgeInsets.symmetric(
  //             horizontal: 20, vertical: 12), // Button padding
  //       ),
  //       onPressed: onPressed,
  //       child: Text(
  //         text,
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //   );
  // }
}
