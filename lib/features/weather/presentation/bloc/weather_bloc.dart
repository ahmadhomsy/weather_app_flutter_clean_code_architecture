import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_clean_code_architecture/core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_weather_state.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherStateUseCase getWeatherStateUseCase;

  WeatherBloc({
    required this.getWeatherStateUseCase,
  }) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      if (event is GetWeatherEvent) {
        emit(LoadingState());
        final failureOrWeather = await getWeatherStateUseCase.call();
        failureOrWeather.fold((failure) {
          if (failure is LocationDisabledFailure) {
            emit(PermissionErrorState(message: _mapFailureToMessage(failure)));
          } else {
            emit(ErrorState(message: _mapFailureToMessage(failure)));
          }
        }, (weather) async {
          emit(LoadedState(weather: weather));
        });
      }
      if (event is RefreshWeatherEvent) {
        emit(LoadingState());
        final failureOrWeather = await getWeatherStateUseCase.call();
        failureOrWeather.fold((failure) {
          emit(ErrorState(message: _mapFailureToMessage(failure)));
        }, (weather) async {
          emit(LoadedState(weather: weather));
        });
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure is EmptyCashFailure) {
      return EMPTY_CACHE_FAILURE_MESSAGE;
    } else if (failure is OfflineFailure) {
      return OFFLINE_FAILURE_MESSAGE;
    } else if (failure is LocationDisabledFailure) {
      return LOCATION_FAILURE_MESSAGE;
    } else {
      return "Un Expected Error";
    }
  }
}
