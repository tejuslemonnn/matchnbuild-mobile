import 'package:flutter/material.dart';

/// Chakra UI Color Palette
/// https://chakra-ui.com/docs/theming/colors
class ChakraColors {
  ChakraColors._();

  // Base
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Background
  static const Color bg = Color(0xFFFFFFFF);
  static const Color bgSubtle = Color(0xFFfafafa);          // gray.50
  static const Color bgMuted = Color(0xFFf4f4f5);           // gray.100
  static const Color bgEmphasized = Color(0xFFe4e4e7);      // gray.200
  static const Color bgInverted = Color(0xFF000000);
  static const Color bgPanel = Color(0xFFFFFFFF);
  static const Color bgError = Color(0xFFfef2f2);           // red.50
  static const Color bgWarning = Color(0xFFfff7ed);          // orange.50
  static const Color bgSuccess = Color(0xFFf0fdf4);          // green.50
  static const Color bgInfo = Color(0xFFeff6ff);             // blue.50

  // Border
  static const Color border = Color(0xFFe4e4e7);             // gray.200
  static const Color borderMuted = Color(0xFFf4f4f5);        // gray.100
  static const Color borderSubtle = Color(0xFFfafafa);        // gray.50
  static const Color borderEmphasized = Color(0xFFd4d4d8);   // gray.300
  static const Color borderInverted = Color(0xFF27272a);      // gray.800
  static const Color borderError = Color(0xFFef4444);         // red.500
  static const Color borderWarning = Color(0xFFf97316);       // orange.500
  static const Color borderSuccess = Color(0xFF22c55e);       // green.500
  static const Color borderInfo = Color(0xFF3b82f6);          // blue.500

  // Text (fg)
  static const Color fg = Color(0xFF000000);
  static const Color fgMuted = Color(0xFF52525b);             // gray.600
  static const Color fgSubtle = Color(0xFFa1a1aa);            // gray.400
  static const Color fgInverted = Color(0xFFfafafa);          // gray.50
  static const Color fgError = Color(0xFFef4444);             // red.500
  static const Color fgWarning = Color(0xFFea580c);           // orange.600
  static const Color fgSuccess = Color(0xFF16a34a);           // green.600
  static const Color fgInfo = Color(0xFF2563eb);              // blue.600

  // Gray
  static const Color gray50 = Color(0xFFfafafa);
  static const Color gray100 = Color(0xFFf4f4f5);
  static const Color gray200 = Color(0xFFe4e4e7);
  static const Color gray300 = Color(0xFFd4d4d8);
  static const Color gray400 = Color(0xFFa1a1aa);
  static const Color gray500 = Color(0xFF71717a);
  static const Color gray600 = Color(0xFF52525b);
  static const Color gray700 = Color(0xFF3f3f46);
  static const Color gray800 = Color(0xFF27272a);
  static const Color gray900 = Color(0xFF18181b);
  static const Color gray950 = Color(0xFF111111);

  // Red
  static const Color red50 = Color(0xFFfef2f2);
  static const Color red100 = Color(0xFFfee2e2);
  static const Color red200 = Color(0xFFfecaca);
  static const Color red300 = Color(0xFFfca5a5);
  static const Color red400 = Color(0xFFf87171);
  static const Color red500 = Color(0xFFef4444);
  static const Color red600 = Color(0xFFdc2626);
  static const Color red700 = Color(0xFF991919);
  static const Color red800 = Color(0xFF511111);
  static const Color red900 = Color(0xFF300c0c);
  static const Color red950 = Color(0xFF1f0808);

  // Pink
  static const Color pink50 = Color(0xFFfdf2f8);
  static const Color pink100 = Color(0xFFfce7f3);
  static const Color pink200 = Color(0xFFfbcfe8);
  static const Color pink300 = Color(0xFFf9a8d4);
  static const Color pink400 = Color(0xFFf472b6);
  static const Color pink500 = Color(0xFFec4899);
  static const Color pink600 = Color(0xFFdb2777);
  static const Color pink700 = Color(0xFFa41752);
  static const Color pink800 = Color(0xFF6d0e34);
  static const Color pink900 = Color(0xFF45061f);
  static const Color pink950 = Color(0xFF2c0514);

  // Purple
  static const Color purple50 = Color(0xFFfaf5ff);
  static const Color purple100 = Color(0xFFf3e8ff);
  static const Color purple200 = Color(0xFFe9d5ff);
  static const Color purple300 = Color(0xFFd8b4fe);
  static const Color purple400 = Color(0xFFc084fc);
  static const Color purple500 = Color(0xFFa855f7);
  static const Color purple600 = Color(0xFF9333ea);
  static const Color purple700 = Color(0xFF641ba3);
  static const Color purple800 = Color(0xFF4a1772);
  static const Color purple900 = Color(0xFF2f0553);
  static const Color purple950 = Color(0xFF1a032e);

  // Cyan
  static const Color cyan50 = Color(0xFFecfeff);
  static const Color cyan100 = Color(0xFFcffafe);
  static const Color cyan200 = Color(0xFFa5f3fc);
  static const Color cyan300 = Color(0xFF67e8f9);
  static const Color cyan400 = Color(0xFF22d3ee);
  static const Color cyan500 = Color(0xFF06b6d4);
  static const Color cyan600 = Color(0xFF0891b2);
  static const Color cyan700 = Color(0xFF0c5c72);
  static const Color cyan800 = Color(0xFF134152);
  static const Color cyan900 = Color(0xFF072a38);
  static const Color cyan950 = Color(0xFF051b24);

