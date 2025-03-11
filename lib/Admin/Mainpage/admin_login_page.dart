import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';

import '../../User/View/Screens/Home/User_shop.dart';
import '../view/Sreens/Dashboard/dashboard.dart';
import '../view/Sreens/Usermanagement/Shop.dart';
import '../view/Sreens/Usermanagement/buddy.dart';
import '../view/Sreens/Usermanagement/customer.dart';
import '../view/Sreens/ordermonitoring/complete orders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: defaultBlue),
          useMaterial3: true,
        ),
        home: AdminPage());
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Widget? _selectedPage; // Variable to hold the currently selected page
  String? _selectedTile; // Tracks the selected tile
  String? _expandedTile;

  @override
  void initState() {
    // TODO: implement initState
    _selectedPage = Dashboard();
    _selectedTile = "Dashboard";
    super.initState();
  }

  var mainExpansionSelectedColor = Colors.blue.shade900;
  var SubExpansionSelectedColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left side: Management options
          Container(
            color: Colors.white,
            width: 300,
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        width: 60,
                        height: 80,
                      ),
                      //SizedBox(width: 8,),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "Welcome to,",
                      //       style: TextStyle(fontSize: 13, color: Colors.black),
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text(
                      //           "Laundry Mate",
                      //           style: TextStyle(
                      //               fontSize: 28,
                      //               color: defaultBlue,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ],
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
                // //////////////////////
                _buildMainListTile('Dashboard', const Dashboard(),
                    icon: Icons.dashboard),
                // /////////////////////////

                _buildMainExpansionTile(
                  title: 'User Management',
                  icon: Icons.perm_identity_sharp,
                  children: [
                    SubListTile("Customer", AdminCustomer()),
                    SubListTile("Buddy", Buddy()),
                    SubListTile("Shop", AdminShop()),
                  ],
                ),
                _buildMainExpansionTile(
                  title: 'Order Monitoring',
                  icon: Icons.monitor_heart_outlined,
                  children: [
                    SubListTile("All Order", Admin_Complete_orders()),
                    SubListTile("Completed order", Admin_Complete_orders()),
                    SubListTile("Rider Performance", Admin_Complete_orders()),
                    SubListTile("Customer Feedback", Admin_Complete_orders()),
                  ],
                ),
                _buildMainExpansionTile(
                  title: 'Service Customization',
                  icon: Icons.phonelink_setup_outlined,
                  children: [
                    SubListTile("Delivery Fees", Admin_Complete_orders()),
                    SubListTile("Rider Incentives", Admin_Complete_orders()),
                    SubListTile("Delivery Time", Admin_Complete_orders()),
                  ],
                ),
                _buildMainListTile('Reports', const Dashboard(),
                    icon: Icons.event_note_outlined),
              ],
            ),
          ),
          // Right side: Display selected page or add role form
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: _selectedPage ??
                  Center(
                    child: const Text('Select a management option'),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainExpansionTile({
    required String title,
    IconData? icon, // Made optional
    required List<Widget> children,
    e,
  }) {
    return ExpansionTile(
      textColor: mainExpansionSelectedColor,
      iconColor: mainExpansionSelectedColor,
      leading: Icon(
        icon,
      ), // Show icon only if it's provided
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(
        title,
        style: TextStyle(fontSize: 17),
      ),
      childrenPadding: EdgeInsets.zero,
      initiallyExpanded: _expandedTile == title,
      onExpansionChanged: (isExpanded) {
        setState(() {
          _expandedTile = isExpanded ? title : null; // Collapse other tiles
        });
      },
      children: children,
    );
  }

  Widget _buildESubxpansion({
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      textColor: SubExpansionSelectedColor,
      iconColor: SubExpansionSelectedColor,
      leading: Icon(
        null,
      ), // Show icon only if it's provided
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
      childrenPadding: EdgeInsets.zero,
      initiallyExpanded: _expandedTile == title,
      onExpansionChanged: (isExpanded) {
        setState(() {
          _expandedTile = isExpanded ? title : null; // Collapse other tiles
        });
      },
      children: children,
    );
  }

  Widget _buildMainListTile(String title, Widget page, {IconData? icon}) {
    return Container(
      // decoration: BoxDecoration(
      //   color: _selectedTile == title ? Colors.grey.shade50 : Colors.transparent,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: ListTile(
        leading: icon != null
            ? Icon(icon,
                color: _selectedTile == title ? Colors.blue[900] : Colors.black)
            : null,
        title: Text(
          title,
          style: TextStyle(
              fontSize: 17,
              color: _selectedTile == title
                  ? Colors.blue[900]
                  : Colors.black), // Correct fontSize usage
        ),
        onTap: () {
          setState(() {
            _selectedPage = page; // Set the selected page
            _selectedTile = title; // Set the selected tile
          });
        },
      ),
    );
  }

  Widget _buildSubListTile(
    String title,
    Widget page,
  ) {
    return Container(
        // decoration: BoxDecoration(
        //   // color: _selectedTile == title ? Colors.grey[400] : Colors.transparent,
        //   // borderRadius: BorderRadius.circular(10),
        // ),
        child: InkWell(
      onTap: () {
        setState(() {
          _selectedPage = page; // Set the selected page
          _selectedTile = title; // Set the selected tile
        });
      },
      child: Row(
        children: [
          SizedBox(
            width: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  color: _selectedTile == title
                      ? Colors.blue[400]
                      : Colors.black), // Correct fontSize usage
            ),
          ),
        ],
      ),
    ));
  }

  Widget SubListTile(
    String title,
    Widget page,
  ) {
    return Container(
      // decoration: BoxDecoration(
      //   // color: _selectedTile == title ? Colors.grey[400] : Colors.transparent,
      //   // borderRadius: BorderRadius.circular(10),
      // ),
      child: ListTile(
        leading: SizedBox(
          width: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 14,
              color: _selectedTile == title
                  ? Colors.blue[400]
                  : Colors.black), // Correct fontSize usage
        ),
        onTap: () {
          setState(() {
            _selectedPage = page; // Set the selected page
            _selectedTile = title; // Set the selected tile
          });
        },
      ),
    );
  }
}
