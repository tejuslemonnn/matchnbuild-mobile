import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';

class DesignDetailPage extends StatelessWidget {
  const DesignDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ChakraColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ChakraColors.gray200),
          ),
          padding: const EdgeInsetsGeometry.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: ElevatedButton(
            onPressed: () => Modular.to.pushNamed('./price-request'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ChakraColors.black,
              foregroundColor: ChakraColors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'Ask Price',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontStyle: GoogleFonts.inter().fontStyle,
                fontWeight: FontWeight.w700,
                color: ChakraColors.white,
              ),
            ),
          ),
        ),
      ),
      body: BaseBodyPage(
        children: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 260,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/png/sitting-room.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: ChakraColors.gray100,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'Minimalist',
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(
                                  fontStyle: GoogleFonts.inter().fontStyle,
                                  fontWeight: FontWeight.w700,
                                  color: ChakraColors.black,
                                ),
                          ),
                        ),
                        Text(
                          'Rp. 45.000.000',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontStyle: GoogleFonts.inter().fontStyle,
                                fontWeight: FontWeight.bold,
                                color: ChakraColors.yellow700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Japandi Living Space',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            fontStyle: GoogleFonts.inter().fontStyle,
                            fontWeight: FontWeight.bold,
                            color: ChakraColors.black,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: ChakraColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ChakraColors.gray200),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/png/sitting-room.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Designer Interior',
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(
                                      fontStyle: GoogleFonts.inter().fontStyle,
                                      color: ChakraColors.gray500,
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Nathanael',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontStyle: GoogleFonts.inter().fontStyle,
                                      fontWeight: FontWeight.w700,
                                      color: ChakraColors.black,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Description Design',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.bold,
                        color: ChakraColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'A warm minimalist living room concept with natural wood accents, soft neutral furniture, and balanced lighting to create a calm and timeless atmosphere for modern urban living.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.gray600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Timeline Project',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.bold,
                        color: ChakraColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
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
                          _TimelineItem(
                            title: 'Initial Consultation',
                            subtitle: '1 - 2 days',
                          ),
                          const SizedBox(height: 12),
                          _TimelineItem(
                            title: 'Design Development',
                            subtitle: '5 - 7 days',
                          ),
                          const SizedBox(height: 12),
                          _TimelineItem(
                            title: 'Final Revision & Delivery',
                            subtitle: '2 - 3 days',
                          ),
                        ],
                      ),
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

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: ChakraColors.yellow500,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  fontWeight: FontWeight.w700,
                  color: ChakraColors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  color: ChakraColors.gray500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
