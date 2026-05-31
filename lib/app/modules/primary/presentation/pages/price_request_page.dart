import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/data/datasource/primary_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/project_request_form_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class PriceRequestPage extends StatefulWidget {
  const PriceRequestPage({super.key, this.designerId});

  final String? designerId;

  @override
  State<PriceRequestPage> createState() => _PriceRequestPageState();
}

class _PriceRequestPageState extends State<PriceRequestPage> {
  final _cubit = Modular.get<ProjectRequestFormCubit>();
  final _spaceController = TextEditingController();
  final _notesController = TextEditingController();
  final _budgetController = TextEditingController();

  String _spaceType = 'Living Room';
  String _timeline = '2 Weeks';

  @override
  void dispose() {
    _spaceController.dispose();
    _notesController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.designerId == null || widget.designerId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Designer tidak diketahui. Buka dari halaman desain.'),
        ),
      );
      return;
    }

    final description = [
      'Space: $_spaceType',
      'Timeline: $_timeline',
      if (_notesController.text.trim().isNotEmpty)
        _notesController.text.trim(),
    ].join('\n');

    _cubit.submit(
      CreateProjectRequest(
        designerId: widget.designerId!,
        description: description,
        initialBudget: double.tryParse(_budgetController.text.trim()) ?? 0,
        areaSize: double.tryParse(_spaceController.text.trim()) ?? 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BlocConsumer<ProjectRequestFormCubit,
          ProjectRequestFormState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.status.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Permintaan penawaran berhasil dikirim.'),
              ),
            );
            Modular.to.navigate(ModularRoutes.primary);
          } else if (state.status.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final loading = state.status.isLoading;
          return SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: loading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: ChakraColors.black,
                foregroundColor: ChakraColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ChakraColors.white,
                      ),
                    )
                  : Text(
                      'Request Quote',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.w700,
                        color: ChakraColors.white,
                      ),
                    ),
            ),
          );
        },
      ),
      body: BaseBodyPage(
        children: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tell Us About Your Project',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.bold,
                        color: ChakraColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Share the basics so the designer can prepare an accurate quote for your design request.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.gray600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      initialValue: _spaceType,
                      decoration: const InputDecoration(
                        labelText: 'Space Type',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Living Room',
                          child: Text('Living Room'),
                        ),
                        DropdownMenuItem(
                          value: 'Bedroom',
                          child: Text('Bedroom'),
                        ),
                        DropdownMenuItem(
                          value: 'Kitchen',
                          child: Text('Kitchen'),
                        ),
                      ],
                      onChanged: (value) =>
                          setState(() => _spaceType = value ?? _spaceType),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _spaceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Estimated Space Size (m²)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _budgetController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Initial Budget (Rupiah)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _timeline,
                      decoration: const InputDecoration(
                        labelText: 'Target Timeline',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: '2 Weeks',
                          child: Text('2 Weeks'),
                        ),
                        DropdownMenuItem(
                          value: '1 Month',
                          child: Text('1 Month'),
                        ),
                        DropdownMenuItem(
                          value: 'Flexible',
                          child: Text('Flexible'),
                        ),
                      ],
                      onChanged: (value) =>
                          setState(() => _timeline = value ?? _timeline),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _notesController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Project Notes',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 24),
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
