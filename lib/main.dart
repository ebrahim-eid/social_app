import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/cubit/social_cubit.dart';
import 'package:social_app/screens/auth_screens/login_screen.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/shared/shared_prefernce.dart';
import 'components/widgets.dart';
import 'constants/constants.dart';
import 'cubit/bloc_observer.dart';
import 'firebase_options.dart';
import 'message.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  showToast(message: 'on background message', state: ToastStates.success);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CashHelper.init();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  uId = CashHelper.getData(key: 'uId');
  await FCMessaging().initNotification();
  await FirebaseMessaging.instance.getToken();
  FCMessaging().onMessage();
  FCMessaging().onMessageOpenedApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialCubit()..getUserData()..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme:  AppBarTheme(
                color: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: defaultColor,
                ),
                titleTextStyle:const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  color: Colors.black
                )
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: HexColor('#EEEEF0'),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.black54,
              elevation: 15,
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold
              )

            ),
            scaffoldBackgroundColor: HexColor('#EEEEF0')
        ),
        home:  uId == null ? LoginScreen() : const HomeScreen(),
      ),
    );
  }
}

