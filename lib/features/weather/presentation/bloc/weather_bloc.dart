import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../../core/constants/failures.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_weather_state.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherStateUseCase getWeatherStateUseCase;

  WeatherBloc({
    required this.getWeatherStateUseCase,
  }) : super(WeatherState()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(state.copyWith(status: WeatherStatus.loading));
      final failureOrWeather = await getWeatherStateUseCase.call();
      failureOrWeather.fold((failure) {
        if (failure is LocationDisabledFailure) {
          emit(state.copyWith(
              status: WeatherStatus.failureLocation,
              errorMessage: _mapFailureToMessage(failure)));
        } else if (failure is LocationServiceIsClosedFailure) {
          emit(state.copyWith(
              status: WeatherStatus.failureServiceLocation,
              errorMessage: _mapFailureToMessage(failure)));
        } else {
          emit(state.copyWith(
              status: WeatherStatus.failureError,
              errorMessage: _mapFailureToMessage(failure)));
        }
      }, (weather) async {
        emit(state.copyWith(status: WeatherStatus.success, weather: weather));
      });
    });
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return serverFailureMessage;
    } else if (failure is EmptyCashFailure) {
      return emptyCacheFailureMessage;
    } else if (failure is OfflineFailure) {
      return offlineFailureMessage;
    } else if (failure is LocationDisabledFailure) {
      return locationFailureMessage;
    } else if (failure is LocationServiceIsClosedFailure) {
      return locationServiceIsClosedMessage;
    } else {
      return unExpectedErrorMessage;
    }
  }
}
