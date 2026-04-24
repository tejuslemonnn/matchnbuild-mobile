import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';

class PriceRequestPage extends StatefulWidget {
  const PriceRequestPage({super.key});

  @override
  State<PriceRequestPage> createState() => _PriceRequestPageState();
}

class _PriceRequestPageState extends State<PriceRequestPage> {
  final _spaceController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _spaceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ElevatedButton(
          onPressed: () => Modular.to.pushNamed('./quote-summary'),
          style: ElevatedButton.styleFrom(
            backgroundColor: ChakraColors.black,
            foregroundColor: ChakraColors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            'Request Quote',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              fontWeight: FontWeight.w700,
              color: ChakraColors.white,
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
                      initialValue: 'Living Room',
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
                      onChanged: (_) {},
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
                    DropdownButtonFormField<String>(
                      initialValue: '2 Weeks',
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
                      onChanged: (_) {},
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