  // Blue
  static const Color blue50 = Color(0xFFeff6ff);
  static const Color blue100 = Color(0xFFdbeafe);
  static const Color blue200 = Color(0xFFbfdbfe);
  static const Color blue300 = Color(0xFFa3cfff);
  static const Color blue400 = Color(0xFF60a5fa);
  static const Color blue500 = Color(0xFF3b82f6);
  static const Color blue600 = Color(0xFF2563eb);
  static const Color blue700 = Color(0xFF173da6);
  static const Color blue800 = Color(0xFF1a3478);
  static const Color blue900 = Color(0xFF14204a);
  static const Color blue950 = Color(0xFF0c142e);

  // Teal
  static const Color teal50 = Color(0xFFf0fdfa);
  static const Color teal100 = Color(0xFFccfbf1);
  static const Color teal200 = Color(0xFF99f6e4);
  static const Color teal300 = Color(0xFF5eead4);
  static const Color teal400 = Color(0xFF2dd4bf);
  static const Color teal500 = Color(0xFF14b8a6);
  static const Color teal600 = Color(0xFF0d9488);
  static const Color teal700 = Color(0xFF0c5d56);
  static const Color teal800 = Color(0xFF114240);
  static const Color teal900 = Color(0xFF032726);
  static const Color teal950 = Color(0xFF021716);

  // Green
  static const Color green50 = Color(0xFFf0fdf4);
  static const Color green100 = Color(0xFFdcfce7);
  static const Color green200 = Color(0xFFbbf7d0);
  static const Color green300 = Color(0xFF86efac);
  static const Color green400 = Color(0xFF4ade80);
  static const Color green500 = Color(0xFF22c55e);
  static const Color green600 = Color(0xFF16a34a);
  static const Color green700 = Color(0xFF116932);
  static const Color green800 = Color(0xFF124a28);
  static const Color green900 = Color(0xFF042713);
  static const Color green950 = Color(0xFF03190c);

  // Yellow
  static const Color yellow50 = Color(0xFFfefce8);
  static const Color yellow100 = Color(0xFFfef9c3);
  static const Color yellow200 = Color(0xFFfef08a);
  static const Color yellow300 = Color(0xFFfde047);
  static const Color yellow400 = Color(0xFFfacc15);
  static const Color yellow500 = Color(0xFFeab308);
  static const Color yellow600 = Color(0xFFca8a04);
  static const Color yellow700 = Color(0xFF845209);
  static const Color yellow800 = Color(0xFF713f12);
  static const Color yellow900 = Color(0xFF422006);
  static const Color yellow950 = Color(0xFF281304);

  // Orange
  static const Color orange50 = Color(0xFFfff7ed);
  static const Color orange100 = Color(0xFFffedd5);
  static const Color orange200 = Color(0xFFfed7aa);
  static const Color orange300 = Color(0xFFfdba74);
  static const Color orange400 = Color(0xFFfb923c);
  static const Color orange500 = Color(0xFFf97316);
  static const Color orange600 = Color(0xFFea580c);
  static const Color orange700 = Color(0xFF92310a);
  static const Color orange800 = Color(0xFF6c2710);
  static const Color orange900 = Color(0xFF3b1106);
  static const Color orange950 = Color(0xFF220a04);
}

/// App Colors mapped to Chakra UI palette
class AppColors {
  AppColors._();

  // Background
  static const Color pageBackgroundLight = ChakraColors.gray50;

  // AppBar / StatusBar
  static const Color statusBarColor = ChakraColors.blue700;
  static const Color appBarColor = ChakraColors.blue700;
  static const Color appBarIconColor = Color(0xFFFFFFFF);
  static const Color appBarTextColor = Color(0xFFFFFFFF);

  // Primary
  static const Color primaryColor = ChakraColors.blue500;

  // Card
  static const Color cardColors = Color(0xFFFFFFFF);

  // Core
  static const Color accentColor = ChakraColors.purple600;
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = ChakraColors.gray900;

  // Status
  static const Color errorColor = ChakraColors.red500;
  static const Color disabledColor = ChakraColors.gray400;
  static const Color warningColor = ChakraColors.yellow500;
  static const Color blueColor = ChakraColors.blue500;
  static const Color notifColor = ChakraColors.red600;
  static const Color successColor = ChakraColors.green500;
  static const Color infoColor = ChakraColors.cyan500;

  // Text
  static const Color textColorPrimaryLight = ChakraColors.gray800;
  static const Color textColorSecondary = ChakraColors.gray500;
  static const Color textColorGreyLight = ChakraColors.gray400;

  // Switch
  static const Color switchActiveColor = primaryColor;
  static const Color switchInactiveColor = disabledColor;

  // Border
  static const Color borderColor = ChakraColors.gray200;

  // Computed text colors
  static const Color textColorPrimary = ChakraColors.gray600;
  static const Color textColorInvert = ChakraColors.gray900;
  static const Color textColorTheme = Color(0xFFFFFFFF);
  static const Color textColorGrey = ChakraColors.gray400;
}
