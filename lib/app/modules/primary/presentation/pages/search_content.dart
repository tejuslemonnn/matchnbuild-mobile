import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/design_item_model.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/design_items_cubit.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/controller/view_status.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/search_content_widgets.dart';
import 'package:mnb_mobile/app/widgets/base_body_page.dart';
import 'package:mnb_mobile/theme/colors.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({super.key});

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  static const List<String> _categories = [
    'Semua',
    'Minimalis',
    'Industrial',
    'Modern',
  ];

  final _cubit = Modular.get<DesignItemsCubit>();
  String _selectedCategory = 'Semua';
  String _query = '';

  @override
  void initState() {
    super.initState();
    _cubit.load();
  }

  List<DesignItemModel> _filter(List<DesignItemModel> items) {
    return items.where((item) {
      final matchesQuery = _query.isEmpty ||
          item.title.toLowerCase().contains(_query.toLowerCase()) ||
          (item.style ?? '').toLowerCase().contains(_query.toLowerCase()) ||
          (item.designerName ?? '')
              .toLowerCase()
              .contains(_query.toLowerCase());

      final matchesCategory = _selectedCategory == 'Semua' ||
          (item.style ?? '')
              .toLowerCase()
              .contains(_selectedCategory.toLowerCase());

      return matchesQuery && matchesCategory;
    }).toList();
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
                  TextField(
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: 'Cari desain, arsitek, atau gaya...',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!
                          .copyWith(
                            fontStyle: GoogleFonts.inter().fontStyle,
                            color: ChakraColors.gray400,
                          ),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.tune),
                      filled: true,
                      fillColor: ChakraColors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: ChakraColors.gray200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: ChakraColors.gray200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: ChakraColors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];

                        return SearchCategoryBadge(
                          label: category,
                          isActive: _selectedCategory == category,
                          onTap: () {
                            setState(() => _selectedCategory = category);
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<DesignItemsCubit, DesignItemsState>(
                    bloc: _cubit,
                    builder: (context, state) {
                      if (state.status.isLoading || state.status.isInitial) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 48),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (state.status.isFailure) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Column(
                            children: [
                              Text(
                                state.message.isEmpty
                                    ? 'Gagal memuat desain.'
                                    : state.message,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: ChakraColors.gray600),
                              ),
                              TextButton(
                                onPressed: _cubit.load,
                                child: const Text('Coba lagi'),
                              ),
                            ],
                          ),
                        );
                      }

                      final items = _filter(state.items);

                      if (items.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 48),
                          child: Center(child: Text('Tidak ada hasil.')),
                        );
                      }

                      final trending = items.take(5).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeader(
                            title: 'Trending',
                            actionLabel: 'View All',
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .195,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: trending.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  SearchTrendingCard(item: trending[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 12),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const SectionHeader(
                            title: 'Latest Inspiration',
                            actionLabel: 'View All',
                          ),
                          const SizedBox(height: 12),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: .72,
                            ),
                            itemBuilder: (context, index) =>
                                LatestInspirationCard(item: items[index]),
                          ),
                        ],
                      );
                    },
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
