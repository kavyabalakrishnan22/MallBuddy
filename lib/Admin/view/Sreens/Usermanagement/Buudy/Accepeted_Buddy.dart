import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';
import 'Edit_accepted_buddy.dart';


class AdminAcceptedwrapper extends StatelessWidget {
  const AdminAcceptedwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuddyAuthBloc>(
      create: (context) => BuddyAuthBloc()
        ..add(
          FetchBuddyDetailsEvent(searchQuery: null, status: "1"),
        ),
      child: AdminAcceptedShop(),
    );
  }
}

class AdminAcceptedShop extends StatefulWidget {
  const AdminAcceptedShop({super.key});

  @override
  State<AdminAcceptedShop> createState() => _AdminAcceptedShopState();
}

class _AdminAcceptedShopState extends State<AdminAcceptedShop> {
  String selectedValue = "All"; // Default selected value
  final List<String> dropdownItems = [
    "All",
    "Ground",
    "First",
    "Second",
    "Third",
    "Fourth"
  ]; // Dropdown options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text("Registered Shops"),
      //   // backgroundColor: Colors.blue,
      // ),
      body: Column(
        children: [
          // _buildFloorSelection(),
          _buildDropdown(), // Dropdown widget
          _buildShopTable("Registered Shops"),
        ],
      ),
    );
  }

// Function to build the dropdown
  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.centerRight, // Aligns dropdown to the right side
        child: Container(
          height: 50,
          width: 150, // Increased width for better visibility
          padding: EdgeInsets.symmetric(
              horizontal: 10), // Padding inside the container
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            border: Border.all(color: Colors.black, width: 1.5), // Black border
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: DropdownButtonHideUnderline(
            // Hides default underline
            child: DropdownButton<String>(
              value: selectedValue,

              isExpanded: true, // Ensures dropdown takes full width
              icon: Icon(Icons.arrow_drop_down,
                  color: Colors.black), // Dropdown icon
              items: dropdownItems.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item,
                      style:
                          TextStyle(color: Colors.black)), // Text color black
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  // Function to build shop tables for each tab
  Widget _buildShopTable(String title) {
    return BlocConsumer<BuddyAuthBloc, BuddyAuthState>(
      listener: (context, state) {
        if (state is BuddyBanRefresh) {
          context
              .read<BuddyAuthBloc>()
              .add(FetchBuddyDetailsEvent(searchQuery: null, status: ''));
        }       },
      builder: (context, state) {
        if (state is BuddygetLoading) {
          return Column(
            children: [
              SizedBox(height: 200,),
              Center(child: Loading_Widget()),
            ],
          );
        } else if (state is Buddyfailerror) {
          return Text(state.error.toString());
        } else if (state is Buddyloaded) {
          if (state.Buddys.isEmpty) {
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
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: DataTable(
                dataRowMaxHeight: 120,
                decoration: const BoxDecoration(color: Colors.white),
                columns: [
                  _buildColumn('SL NO'),
                  _buildColumn('Date and Time'),
                  _buildColumn('Rider Details'),
                  _buildColumn('Personal Details'),
                  // _buildColumn('Phone Number'),
                  // _buildColumn('Email'),
                  _buildColumn('Accepted'),
                  _buildColumn('Edit Buddy'),
                  _buildColumn('Ban Buddy'),
                ],
                rows: List.generate(
                  state.Buddys.length,
                  (index) {
                    final Buddy = state.Buddys[index];
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          (index + 1).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                        // DataCell(Text(Buddy.uid.toString())),
                        DataCell(Text("")),
                        DataCell(
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Rider_ID:"),
                                    Text(Buddy.uid.toString(),
                                      style:
                                      const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),Row(
                                  children: [
                                    Text("Floor:"),
                                    Text(Buddy.floor.toString(),
                                      style:
                                      const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),Row(
                                  children: [
                                    Text("Delivery_Fees:"),
                                    Text(Buddy.amount.toString(),
                                      style:
                                      const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ],
                            )),
                        DataCell(
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Name:"),
                                    Text(Buddy.name.toString(),style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Gender:"),
                                    Text(Buddy.Gender.toString(),style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Email:"),
                                    Text(Buddy.email.toString(),style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Ph:"),
                                    Text(Buddy.phone.toString(),style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ) ,

                              ],
                            )),
                        DataCell(
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.green, width: 1.5),
                              borderRadius:
                                  BorderRadius.circular(12), // Rounded corners
                              color: Colors.white, // Background color
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/admin/Accepted.png', // Replace with your actual asset path
                                  height: 25,
                                  width: 25,
                                ),
                                SizedBox(width: 5), // Spacing
                                Text(
                                  "Accepted",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataCell(
                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: BorderSide(
                                  color: Colors.black, width: 1.5),
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuddyEditPage(
                                    BId: Buddy.uid.toString(),
                                    Buddyname: Buddy.name.toString(),
                                    phone: Buddy.phone.toString(),
                                    Gender: Buddy.Gender.toString(),
                                  ),
                                ),
                              ).then(
                                    (value) {
                                  context.read<BuddyAuthBloc>()
                                    ..add(FetchBuddyDetailsEvent(
                                        searchQuery: null, status: "1"));
                                },
                              );
                            },
                            child: Text("Edit"),
                          ),
                        ),

                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              context.read<BuddyAuthBloc>().add(
                                  BanBuddyrevent(
                                      Ban: "1", id: Buddy.uid));
                            },
                            child: Text("Ban",style: TextStyle(color: Colors.red),),
                          ),
                        ),

                        // DataCell(Text(shop.Phone_Number)),
                        // DataCell(Text(shop.Email_ID)),
                        // DataCell(
                        //     // _buildOutlinedButton("Accepted", Colors.green, Colors.green, () {})
                        // ),
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
          fontSize: 16,
        ),
      ),
    );
  }

// Widget _buildOutlinedButton(String text, Color textColor, Color borderColor, VoidCallback onPressed) {
//   return Padding(
//     padding: const EdgeInsets.all(4.0),
//     child: OutlinedButton(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: textColor, // Text color
//         side: BorderSide(color: borderColor), // Border color
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
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
