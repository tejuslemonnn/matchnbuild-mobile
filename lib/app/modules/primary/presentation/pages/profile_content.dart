import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/profile_content_widgets.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  Future<void> _showLogoutDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: ChakraColors.white,
          title: Text(
            'Logout',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              fontWeight: FontWeight.bold,
              color: ChakraColors.black,
            ),
          ),
          content: Text(
            'Apakah Anda yakin ingin keluar dari akun ini?',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              color: ChakraColors.gray600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                'Batal',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  color: ChakraColors.gray600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: ChakraColors.black,
                foregroundColor: ChakraColors.white,
              ),
              child: Text(
                'Logout',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  color: ChakraColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      Modular.to.navigate(ModularRoutes.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseBodyPage(
      children: [
        SliverToBoxAdapter(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                          width: 104,
                          height: 104,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(52),
                            image: const DecorationImage(
                              image: AssetImage('assets/png/sitting-room.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Lemonee',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                fontStyle: GoogleFonts.inter().fontStyle,
                                fontWeight: FontWeight.bold,
                                color: ChakraColors.black,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Client | South Jakarta',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontStyle: GoogleFonts.inter().fontStyle,
                                color: ChakraColors.gray500,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ChakraColors.black,
                            foregroundColor: ChakraColors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontStyle: GoogleFonts.inter().fontStyle,
                                  color: ChakraColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: ProfileStatCard(
                          icon: Icons.description_outlined,
                          value: '12',
                          label: 'Active Project',
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: ProfileStatCard(
                          icon: Icons.favorite_border,
                          value: '28',
                          label: 'Favorit Design',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ChakraColors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ChakraColors.gray200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Account',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontStyle: GoogleFonts.inter().fontStyle,
                                fontWeight: FontWeight.bold,
                                color: ChakraColors.black,
                              ),
                        ),
                        const SizedBox(height: 8),
                        ProfileMenuRow(
                          leadingIcon: Icons.task_alt_outlined,
                          label: 'My Project',
                          onTap: () {},
                        ),
                        Divider(color: ChakraColors.gray200, height: 1),
                        ProfileMenuRow(
                          leadingIcon: Icons.payments_outlined,
                          label: 'History Transaction',
                          onTap: () {},
                        ),
                        Divider(color: ChakraColors.gray200, height: 1),
                        ProfileMenuRow(
                          leadingIcon: Icons.logout,
                          label: 'Logout',
                          onTap: () => _showLogoutDialog(context),
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
  }
}
