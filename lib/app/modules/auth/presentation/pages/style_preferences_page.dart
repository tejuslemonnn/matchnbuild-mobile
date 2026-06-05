import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/data/datasource/primary_remote_datasource.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/preferences_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/app/widgets/inputs/inputs.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class StylePreferencesPage extends StatefulWidget {
  const StylePreferencesPage({super.key});

  @override
  State<StylePreferencesPage> createState() => _StylePreferencesPageState();
}

class _StylePreferencesPageState extends State<StylePreferencesPage> {
  static const _styles = [
    ('Minimalist', 'assets/png/sitting-room.png'),
    ('Industrial', 'assets/png/sitting-room.png'),
    ('Modern', 'assets/png/sitting-room.png'),
    ('Japandi', 'assets/png/sitting-room.png'),
    ('Scandinavian', 'assets/png/sitting-room.png'),
    ('Classic', 'assets/png/sitting-room.png'),
    ('Tropical', 'assets/png/sitting-room.png'),
    ('Contemporary', 'assets/png/sitting-room.png'),
  ];

  final _cubit = Modular.get<PreferencesCubit>();
  final Set<String> _selectedStyles = {'Minimalist'};
  final _budgetMinController = TextEditingController();
  final _budgetMaxController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _budgetMinController.dispose();
    _budgetMaxController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _save() {
    if (_selectedStyles.isEmpty) {
      _showError('Pilih minimal satu gaya.');
      return;
    }

    final budgetMin = double.tryParse(_budgetMinController.text.trim()) ?? 0;
    final budgetMax = double.tryParse(_budgetMaxController.text.trim()) ?? 0;

    if (budgetMin <= 0 || budgetMax <= 0) {
      _showError('Budget minimum dan maksimum harus lebih dari 0.');
      return;
    }

    if (_locationController.text.trim().isEmpty) {
      _showError('Lokasi wajib diisi.');
      return;
    }

    _cubit.create(
      CreatePreferenceRequest(
        preferredStyle: _selectedStyles.first.toLowerCase(),
        budgetMin: budgetMin,
        budgetMax: budgetMax,
        preferredLocation: _locationController.text.trim(),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BlocConsumer<PreferencesCubit, PreferencesState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.saved) {
            Modular.to.navigate(ModularRoutes.primary);
          } else if (state.status.isFailure) {
            _showError(state.message);
          }
        },
        builder: (context, state) {
          final loading = state.status.isLoading;
          return SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : _save,
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
                        'Save & View Recommendations',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontStyle: GoogleFonts.inter().fontStyle,
                          fontWeight: FontWeight.w700,
                          color: ChakraColors.white,
                        ),
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
                      'Architecture Style',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.bold,
                        color: ChakraColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choose one or more styles that you like.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 390,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _styles.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: .82,
                        ),
                        itemBuilder: (context, index) {
                          final style = _styles[index];
                          final isSelected =
                              _selectedStyles.contains(style.$1);

                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedStyles.remove(style.$1);
                                } else {
                                  _selectedStyles.add(style.$1);
                                }
                              });
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ChakraColors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? ChakraColors.black
                                      : ChakraColors.gray200,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(style.$2),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      style.$1,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontStyle:
                                                GoogleFonts.inter().fontStyle,
                                            fontWeight: FontWeight.w700,
                                            color: ChakraColors.black,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Project Detail',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.bold,
                        color: ChakraColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _budgetMinController,
                      label: 'Budget Minimum (Rupiah)',
                      hint: '100000000',
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.payments_outlined,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _budgetMaxController,
                      label: 'Budget Maksimum (Rupiah)',
                      hint: '400000000',
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.payments_outlined,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Just an estimate, can be adjusted later.',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _locationController,
                      label: 'Location Project',
                      hint: 'Jakarta',
                      isRequired: true,
                      prefixIcon: Icons.location_on_outlined,
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
