import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/message_display_widget.dart';
import '../widgets/permission_message_widget.dart';
import '../widgets/weather_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      title: Text(
        "1".tr(),
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<WeatherBloc>().add(GetWeatherEvent());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state.status == WeatherStatus.loading) {
                  return const LoadingWidget();
                } else if (state.status == WeatherStatus.success) {
                  return WeatherWidget(weather: state.weather!);
                } else if (state.status == WeatherStatus.failureLocation) {
                  return PermissionMessageWidget(
                    message: state.errorMessage!,
                    onPressed: () async {
                      await Geolocator.openAppSettings();
                    },
                  );
                } else if (state.status ==
                    WeatherStatus.failureServiceLocation) {
                  return PermissionMessageWidget(
                    message: state.errorMessage!,
                    onPressed: () async {
                      await Geolocator.openLocationSettings();
                    },
                  );
                } else if (state.status == WeatherStatus.failureError) {
                  return MessageDisplayWidget(message: state.errorMessage!);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
