import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class OfflineFailure extends Failure {}

class ServerFailure extends Failure {}

class EmptyCashFailure extends Failure {}

class LocationDisabledFailure extends Failure {}

class LocationServiceIsClosedFailure extends Failure {}
