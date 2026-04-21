import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/theme/colors.dart';

class ChooseRolePage extends StatelessWidget {
  const ChooseRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What're your goals?",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  fontWeight: FontWeight.bold,
                  color: ChakraColors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose the role that best suits you to start your Match And Build experience.',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  color: ChakraColors.gray500,
                ),
              ),
              const SizedBox(height: 24),
              const _RoleCard(
                imagePath: 'assets/png/sitting-room.png',
                icon: Icons.business_outlined,
                title: 'I Want to Build',
                description:
                    'Find the best designer for your dream residential or commercial project.',
                buttonLabel: 'As Client',
              ),
              const SizedBox(height: 16),
              const _RoleCard(
                imagePath: 'assets/png/sitting-room.png',
                icon: Icons.edit_outlined,
                title: 'I Am A Designer',
                description:
                    'Offer architectural services, manage projects, and build a professional portfolio.',
                buttonLabel: 'As Designer',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.imagePath,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonLabel,
  });

  final String imagePath;
  final IconData icon;
  final String title;
  final String description;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ChakraColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ChakraColors.gray200),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -24),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: ChakraColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: ChakraColors.gray200),
              ),
              child: Icon(icon, color: ChakraColors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontStyle: GoogleFonts.inter().fontStyle,
                    fontWeight: FontWeight.bold,
                    color: ChakraColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontStyle: GoogleFonts.inter().fontStyle,
                    color: ChakraColors.gray500,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
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
                      buttonLabel,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.white,
                        fontWeight: FontWeight.w700,
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
