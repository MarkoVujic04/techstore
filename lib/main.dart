import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:techstore/core/configs/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:techstore/core/constants/stripe_consts.dart';
import 'package:techstore/presentation/splash/bloc/splash_cubit.dart';
import 'package:techstore/presentation/splash/pages/splash.dart';
import 'package:techstore/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();
  await initializeDependencies();
  await _setup();
  runApp(const MainApp());
}

Future<void> _setup() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => SplashCubit()..appStarted(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: SplashPage()
      ),
    );
  }
}
