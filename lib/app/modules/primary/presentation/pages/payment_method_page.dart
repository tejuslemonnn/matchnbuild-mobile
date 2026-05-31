import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';

// TODO(api): Tidak ada endpoint payment/order di backend (lihat api.md).
// Pemilihan metode pembayaran masih dummy; quotation accept (PUT
// /quotation/:id/accept) sudah menghasilkan order_id di OrderReviewPage.
class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String _selectedMethod = 'Bank Transfer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ElevatedButton(
          onPressed: () => Modular.to.pushNamed('./payment-success'),
          style: ElevatedButton.styleFrom(
            backgroundColor: ChakraColors.black,
            foregroundColor: ChakraColors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            'Pay Now',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              fontWeight: FontWeight.w700,
              color: ChakraColors.white,
            ),
          ),
        ),
      ),
      body: BaseBodyPage(
        children: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Method',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.bold,
                        color: ChakraColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choose how you want to complete this payment.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.gray600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _PaymentOptionTile(
                      title: 'Bank Transfer',
                      subtitle: 'BCA / Mandiri / BNI',
                      value: 'Bank Transfer',
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() => _selectedMethod = value!);
                      },
                    ),
                    const SizedBox(height: 12),
                    _PaymentOptionTile(
                      title: 'Credit Card',
                      subtitle: 'Visa / Mastercard',
                      value: 'Credit Card',
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() => _selectedMethod = value!);
                      },
                    ),
                    const SizedBox(height: 12),
                    _PaymentOptionTile(
                      title: 'E-Wallet',
                      subtitle: 'GoPay / OVO / DANA',
                      value: 'E-Wallet',
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() => _selectedMethod = value!);
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  const _PaymentOptionTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ChakraColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value == groupValue
              ? ChakraColors.black
              : ChakraColors.gray200,
          width: value == groupValue ? 2 : 1,
        ),
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: ChakraColors.black,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontStyle: GoogleFonts.inter().fontStyle,
            fontWeight: FontWeight.w700,
            color: ChakraColors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontStyle: GoogleFonts.inter().fontStyle,
            color: ChakraColors.gray500,
          ),
        ),
      ),
    );
  }
}
