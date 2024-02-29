import 'package:flutter/material.dart';
import 'pagination_helper.dart';

class PaginationPageView extends StatefulWidget {
  final PaginationHelper controller;
  final PageController? pageController;

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Map<String, dynamic>? params;

  final WidgetBuilder? loadingIndicatorBuilder;

  final IndexedWidgetBuilder? loadingEffectItemBuilder;

  final int loadingEffectItemCount;

  final Axis scrollDirection;

  final double offsetBeforeLoadMore;

  final ScrollPhysics? scrollPhysics;

  final Function(int)? onPageChanged;

  final bool allowImplicitScrolling;

  final bool panEnds;

  PaginationPageView(
      {required this.controller,
      required this.itemBuilder,
      required this.itemCount,
      this.pageController,
      this.scrollPhysics,
      this.loadingIndicatorBuilder,
      this.loadingEffectItemBuilder,
      this.loadingEffectItemCount = 10,
      this.scrollDirection = Axis.vertical,
      this.offsetBeforeLoadMore = 100,
      this.params,
      this.onPageChanged,
      this.allowImplicitScrolling = false,
      this.panEnds=true});
  @override
  _PaginationListViewState createState() => _PaginationListViewState();
}

class _PaginationListViewState extends State<PaginationPageView> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = widget.pageController ?? PageController();
    _pageController.addListener(() {
      if (currentPage != _pageController.page?.round() &&
          !widget.controller.isLoading &&
          widget.controller.canLoadMore(params: widget.params) &&
          widget.itemCount > 3 &&
          _pageController.page?.round() == widget.itemCount - 3) {
        currentPage = _pageController.page?.round() ?? 0;
        widget.controller.loadMore(params: widget.params);
      }
      checkScrollPosition(_pageController.position);
    });
  }

  //to check has the list reach end to load more
  void checkScrollPosition(ScrollMetrics scrollPosition) {
    if (scrollPosition.pixels >=
        scrollPosition.maxScrollExtent - widget.offsetBeforeLoadMore) {
      if (!widget.controller.isLoading &&
          widget.controller.canLoadMore(params: widget.params)) {
        widget.controller.loadMore(params: widget.params);
      }
    }
  }

  @override
  void dispose() {
    if (widget.pageController == null) {
      _pageController.dispose();
    }
    super.dispose();
  }

  Widget buildItem(int index) {
    // //loading items
    // if (widget.controller.isFirstLoad) {
    //   return widget.loadingEffectItemBuilder?.call(context, index) ??
    //       SizedBox();
    // }
    // //normal item
    // if (index < widget.itemCount) {
    //   return widget.itemBuilder.call(context, index);
    // }
    //
    // //bottom indicator
    // if (widget.controller.canLoadMore(params: widget.params)) {
    //   return widget.loadingIndicatorBuilder?.call(context) ??
    //       widget.loadingEffectItemBuilder?.call(context, index) ??
    //       SizedBox().appCenterProgressLoading;
    // } else {
    //   return SizedBox();
    // }
    return widget.itemBuilder.call(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await widget.controller.refresh();
      },
      child: PageView.builder(
        padEnds: widget.panEnds,
        scrollDirection: widget.scrollDirection,
        controller: _pageController,
        onPageChanged: widget.onPageChanged,
        allowImplicitScrolling: widget.allowImplicitScrolling,
        physics: widget.scrollPhysics ?? ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildItem(index);
        },
        itemCount: widget.itemCount,
        // itemCount: widget.controller.canLoadMore(params: widget.params)
        //     ? listLength
        //     : widget.itemCount,
      ),
    );
  }

  int get listLength => widget.controller.isFirstLoad
      ? widget.loadingEffectItemCount
      : widget.itemCount + 1;
}
