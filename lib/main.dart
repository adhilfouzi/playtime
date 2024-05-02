import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model/backend/repositories/firebase_options.dart';
import 'view/onboarding/screens/splash_screen.dart';
import 'view_model/bloc/emailverification/emailverification_bloc.dart';
import 'view_model/bloc/signin_bloc/signin_bloc.dart';
import 'view_model/bloc/signup_bloc/signup_bloc.dart';
import 'view_model/bloc/turflist/turflist_bloc.dart';
import 'view_model/cubit/checkbox/checkbox_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Handle Firebase initialization errors
    print('Failed to initialize Firebase: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => SigninBloc()),
        BlocProvider(create: (context) => CheckboxCubit()),
        BlocProvider(create: (context) => EmailVerificationBloc()),
        BlocProvider(create: (context) => TurflistBloc()),
        // Add more Bloc providers if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Turf Booking Application For User',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const SplashScreen(),
        // home: const MyBottomNavigationBar(),
      ),
    );
  }
}
