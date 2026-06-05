import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/quotation_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/currency.dart';
import 'package:mnb_mobile/tool/modular_routes.dart';

class QuoteSummaryPage extends StatefulWidget {
  const QuoteSummaryPage({super.key, this.quotationId});

  final String? quotationId;

  @override
  State<QuoteSummaryPage> createState() => _QuoteSummaryPageState();
}

class _QuoteSummaryPageState extends State<QuoteSummaryPage> {
  final _cubit = Modular.get<QuotationCubit>();

  @override
  void initState() {
    super.initState();
    if (widget.quotationId != null) {
      _cubit.load(widget.quotationId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ElevatedButton(
          onPressed: () => Modular.to.pushNamed(
            ModularRoutes.primaryOrderReview,
            arguments: widget.quotationId,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ChakraColors.black,
            foregroundColor: ChakraColors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            'Continue to Order Review',
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
                      'Quote Summary',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.bold,
                        color: ChakraColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Review the estimated scope and cost prepared for this design request.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        color: ChakraColors.gray600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildBody(context),
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

  Widget _buildBody(BuildContext context) {
    if (widget.quotationId == null) {
      // TODO: Quotations are created by a designer (POST /quotation). Until a
      // designer responds to the project request there is no quotation id to
      // load here, so we show an informational placeholder.
      return Column(
        children: const [
          _SummaryCard(
            title: 'Status',
            value: 'Menunggu penawaran dari designer',
          ),
          SizedBox(height: 12),
          _SummaryCard(
            title: 'Info',
            value:
                'Penawaran akan tampil setelah designer mengirim quotation.',
          ),
        ],
      );
    }

    return BlocBuilder<QuotationCubit, QuotationState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.status.isLoading || state.status.isInitial) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 48),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status.isFailure || state.quotation == null) {
          return Column(
            children: [
              Text(
                state.message.isEmpty
                    ? 'Gagal memuat penawaran.'
                    : state.message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ChakraColors.gray600,
                ),
              ),
              TextButton(
                onPressed: () => _cubit.load(widget.quotationId!),
                child: const Text('Coba lagi'),
              ),
            ],
          );
        }

        final quotation = state.quotation!;
        return Column(
          children: [
            _SummaryCard(
              title: 'Scope of Work',
              value: quotation.scopeOfWork ?? '-',
            ),
            const SizedBox(height: 12),
            _SummaryCard(
              title: 'Estimated Delivery',
              value: '${quotation.durationDays} days',
            ),
            const SizedBox(height: 12),
            _SummaryCard(
              title: 'Offered Price',
              value: formatRupiah(quotation.offeredPrice),
              highlight: true,
            ),
            const SizedBox(height: 12),
            _SummaryCard(title: 'Status', value: quotation.status),
          ],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    this.highlight = false,
  });

  final String title;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChakraColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ChakraColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              color: ChakraColors.gray500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              fontWeight: FontWeight.w700,
              color: highlight ? ChakraColors.yellow700 : ChakraColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
