import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/theme/colors.dart';

class DesignerListItem extends StatelessWidget {
  const DesignerListItem({
    super.key,
    required this.name,
    required this.location,
    required this.onTap,
    this.imageUrl,
  });

  final String name;
  final String location;
  final VoidCallback onTap;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: ChakraColors.gray200, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.height * .125,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                image: DecorationImage(
                  image: (imageUrl != null && imageUrl!.isNotEmpty)
                      ? NetworkImage(imageUrl!)
                      : const AssetImage('assets/png/sitting-room.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: ChakraColors.yellow700,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        location,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          color: ChakraColors.yellow700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: ChakraColors.gray200,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Modern",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontStyle: GoogleFonts.inter().fontStyle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: ChakraColors.gray200,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Minimalist",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontStyle: GoogleFonts.inter().fontStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Start From",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          color: ChakraColors.yellow700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Rp.150.000",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          fontWeight: FontWeight.bold,
                          color: ChakraColors.yellow500,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "/m2",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          color: ChakraColors.yellow700,
                        ),
                      ),
                    ],
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
