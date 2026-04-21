import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';

class DesignerDetailPage extends StatelessWidget {
  const DesignerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: ChakraColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ChakraColors.gray200),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(55),
                                image: const DecorationImage(
                                  image: AssetImage('assets/png/sitting-room.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Nathanael',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontStyle: GoogleFonts.inter().fontStyle,
                                    fontWeight: FontWeight.bold,
                                    color: ChakraColors.black,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Architect & Designer Interior',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontStyle: GoogleFonts.inter().fontStyle,
                                    color: ChakraColors.gray500,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 18,
                                  color: ChakraColors.yellow700,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'South Jakarta - 12 Years Experience',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontStyle:
                                            GoogleFonts.inter().fontStyle,
                                        color: ChakraColors.yellow700,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ChakraColors.black,
                                foregroundColor: ChakraColors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Start Chat',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontStyle: GoogleFonts.inter().fontStyle,
                                      fontWeight: FontWeight.w700,
                                      color: ChakraColors.white,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: const [
                          Expanded(child: _StatCard(value: '58', label: 'Project')),
                          SizedBox(width: 12),
                          Expanded(child: _StatCard(value: '4.9', label: 'Rating')),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
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
                              'About',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontStyle: GoogleFonts.inter().fontStyle,
                                    fontWeight: FontWeight.bold,
                                    color: ChakraColors.black,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Experienced architect and interior designer specializing in modern residential and commercial spaces with a strong focus on functional layouts and timeless aesthetics.',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontStyle: GoogleFonts.inter().fontStyle,
                                    color: ChakraColors.gray600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ChakraColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ChakraColors.gray200),
                        ),
                        child: Column(
                          children: [
                            TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              dividerColor:
                                  ChakraColors.black.withValues(alpha: 0),
                              indicator: BoxDecoration(
                                color: ChakraColors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelColor: ChakraColors.white,
                              unselectedLabelColor: ChakraColors.black,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontStyle: GoogleFonts.inter().fontStyle,
                                    fontWeight: FontWeight.w700,
                                  ),
                              unselectedLabelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontStyle: GoogleFonts.inter().fontStyle,
                                    fontWeight: FontWeight.w600,
                                  ),
                              tabs: const [
                                Tab(text: 'Portofolio'),
                                Tab(text: 'Service Package'),
                                Tab(text: 'Review'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 220,
                              child: TabBarView(
                                children: const [
                                  _TabPlaceholder(
                                    text: 'Portofolio designer akan tampil di sini.',
                                  ),
                                  _TabPlaceholder(
                                    text: 'Paket layanan designer akan tampil di sini.',
                                  ),
                                  _TabPlaceholder(
                                    text: 'Review designer akan tampil di sini.',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChakraColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ChakraColors.gray200),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              fontWeight: FontWeight.bold,
              color: ChakraColors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              color: ChakraColors.gray500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabPlaceholder extends StatelessWidget {
  const _TabPlaceholder({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChakraColors.gray50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ChakraColors.gray200),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontStyle: GoogleFonts.inter().fontStyle,
          color: ChakraColors.gray600,
        ),
      ),
    );
  }
}
