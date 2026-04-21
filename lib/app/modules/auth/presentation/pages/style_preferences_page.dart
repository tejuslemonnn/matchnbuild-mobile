import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
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

  final Set<String> _selectedStyles = {'Minimalist'};
  final _budgetController = TextEditingController();
  final _locationController = TextEditingController();
  String? _buildingType = 'Residential';

  @override
  void dispose() {
    _budgetController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Modular.to.navigate(ModularRoutes.primary),
            style: ElevatedButton.styleFrom(
              backgroundColor: ChakraColors.black,
              foregroundColor: ChakraColors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'Save & View Recommendations',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontStyle: GoogleFonts.inter().fontStyle,
                fontWeight: FontWeight.w700,
                color: ChakraColors.white,
              ),
            ),
          ),
        ),
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
                          final isSelected = _selectedStyles.contains(style.$1);

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
                                        borderRadius: const BorderRadius.vertical(
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
                    DropdownButtonFormField<String>(
                      initialValue: _buildingType,
                      decoration: const InputDecoration(
                        labelText: 'Building Type',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Residential',
                          child: Text('Residential'),
                        ),
                        DropdownMenuItem(
                          value: 'Commercial',
                          child: Text('Commercial'),
                        ),
                        DropdownMenuItem(
                          value: 'Office',
                          child: Text('Office'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _buildingType = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _budgetController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Estimation Budget (Rupiah)',
                        border: OutlineInputBorder(),
                      ),
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
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location Project',
                        border: OutlineInputBorder(),
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
