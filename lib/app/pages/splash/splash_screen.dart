import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/controller/app_controller_bloc.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final appControllerBloc = Modular.get<AppControllerBloc>();

  Future<void> _init() async {
    // Pastikan splash screen sudah ter-render sebelum mulai cek auth
    await Future.delayed(const Duration(milliseconds: 1000));
    appControllerBloc.add(const AppControllerStarted());
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppControllerBloc, AppControllerState>(
      bloc: appControllerBloc,
      listener: (context, state) {
        if (state.isAuthenticated) {
          Modular.to.navigate(ModularRoutes.primary);
        } else {
          Modular.to.navigate(ModularRoutes.auth);
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/png/splash-bg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black54,
                    BlendMode.darken,
                  ),
                ),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/png/logo-app.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain, // or BoxFit.cover
                ),
                Text(
                  "MATCH AND BUILD",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: ChakraColors.white,
                    fontStyle: GoogleFonts.playfairDisplay().fontStyle,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
