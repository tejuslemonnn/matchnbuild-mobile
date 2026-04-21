import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/designer_list_item.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/design_section.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/app/widgets/glass_container.dart';
import 'package:mnb_mobile/theme/colors.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .15,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/png/sitting-room.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/png/sitting-room.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Designer Populer",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontStyle: GoogleFonts.inter().fontStyle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .4,
                    child: ListView.separated(
                      itemBuilder: (context, index) => DesignerListItem(
                        name: "Nathanael",
                        location: "South Jakarta",
                        onTap: () => Modular.to.pushNamed('./designer-detail'),
                      ),
                      itemCount: 5,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const DesignSection(title: "Bedroom Design"),
                  const SizedBox(height: 8),
                  const DesignSection(title: "Kitchen Design"),
                  const SizedBox(height: 8),
                  const DesignSection(title: "Bathroom Design"),
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
