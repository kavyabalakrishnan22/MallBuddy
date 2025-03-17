import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase_options.dart';
import '../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import 'Screens/Bottomnav/Bottom.dart';
import 'Screens/auth/Spashview.dart';
import 'Screens/auth/User_login_page.dart';

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
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        routes: {
          '/': (context) => Splashpagewrapper(),
          '/home': (context) => BottomNavBarExample(),
          '/login': (context) => User_Loginwrapper(),
        },
      ),
    );
  }
}
