import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/design_item_model.dart';
import 'package:mnb_mobile/app/widgets/glass_container.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/currency.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';
import 'package:mnb_mobile/tool/placeholder_image.dart';

class DesignSection extends StatelessWidget {
  const DesignSection({
    super.key,
    required this.title,
    this.items = const [],
    this.onExplore,
  });

  final String title;
  final List<DesignItemModel> items;
  final VoidCallback? onExplore;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontStyle: GoogleFonts.inter().fontStyle,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: onExplore ?? () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(50, 30),
                backgroundColor: ChakraColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 2,
                ),
              ),
              child: Text(
                "Explore",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  fontWeight: FontWeight.bold,
                  color: ChakraColors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: mediaQuery.size.height * .2,
          child: items.isEmpty
              ? Center(
                  child: Text(
                    'Belum ada desain.',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      color: ChakraColors.gray500,
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      DesignShowcaseCard(item: items[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                ),
        ),
      ],
    );
  }
}

class DesignShowcaseCard extends StatelessWidget {
  const DesignShowcaseCard({super.key, required this.item});

  final DesignItemModel item;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cardHeight = mediaQuery.size.height * .2;
    final cardWidth = mediaQuery.size.width * .45;

    final price = item.priceStartFrom ?? item.estimatedBudget;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        ModularRoutes.path(ModularRoutes.primaryDesignDetail),
        arguments: item.id,
      ),
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            height: cardHeight,
            width: cardWidth,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              image: DecorationImage(
                image: networkOrPlaceholder(
                  item.imageUrl,
                  seed: item.id,
                  width: 400,
                  height: 400,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GlassContainer(
              radius: 12,
              width: cardWidth,
              height: mediaQuery.size.height * .075,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      price != null
                          ? "Mulai dari ${formatRupiah(price)}"
                          : "Hubungi designer",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.white,
                        fontWeight: FontWeight.bold,
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
    );
  }
}
