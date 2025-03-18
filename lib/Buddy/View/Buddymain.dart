import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase_options.dart';
import '../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../User/View/Screens/auth/Spashview.dart';
import 'Screen/Auth/buddy_login_page.dart';
import 'Screen/BuddyBottomNav/BuddyBottomnav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BuddyAuthBloc>(
          create: (context) => BuddyAuthBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        routes: {
          '/': (context) => Splashpagewrapper(),
          '/home': (context) => BuddyBottomNav(),
          '/login': (context) => Buddy_Loginwrapper(),
        },
      ),
    );
  }
}
