import 'dart:async';

import 'package:QRAdminFlutter/bloc/qr/qr_bloc.dart';
import 'package:QRAdminFlutter/ui/style/app.colors.dart';
import 'package:QRAdminFlutter/utils/app.localization.dart';
import 'package:QRAdminFlutter/utils/core.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:qr_flutter/qr_flutter.dart';


class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {

  @override
  void initState() {
    refreshQR();
//    refresher();
    super.initState();
  }

  refresher() {
    const duration = const Duration(seconds: 15);
    return  Timer.periodic(
      duration,
          (Timer timer) => refreshQR(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsetsDirectional.only(top: 50),
            child:BlocBuilder<QrBloc,QrState>(
              builder: (context,state){
                if(state is QrLoading){
                  return Container(margin: EdgeInsets.all(30),alignment: Alignment.center,child: SemiCircleSpinIndicator(color: Theme.of(context).accentColor));
                } else if(state is QrLoaded){
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(AppLocalizations.of(context).translate("scan_me"),style: Theme.of(context).textTheme.headline1),
                        Text(AppLocalizations.of(context).translate("slogan"),style: Theme.of(context).textTheme.headline2),
                        SizedBox(height: 75),
                        QrImage(
                          data:state.qr,
                          version: QrVersions.auto,
                          size: screenAwareSize(320, context),
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  );
                }else if(state is QrError){
                  return Container(
                      margin: EdgeInsets.all(30),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.error, color: AppColors.failedColor, size: screenAwareSize(250, context)),
                          SizedBox(height: 20),
                          Text(AppLocalizations.of(context).translate("error_occurred",replacement:": "+state.message)),
                          SizedBox(height: 50),
                          FlatButton(onPressed: refreshQR, child: Text(AppLocalizations.of(context).translate("try_again"))),
                        ],
                      )
                  );
                }
                return Container(
                    margin: EdgeInsets.all(30),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.error, color: AppColors.failedColor, size: screenAwareSize(250, context)),
                        SizedBox(height: 20),
                        Text(AppLocalizations.of(context).translate("error_occurred",replacement: "")),
                        SizedBox(height: 50),
                        FlatButton(onPressed: refreshQR, child: Text(AppLocalizations.of(context).translate("try_again"))),
                      ],
                    )
                );
              },
            ),
          ),
        ));
  }



  void refreshQR() {
    BlocProvider.of<QrBloc>(context).add(RefreshQR());
  }


}
