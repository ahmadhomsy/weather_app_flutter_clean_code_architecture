import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_clean_code_architecture/core/widgets/loading_widget.dart';
import '../../../../injection_container.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/message_display_widget.dart';
import '../widgets/permission_message_widget.dart';
import '../widgets/weather_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WeatherBloc>()..add(GetWeatherEvent()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildAppbar(),
        body: _buildBody(context),
      ),
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

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<WeatherBloc>(context).add(RefreshWeatherEvent());
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
            opacity: 0.9),
      ),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const LoadingWidget();
          } else if (state is LoadedState) {
            return WeatherWidget(weather: state.weather);
          } else if (state is PermissionErrorState) {
            return PermissionMessageWidget(message: state.message);
          } else if (state is ErrorState) {
            return MessageDisplayWidget(message: state.message);
          }
          return Center(child: Text("data"));
        },
      ),
    );
  }
}
