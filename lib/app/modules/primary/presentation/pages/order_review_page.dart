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

class OrderReviewPage extends StatefulWidget {
  const OrderReviewPage({super.key, this.quotationId});

  final String? quotationId;

  @override
  State<OrderReviewPage> createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  final _cubit = Modular.get<QuotationCubit>();

  @override
  void initState() {
    super.initState();
    if (widget.quotationId != null) {
      _cubit.load(widget.quotationId!);
    }
  }

  void _onContinue() {
    if (widget.quotationId == null) {
      // Demo flow without a real quotation — just proceed to payment.
      Modular.to.pushNamed(
        ModularRoutes.path(ModularRoutes.primaryPaymentMethod),
      );
      return;
    }
    _cubit.accept(widget.quotationId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BlocConsumer<QuotationCubit, QuotationState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.actionStatus.isSuccess && state.accepted != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Penawaran diterima.')),
            );
            Modular.to.pushNamed(
              ModularRoutes.path(ModularRoutes.primaryPaymentMethod),
            );
          } else if (state.actionStatus.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final loading = state.actionStatus.isLoading;
          return SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: loading ? null : _onContinue,
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
                      widget.quotationId == null
                          ? 'Choose Payment Method'
                          : 'Accept & Choose Payment',
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
                      'Order Review',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontStyle: GoogleFonts.inter().fontStyle,
                        fontWeight: FontWeight.bold,
                        color: ChakraColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Confirm your order details before proceeding to payment.',
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
      return const _ReviewSection(
        title: 'Payment Summary',
        lines: [
          'Penawaran belum tersedia.',
          'Order akan tampil setelah designer mengirim quotation.',
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
            _ReviewSection(
              title: 'Project Scope',
              lines: [
                quotation.scopeOfWork ?? '-',
                'Duration: ${quotation.durationDays} days',
              ],
            ),
            const SizedBox(height: 12),
            _ReviewSection(
              title: 'Payment Summary',
              lines: [
                'Offered Price: ${formatRupiah(quotation.offeredPrice)}',
                'Status: ${quotation.status}',
              ],
              highlightLastLine: true,
            ),
          ],
        );
      },
    );
  }
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({
    required this.title,
    required this.lines,
    this.highlightLastLine = false,
  });

  final String title;
  final List<String> lines;
  final bool highlightLastLine;

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
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontStyle: GoogleFonts.inter().fontStyle,
              fontWeight: FontWeight.bold,
              color: ChakraColors.black,
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(lines.length, (index) {
            final isLast = index == lines.length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
              child: Text(
                lines[index],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontStyle: GoogleFonts.inter().fontStyle,
                  color: highlightLastLine && isLast
                      ? ChakraColors.yellow700
                      : ChakraColors.gray600,
                  fontWeight: highlightLastLine && isLast
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
