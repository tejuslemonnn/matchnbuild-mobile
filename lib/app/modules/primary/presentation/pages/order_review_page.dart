import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';

class OrderReviewPage extends StatelessWidget {
  const OrderReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ElevatedButton(
          onPressed: () => Modular.to.pushNamed('./payment-method'),
          style: ElevatedButton.styleFrom(
            backgroundColor: ChakraColors.black,
            foregroundColor: ChakraColors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            'Choose Payment Method',
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
                      'Order Review',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.bold,
                        color: ChakraColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Confirm your order details before proceeding to payment.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.gray600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const _ReviewSection(
                      title: 'Design',
                      lines: [
                        'Japandi Living Space',
                        'Designer: Nathanael',
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _ReviewSection(
                      title: 'Project Scope',
                      lines: [
                        'Living Room',
                        'Estimated size: 36 m²',
                        'Timeline: 2 Weeks',
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _ReviewSection(
                      title: 'Payment Summary',
                      lines: [
                        'Design Fee: Rp. 45.000.000',
                        'Service Fee: Rp. 500.000',
                        'Total: Rp. 45.500.000',
                      ],
                      highlightLastLine: true,
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

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({
    required this.title,
    required this.lines,
    this.highlightLastLine = false,
  });

  final String title;
  final List<String> lines;
  final bool highlightLastLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChakraColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ChakraColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              fontWeight: FontWeight.bold,
              color: ChakraColors.black,
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(lines.length, (index) {
            final isLast = index == lines.length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
              child: Text(
                lines[index],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  color: highlightLastLine && isLast
                      ? ChakraColors.yellow700
                      : ChakraColors.gray600,
                  fontWeight: highlightLastLine && isLast
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
