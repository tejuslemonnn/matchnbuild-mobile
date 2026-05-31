import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/project_request_model.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/project_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/project_content_widgets.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/currency.dart';

class ProjectContent extends StatefulWidget {
  const ProjectContent({super.key});

  @override
  State<ProjectContent> createState() => _ProjectContentState();
}

class _ProjectContentState extends State<ProjectContent> {
  final _cubit = Modular.get<ProjectCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.load();
  }

  ProjectCardData _toCardData(ProjectRequestModel request) {
    final label = _statusLabel(request.status);
    return ProjectCardData(
      status: label,
      title: (request.description == null || request.description!.isEmpty)
          ? 'Project Request'
          : request.description!,
      designer: 'Designer',
      totalCost: formatRupiah(request.initialBudget),
      actionLabel: _actionLabel(request.status),
      imageSeed: request.id,
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'quoted':
        return 'Waiting Payment';
      case 'open':
      case 'accepted':
        return 'On Progress';
      case 'completed':
        return 'Completed';
      case 'rejected':
      case 'canceled':
        return 'Canceled';
      default:
        return status;
    }
  }

  String _actionLabel(String status) {
    switch (status) {
      case 'quoted':
        return 'Pay Now';
      case 'open':
      case 'accepted':
        return 'Show Progress';
      default:
        return 'Chat Designer';
    }
  }

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
              child: BlocBuilder<ProjectCubit, ProjectState>(
                bloc: _cubit,
                builder: (context, state) {
                  if (state.status.isLoading || state.status.isInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status.isFailure) {
                    return _ProjectError(
                      message: state.message,
                      onRetry: _cubit.load,
                    );
                  }

                  return TabBarView(
                    children: [
                      _ProjectTabContent(
                        projects: state.active.map(_toCardData).toList(),
                      ),
                      _ProjectTabContent(
                        projects: state.done.map(_toCardData).toList(),
                      ),
                      _ProjectTabContent(
                        projects: state.canceled.map(_toCardData).toList(),
                      ),
                    ],
                  );
                },
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
    if (projects.isEmpty) {
      return Center(
        child: Text(
          'Belum ada project.',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontStyle: GoogleFonts.inter().fontStyle,
            color: ChakraColors.gray500,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) => ProjectStatusCard(data: projects[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}

class _ProjectError extends StatelessWidget {
  const _ProjectError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.isEmpty ? 'Gagal memuat project.' : message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              color: ChakraColors.gray600,
            ),
          ),
          TextButton(onPressed: onRetry, child: const Text('Coba lagi')),
        ],
      ),
    );
  }
}
