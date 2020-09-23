import 'dart:async';

import 'package:QRAdminFlutter/bloc/user/user_bloc.dart';
import 'package:QRAdminFlutter/ui/modules/auth/auth.page.dart';
import 'package:QRAdminFlutter/ui/style/app.colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../env.dart';
import '../../../utils/core.util.dart';
import '../../style/app.colors.dart';

class LandingSplashScreen extends StatefulWidget {
  @override
  _LandingSplashScreenState createState() => _LandingSplashScreenState();
}

class _LandingSplashScreenState extends State<LandingSplashScreen> {
  String _route;

  @override
  void initState() {
    startTime();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (BuildContext context, UserState state) async {
        if (state is UserLoaded) {

        } else if (state is UserError) {

        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Align(
            alignment: Alignment.center,
            child: Shimmer.fromColors(
              baseColor: AppColors.primaryColor,
              highlightColor: AppColors.white,
              child: SvgPicture.asset(
                "assets/images/logo.svg",
                height: screenAwareSize(200, context),
                width: screenAwareSize(200, context),
              ),
            )),
      ),
    );
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      //if user registered
      if (prefs.containsKey('userData')) {
        //if email is verified
        if (prefs.containsKey('verified')) {
          //if user completed the initial setup
          _route = Env.homePage;
        } else {
          //if email is not verified
          _route = Env.verifyPage;
        }
      } else {
        //if user not registered
        _route = Env.authPage;
      }

    Duration _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }


  void navigationPage() {
    if(_route==Env.authPage)
      Navigator.pushReplacement(context, PageRouteBuilder(transitionDuration: Duration(seconds: 1),pageBuilder:(_,__,___)=>AuthPage(),settings: RouteSettings(name: Env.authPage)));
      else
        Navigator.of(context).pushReplacementNamed(_route);
  }
}
