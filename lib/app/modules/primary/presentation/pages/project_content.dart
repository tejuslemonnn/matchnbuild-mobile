import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/project_content_widgets.dart';
import 'package:mnb_mobile/theme/colors.dart';

class ProjectContent extends StatelessWidget {
  const ProjectContent({super.key});

  static const _activeProjects = [
    ProjectCardData(
      status: 'Waiting Payment',
      title: 'Design Interior Apartemen',
      designer: 'Studio Karsa',
      totalCost: 'Rp. 45.000.000',
      actionLabel: 'Pay Now',
    ),
    ProjectCardData(
      status: 'On Progress',
      title: 'Design Interior Apartemen',
      designer: 'Nirmana House',
      totalCost: 'Rp. 72.000.000',
      actionLabel: 'Show Progress',
    ),
  ];

  static const _doneProjects = [
    ProjectCardData(
      status: 'Completed',
      title: 'Design Interior Apartemen',
      designer: 'Arsitag Studio',
      totalCost: 'Rp. 55.000.000',
      actionLabel: 'Chat Designer',
    ),
  ];

  static const _canceledProjects = [
    ProjectCardData(
      status: 'Canceled',
      title: 'Design Interior Apartemen',
      designer: 'Atelier Ruang',
      totalCost: 'Rp. 38.000.000',
      actionLabel: 'Chat Designer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: ChakraColors.gray100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: ChakraColors.black.withValues(alpha: 0),
                  indicator: BoxDecoration(
                    color: ChakraColors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelColor: ChakraColors.white,
                  unselectedLabelColor: ChakraColors.black,
                  labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontStyle: GoogleFonts.inter().fontStyle,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.w600,
                      ),
                  tabs: const [
                    Tab(text: 'Active'),
                    Tab(text: 'Done'),
                    Tab(text: 'Canceled'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _ProjectTabContent(projects: _activeProjects),
                  _ProjectTabContent(projects: _doneProjects),
                  _ProjectTabContent(projects: _canceledProjects),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectTabContent extends StatelessWidget {
  const _ProjectTabContent({required this.projects});

  final List<ProjectCardData> projects;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) => ProjectStatusCard(data: projects[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}
