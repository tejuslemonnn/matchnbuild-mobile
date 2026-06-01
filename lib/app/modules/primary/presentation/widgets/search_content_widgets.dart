import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/design_item_model.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/currency.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class SearchCategoryBadge extends StatelessWidget {
  const SearchCategoryBadge({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? ChakraColors.black : ChakraColors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: ChakraColors.black),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontStyle: GoogleFonts.inter().fontStyle,
            fontWeight: FontWeight.w600,
            color: isActive ? ChakraColors.white : ChakraColors.black,
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.actionLabel,
  });

  final String title;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontStyle: GoogleFonts.inter().fontStyle,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          actionLabel,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontStyle: GoogleFonts.inter().fontStyle,
            fontWeight: FontWeight.w600,
            color: ChakraColors.yellow700,
          ),
        ),
      ],
    );
  }
}

class SearchTrendingCard extends StatelessWidget {
  const SearchTrendingCard({super.key, required this.item});

  final DesignItemModel item;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cardHeight = mediaQuery.size.height * .2;
    final cardWidth = mediaQuery.size.width * .65;
    final hasImage = item.imageUrl != null && item.imageUrl!.isNotEmpty;
    final subtitle = [
      if (item.designerName != null) 'Oleh ${item.designerName}',
      if (item.location != null) item.location,
    ].join(' • ');

    return GestureDetector(
      onTap: () => Modular.to.pushNamed(
        ModularRoutes.path(ModularRoutes.primaryDesignDetail),
        arguments: item.id,
      ),
      child: SizedBox(
        width: mediaQuery.size.width * .65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: cardHeight,
                    width: cardWidth,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                        image: hasImage
                            ? NetworkImage(item.imageUrl!)
                            : const AssetImage('assets/png/sitting-room.png')
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: cardWidth,
                    height: cardHeight,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ChakraColors.black.withValues(alpha: 0),
                          ChakraColors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: ChakraColors.yellow500,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: ChakraColors.black),
                            ),
                            child: Text(
                              "Populer",
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    fontStyle: GoogleFonts.inter().fontStyle,
                                    fontWeight: FontWeight.w600,
                                    color: ChakraColors.black,
                                    fontSize: 8,
                                  ),
                            ),
                          ),

                          Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontStyle: GoogleFonts.inter().fontStyle,
                                  color: ChakraColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            subtitle.isEmpty ? (item.style ?? '') : subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(
                                  fontStyle: GoogleFonts.inter().fontStyle,
                                  color: ChakraColors.white,
                                  fontSize: 8,
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
          ],
        ),
      ),
    );
  }
}

class LatestInspirationCard extends StatelessWidget {
  const LatestInspirationCard({super.key, required this.item});

  final DesignItemModel item;

  @override
  Widget build(BuildContext context) {
    final hasImage = item.imageUrl != null && item.imageUrl!.isNotEmpty;
    final price = item.priceStartFrom ?? item.estimatedBudget;

    return GestureDetector(
      onTap: () => Modular.to.pushNamed(
        ModularRoutes.path(ModularRoutes.primaryDesignDetail),
        arguments: item.id,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ChakraColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ChakraColors.gray200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: hasImage
                        ? NetworkImage(item.imageUrl!)
                        : const AssetImage('assets/png/sitting-room.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      fontWeight: FontWeight.bold,
                      color: ChakraColors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.style ?? item.category ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      color: ChakraColors.gray500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    price != null ? 'Mulai ${formatRupiah(price)}' : 'Hubungi designer',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      fontWeight: FontWeight.w700,
                      color: ChakraColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
