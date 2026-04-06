import 'package:flutter/material.dart';
import 'package:mnb_mobile/app/controller/app_controller_bloc.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  StateLoadingWidget createState() => StateLoadingWidget();
}

class StateLoadingWidget extends State<LoadingWidget> {
  final appController = Modular.get<AppControllerBloc>();

  @override
  void initState() {
    super.initState();
  }

  Widget renderLoading() => Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.6),
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.red,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      appController.add(const AppControllerUpdateLoading(isLoading: false));
    });

    return appController.state.isLoading
        ? renderLoading()
        : const SizedBox.shrink();
  }
}
