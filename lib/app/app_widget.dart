import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mnb_mobile/app/controller/app_controller_bloc.dart';
import 'package:mnb_mobile/app/widgets/loading_widget.dart';
import 'package:mnb_mobile/models/theme/theme_data.dart';
import 'package:mnb_mobile/theme/theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<AppControllerBloc>(),
      child: BlocBuilder<AppControllerBloc, AppControllerState>(
        bloc: Modular.get<AppControllerBloc>(),
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'MnB: MatchNBuild',
            theme: lightThemeData(context),
            builder: (context, child) => Stack(
              alignment: Alignment.center,
              children: [child!, const LoadingWidget(), const DropdownAlert()],
            ),
            routerDelegate: Modular.routerDelegate,
            routeInformationParser: Modular.routeInformationParser,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              FormBuilderLocalizations.delegate,
            ],
            supportedLocales: const [Locale('id'), Locale('en')],
          );
        },
      ),
    );
  }
}
