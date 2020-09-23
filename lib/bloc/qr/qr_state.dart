part of 'qr_bloc.dart';

@immutable
abstract class QrState {}

class QrInitial extends QrState {}


class QrLoading extends QrState {}

class QrLoaded extends QrState {
  final String qr;
  QrLoaded(this.qr);
}

class QrError extends QrState {
  final String message;
  QrError(this.message);
}

class UnauthorisedError extends QrState {
  final String message;
  UnauthorisedError(this.message);
}


