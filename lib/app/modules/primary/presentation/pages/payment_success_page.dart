import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

// TODO(api): Tidak ada endpoint payment di backend (lihat api.md).
// Halaman sukses ini murni UI sampai API pembayaran tersedia.
class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: ChakraColors.green100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 48,
                  color: ChakraColors.green700,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Payment Successful',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  fontWeight: FontWeight.bold,
                  color: ChakraColors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your order has been confirmed. The designer will review your request and contact you soon.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  color: ChakraColors.gray600,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Modular.to.navigate(ModularRoutes.primary),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ChakraColors.black,
                    foregroundColor: ChakraColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Back to Home',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      fontWeight: FontWeight.w700,
                      color: ChakraColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
