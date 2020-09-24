import 'dart:async';

import 'package:QRAdminFlutter/data/repositories/qr_repository.dart';
import 'package:QRAdminFlutter/data/sources/remote/base/app.exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QrBloc(this.qrRepository) : super(QrInitial());
  final QrRepository qrRepository;
  @override
  Stream<QrState> mapEventToState(QrEvent event) async* {
    yield QrLoading();
   try{
     if(event is RefreshQR){
       debugPrint("RefreshQR");
       String qrCode=await qrRepository.updateQR();
       yield QrLoaded(qrCode);
       debugPrint("Out RefreshQR Event");
     }
   }catch(error){
     if(error is UnauthorisedException){
       yield UnauthorisedError(error.toString());
     }else {
       yield QrError(error.toString());
     }
   }
  }
}
