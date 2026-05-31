import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/designer_detail_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/placeholder_image.dart';

class DesignerDetailPage extends StatefulWidget {
  const DesignerDetailPage({super.key, this.designerId});

  final String? designerId;

  @override
  State<DesignerDetailPage> createState() => _DesignerDetailPageState();
}

class _DesignerDetailPageState extends State<DesignerDetailPage> {
  final _cubit = Modular.get<DesignerDetailCubit>();

  @override
  void initState() {
    super.initState();
    if (widget.designerId != null) {
      _cubit.load(widget.designerId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.designerId == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Designer tidak ditemukan.')),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<DesignerDetailCubit, DesignerDetailState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state.status.isLoading || state.status.isInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status.isFailure || state.designer == null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message.isEmpty
                          ? 'Gagal memuat designer.'
                          : state.message,
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () => _cubit.load(widget.designerId!),
                      child: const Text('Coba lagi'),
                    ),
                  ],
                ),
              );
            }

            final designer = state.designer!;
            final picture = designer.profilePicture;
            final locationLine = [
              if (designer.location != null && designer.location!.isNotEmpty)
                designer.location,
              '${designer.experienceYears} Years Experience',
            ].join(' - ');

            return BaseBodyPage(
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
                                    image: DecorationImage(
                                      image: networkOrPlaceholder(
                                        picture,
                                        seed: designer.id,
                                        width: 220,
                                        height: 220,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  designer.name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontStyle:
                                            GoogleFonts.inter().fontStyle,
                                        fontWeight: FontWeight.bold,
                                        color: ChakraColors.black,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  designer.isAvailable
                                      ? 'Available for new projects'
                                      : 'Currently unavailable',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        fontStyle:
                                            GoogleFonts.inter().fontStyle,
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
                                    Flexible(
                                      child: Text(
                                        locationLine,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontStyle: GoogleFonts.inter()
                                                  .fontStyle,
                                              color: ChakraColors.yellow700,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  // TODO: Messaging API belum tersedia di
                                  // backend — tombol Start Chat masih no-op.
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontStyle:
                                              GoogleFonts.inter().fontStyle,
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
                            children: [
                              Expanded(
                                child: _StatCard(
                                  value: designer.isVerified ? 'Yes' : 'No',
                                  label: 'Verified',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StatCard(
                                  value: '${designer.experienceYears}',
                                  label: 'Years Exp.',
                                ),
                              ),
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
                                        fontStyle:
                                            GoogleFonts.inter().fontStyle,
                                        fontWeight: FontWeight.bold,
                                        color: ChakraColors.black,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  (designer.bio == null ||
                                          designer.bio!.isEmpty)
                                      ? 'Belum ada deskripsi.'
                                      : designer.bio!,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        fontStyle:
                                            GoogleFonts.inter().fontStyle,
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
                                        fontStyle:
                                            GoogleFonts.inter().fontStyle,
                                        fontWeight: FontWeight.w700,
                                      ),
                                  unselectedLabelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontStyle:
                                            GoogleFonts.inter().fontStyle,
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
                                      // TODO: Portfolio / package / review API
                                      // belum tersedia di backend.
                                      _TabPlaceholder(
                                        text:
                                            'Portofolio designer akan tampil di sini.',
                                      ),
                                      _TabPlaceholder(
                                        text:
                                            'Paket layanan designer akan tampil di sini.',
                                      ),
                                      _TabPlaceholder(
                                        text:
                                            'Review designer akan tampil di sini.',
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
            );
          },
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
