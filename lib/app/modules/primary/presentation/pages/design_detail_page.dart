import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/design_detail_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/currency.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';
import 'package:mnb_mobile/tool/placeholder_image.dart';

class DesignDetailPage extends StatefulWidget {
  const DesignDetailPage({super.key, this.designItemId});

  final String? designItemId;

  @override
  State<DesignDetailPage> createState() => _DesignDetailPageState();
}

class _DesignDetailPageState extends State<DesignDetailPage> {
  final _cubit = Modular.get<DesignDetailCubit>();

  @override
  void initState() {
    super.initState();
    if (widget.designItemId != null) {
      _cubit.load(widget.designItemId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.designItemId == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Desain tidak ditemukan.')),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<DesignDetailCubit, DesignDetailState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.status.isLoading || state.status.isInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status.isFailure || state.item == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.message.isEmpty
                        ? 'Gagal memuat desain.'
                        : state.message,
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () => _cubit.load(widget.designItemId!),
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            );
          }

          final item = state.item!;
          final price = item.priceStartFrom ?? item.estimatedBudget;

          return Scaffold(
            bottomNavigationBar: SafeArea(
              minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ChakraColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ChakraColors.gray200),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ElevatedButton(
                  onPressed: () => Modular.to.pushNamed(
                    ModularRoutes.path(ModularRoutes.primaryPriceRequest),
                    arguments: item.designerId,
                  ),
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
                              image: DecorationImage(
                                image: networkOrPlaceholder(
                                  item.imageUrl,
                                  seed: item.id,
                                  width: 800,
                                  height: 600,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (item.style != null && item.style!.isNotEmpty)
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
                                    item.style!,
                                    style: Theme.of(context).textTheme.bodySmall!
                                        .copyWith(
                                          fontStyle:
                                              GoogleFonts.inter().fontStyle,
                                          fontWeight: FontWeight.w700,
                                          color: ChakraColors.black,
                                        ),
                                  ),
                                )
                              else
                                const SizedBox.shrink(),
                              Text(
                                price != null
                                    ? formatRupiah(price)
                                    : 'Hubungi designer',
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
                            item.title,
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
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(28),
                                    ),
                                    image: DecorationImage(
                                      image: networkOrPlaceholder(
                                        null,
                                        seed: item.designerId ??
                                            '${item.id}-designer',
                                        width: 120,
                                        height: 120,
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
                                      'Designer',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontStyle:
                                                GoogleFonts.inter().fontStyle,
                                            color: ChakraColors.gray500,
                                          ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      item.designerName ?? 'Designer',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontStyle:
                                                GoogleFonts.inter().fontStyle,
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
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  fontStyle: GoogleFonts.inter().fontStyle,
                                  fontWeight: FontWeight.bold,
                                  color: ChakraColors.black,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            (item.description == null ||
                                    item.description!.isEmpty)
                                ? 'Belum ada deskripsi.'
                                : item.description!,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontStyle: GoogleFonts.inter().fontStyle,
                                  color: ChakraColors.gray600,
                                ),
                          ),
                          const SizedBox(height: 16),
                          _SpecsCard(
                            specs: [
                              if (item.category != null)
                                ('Category', item.category!),
                              if (item.numFloors != null)
                                ('Floors', '${item.numFloors}'),
                              if (item.numBedrooms != null)
                                ('Bedrooms', '${item.numBedrooms}'),
                              if (item.buildingArea != null)
                                ('Building Area', '${item.buildingArea} m²'),
                              if (item.location != null)
                                ('Location', item.location!),
                            ],
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
        },
      ),
    );
  }
}

class _SpecsCard extends StatelessWidget {
  const _SpecsCard({required this.specs});

  final List<(String, String)> specs;

  @override
  Widget build(BuildContext context) {
    if (specs.isEmpty) return const SizedBox.shrink();

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
            'Specifications',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              fontWeight: FontWeight.bold,
              color: ChakraColors.black,
            ),
          ),
          const SizedBox(height: 8),
          ...specs.map(
            (spec) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    spec.$1,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      color: ChakraColors.gray500,
                    ),
                  ),
                  Text(
                    spec.$2,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      fontWeight: FontWeight.w700,
                      color: ChakraColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
