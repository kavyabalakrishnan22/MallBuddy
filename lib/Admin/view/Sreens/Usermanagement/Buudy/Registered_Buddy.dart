import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';
import '../../../../Model/User_Management/Buddy_model.dart';
import '../../../../Model/User_Management/shop_model.dart';

class RegisterdBuddywrapper extends StatelessWidget {
  const RegisterdBuddywrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuddyAuthBloc>(
      create: (context) => BuddyAuthBloc()
        ..add(FetchBuddyDetailsEvent(searchQuery: null, status: "0")),
      child: RegisteredBuddy(),
    );
  }
}

class RegisteredBuddy extends StatefulWidget {
  const RegisteredBuddy({super.key});

  @override
  State<RegisteredBuddy> createState() => _RegisteredBuddyState();
}

class _RegisteredBuddyState extends State<RegisteredBuddy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // _buildFloorSelection(),
          _buildShopTable("Registered Shops"),
        ],
      ),
    );
  }

  // Function to build shop tables for each tab
  Widget _buildShopTable(String title) {
    return BlocConsumer<BuddyAuthBloc, BuddyAuthState>(
      listener: (context, state) {
        if (state is Refresh) {
          context
              .read<BuddyAuthBloc>()
              .add(FetchBuddyDetailsEvent(searchQuery: null, status: "0"));
        }
      },
      builder: (context, state) {
        if (state is BuddygetLoading) {
          return Center(child: Loading_Widget());
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
                dataRowMaxHeight: 100,
                decoration: const BoxDecoration(color: Colors.white),
                columns: [
                  _buildColumn('SL NO'),
                  _buildColumn('Rider ID '),
                  _buildColumn('Rider Details'),
                  _buildColumn('Gender'),
                  // _buildColumn('Phone Number'),
                  // _buildColumn('Email'),
                  _buildColumn('Accept'),
                  _buildColumn('Reject'),
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
                        DataCell(Text(Buddy.uid.toString())),
                        DataCell(Column(
                          children: [
                            Text(
                              Buddy.name.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(Buddy.phone.toString()),
                            Text(Buddy.email.toString())
                          ],
                        )),
                        DataCell(Text(Buddy.Gender.toString())),
                        // DataCell(Text(shop.Phone_Number)),
                        // DataCell(Text(shop.Email_ID)),
                        DataCell(Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<BuddyAuthBloc>().add(
                                      AcceptRejectbuddyevent(
                                          status: "1", id: Buddy.uid));
                                },
                                icon: Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )),
                          ],
                        )),
                        DataCell(Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<BuddyAuthBloc>().add(
                                      AcceptRejectbuddyevent(
                                          status: "2", id: Buddy.uid));
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )),
                          ],
                        ))
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

  Widget _buildOutlinedButton(
      String text, Color textColor, Color borderColor, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor, // Text color
          side: BorderSide(color: borderColor), // Border color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 12), // Button padding
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
