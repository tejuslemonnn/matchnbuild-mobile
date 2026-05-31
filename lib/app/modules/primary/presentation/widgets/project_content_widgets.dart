import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/placeholder_image.dart';

class ProjectCardData {
  const ProjectCardData({
    required this.status,
    required this.title,
    required this.designer,
    required this.totalCost,
    required this.actionLabel,
    this.imageSeed = '',
  });

  final String status;
  final String title;
  final String designer;
  final String totalCost;
  final String actionLabel;
  final String imageSeed;
}

class ProjectStatusCard extends StatelessWidget {
  const ProjectStatusCard({super.key, required this.data});

  final ProjectCardData data;

  Color _statusBackgroundColor(String status) {
    switch (status) {
      case 'Waiting Payment':
        return ChakraColors.yellow100;
      case 'On Progress':
        return ChakraColors.blue100;
      case 'Completed':
        return ChakraColors.green100;
      case 'Canceled':
        return ChakraColors.red100;
      default:
        return ChakraColors.gray100;
    }
  }

  Color _statusTextColor(String status) {
    switch (status) {
      case 'Waiting Payment':
        return ChakraColors.yellow700;
      case 'On Progress':
        return ChakraColors.blue700;
      case 'Completed':
        return ChakraColors.green700;
      case 'Canceled':
        return ChakraColors.red700;
      default:
        return ChakraColors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ChakraColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ChakraColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _statusBackgroundColor(data.status),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        data.status,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          fontWeight: FontWeight.w700,
                          color: _statusTextColor(data.status),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.title,
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            fontStyle: GoogleFonts.inter().fontStyle,
                            fontWeight: FontWeight.bold,
                            color: ChakraColors.black,
                          ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          color: ChakraColors.gray500,
                        ),
                        children: [
                          const TextSpan(text: 'Designer: '),
                          TextSpan(
                            text: data.designer,
                            style: const TextStyle(
                              color: ChakraColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: networkOrPlaceholder(
                      null,
                      seed: data.imageSeed.isEmpty
                          ? data.title
                          : data.imageSeed,
                      width: 300,
                      height: 220,
                    ),
                    fit: BoxFit.cover,
                    height: 90,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ChakraColors.gray200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Cost',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          color: ChakraColors.gray500,
                        ),
                      ),
                      Text(
                        data.totalCost,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          color: ChakraColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ChakraColors.black,
                      foregroundColor: ChakraColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      data.actionLabel,
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
        ],
      ),
    );
  }
}
