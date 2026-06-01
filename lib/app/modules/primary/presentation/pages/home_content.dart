import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/home_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/designer_list_item.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/design_section.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/app/widgets/glass_container.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _cubit = Modular.get<HomeCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.load();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Exploring Harmony Detail Various",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      image: const DecorationImage(
                        image: AssetImage('assets/png/sitting-room.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: _cubit,
                    builder: (context, state) {
                      if (state.status.isLoading) {
                        return const SizedBox(
                          height: 160,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (state.status.isFailure) {
                        return _ErrorRetry(
                          message: state.message,
                          onRetry: _cubit.load,
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Designer Populer",
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(
                                  fontStyle: GoogleFonts.inter().fontStyle,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          if (state.designers.isEmpty)
                            _EmptyHint(text: 'Belum ada designer.')
                          else
                            ListView.separated(
                              itemBuilder: (context, index) {
                                final designer = state.designers[index];
                                return DesignerListItem(
                                  name: designer.name,
                                  location: designer.location ?? '-',
                                  imageUrl: designer.profilePicture,
                                  onTap: () => Modular.to.pushNamed(
                                    ModularRoutes.path(
                                      ModularRoutes.primaryDesignerDetail,
                                    ),
                                    arguments: designer.id,
                                  ),
                                );
                              },
                              itemCount: state.designers.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 5),
                            ),
                          const SizedBox(height: 16),
                          DesignSection(
                            title: "Explore Designs",
                            items: state.designItems,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Image.asset('assets/png/logo-app.png'),
                  const SizedBox(height: 8),
                  Text(
                    "Collections",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            image: const DecorationImage(
                              image: AssetImage('assets/png/sitting-room.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            image: const DecorationImage(
                              image: AssetImage('assets/png/sitting-room.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Redefine outdoor living with our contenporary furniture collections. Designed for those who appreciate minimalist aesthetics, superior comfort, and timeless elegance.",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .2,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .2,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            image: const DecorationImage(
                              image: AssetImage('assets/png/sitting-room.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GlassContainer(
                            radius: 12,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .09,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Koishi",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontStyle:
                                              GoogleFonts.inter().fontStyle,
                                          color: ChakraColors.black,
                                        ),
                                  ),
                                  Text(
                                    "Mulai dari Rp.20.000.000",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontStyle:
                                              GoogleFonts.inter().fontStyle,
                                          color: ChakraColors.black,
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
          ),
        ),
      ],
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontStyle: GoogleFonts.inter().fontStyle,
          color: ChakraColors.gray500,
        ),
      ),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

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
      child: Column(
        children: [
          Text(
            message.isEmpty ? 'Gagal memuat data.' : message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              color: ChakraColors.gray600,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(onPressed: onRetry, child: const Text('Coba lagi')),
        ],
      ),
    );
  }
}
