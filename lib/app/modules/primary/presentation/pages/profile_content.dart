import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/auth/data/local/datasource/auth_local_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/profile_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/profile_content_widgets.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/services/api.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';
import 'package:mnb_mobile/tool/placeholder_image.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  final _cubit = Modular.get<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.load();
  }

  Future<void> _logout() async {
    // No dedicated logout endpoint is wired here; clear the locally stored
    // token + auth header (same effect as AuthRepository.logout).
    await Modular.get<AuthLocalDatasource>().deleteToken();
    Modular.get<DioClient>().clearAuthToken();
  }

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

    if (confirmed == true) {
      await _logout();
      if (context.mounted) {
        Modular.to.navigate(ModularRoutes.auth);
      }
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
              child: BlocBuilder<ProfileCubit, ProfileState>(
                bloc: _cubit,
                builder: (context, state) {
                  final user = state.user;
                  final name = user?.name ?? '-';
                  final roleLine = user == null
                      ? '-'
                      : '${_capitalize(user.role)}${user.email.isNotEmpty ? ' | ${user.email}' : ''}';
                  final picture = user?.profilePicture;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (state.status.isLoading)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: LinearProgressIndicator(),
                        ),
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
                                image: DecorationImage(
                                  image: networkOrPlaceholder(
                                    picture,
                                    seed: user?.id ?? 'profile',
                                    width: 220,
                                    height: 220,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              name,
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
                              roleLine,
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
                        children: const [
                          Expanded(
                            child: ProfileStatCard(
                              icon: Icons.description_outlined,
                              value: '12',
                              label: 'Active Project',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
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
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}
