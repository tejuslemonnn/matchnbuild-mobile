import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mnb_mobile/theme/colors.dart';
import 'package:mnb_mobile/tool/debouncer.dart';

class BaseBodyPage extends StatefulWidget {
  final List<Widget> children;
  final ScrollController? scrollController;
  final VoidCallback? onLoadNextPage;
  final RefreshCallback? onRefresh;
  final bool isNestedScroll;
  final Widget? bodyNestedScroll;

  const BaseBodyPage({
    super.key,
    required this.children,
    this.scrollController,
    this.onLoadNextPage,
    this.onRefresh,
    this.isNestedScroll = false,
    this.bodyNestedScroll,
  });

  @override
  State<BaseBodyPage> createState() => _BaseBodyPageState();
}

class _BaseBodyPageState extends State<BaseBodyPage> {
  final _debouncer = Debouncer(milliseconds: 500);

  late final controller = widget.scrollController ?? ScrollController();

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (widget.scrollController != null && widget.onLoadNextPage != null) {
          var triggerFetchMoreSize =
              0.75 * widget.scrollController!.position.maxScrollExtent;

          if (widget.scrollController!.position.pixels >=
                  triggerFetchMoreSize &&
              (widget.scrollController!.position.userScrollDirection ==
                  ScrollDirection.reverse)) {
            _debouncer.run(() {
              widget.onLoadNextPage!();
            });
          }
        }

        return true;
      },
      child: widget.onRefresh == null
          ? _getScrollableView()
          : RefreshIndicator(
              color: AppColors.primaryColor,
              child: _getScrollableView(),
              onRefresh: widget.onRefresh!,
            ),
    );
  }

  _getScrollableView() {
    if (widget.isNestedScroll) {
      return NestedScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return widget.children;
        },
        body: widget.bodyNestedScroll ?? const SizedBox.shrink(),
      );
    } else {
      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: widget.scrollController,
        slivers: widget.children,
      );
    }
  }
}
