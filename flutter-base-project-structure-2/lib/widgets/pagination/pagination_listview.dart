import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'pagination_helper.dart';

class PaginationListView extends StatefulWidget {
  final PaginationHelper controller;

  final ScrollController? scrollController;

  final int itemCount;

  final IndexedWidgetBuilder itemBuilder;

  final Map<String, dynamic>? params;

  final IndexedWidgetBuilder? separatorBuilder;

  final WidgetBuilder? loadingIndicatorBuilder;

  final IndexedWidgetBuilder? loadingEffectItemBuilder;

  final int loadingEffectItemCount;

  final double listPaddingStartAndEnd;

  final Axis scrollDirection;

  final double itemPercentBeforeLoadMore;

  final bool isScrollable;

  final EdgeInsets? padding;

  final bool isRefreshIndicator;

  final VoidCallback? onRefresh;

  PaginationListView(
      {required this.controller,
      required this.itemBuilder,
      required this.itemCount,
      this.separatorBuilder,
      this.scrollController,
      this.loadingIndicatorBuilder,
      this.loadingEffectItemBuilder,
      this.loadingEffectItemCount = 10,
      this.listPaddingStartAndEnd = 0,
      this.scrollDirection = Axis.vertical,
      this.itemPercentBeforeLoadMore = 30,
      this.params,
      this.isScrollable = true,
      this.padding,
      this.onRefresh,
      this.isRefreshIndicator = true});

  @override
  _PaginationListViewState createState() => _PaginationListViewState();
}

class _PaginationListViewState extends State<PaginationListView> {
  Widget buildItem(int index) {
    // if (widget.controller.isFirstLoad) {
    //   return widget.loadingEffectItemBuilder?.call(context, index) ??
    //       SizedBox();
    // }
    if (index < widget.itemCount) {
      return widget.itemBuilder.call(context, index);
    }

    //bottom indicator
    if (widget.controller.canLoadMore(params: widget.params)) {
      return VisibilityDetector(
          key: GlobalKey(),
          onVisibilityChanged: (visibilityInfo) {
            var visiblePercentage = visibilityInfo.visibleFraction * 100;
            if (!widget.controller.isLoading &&
                visiblePercentage > widget.itemPercentBeforeLoadMore) {
              widget.controller.loadMore(params: widget.params);
            }
          },
          child: widget.loadingIndicatorBuilder?.call(context) ??
              widget.loadingEffectItemBuilder?.call(context, index) ?? CircularProgressIndicator());
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isVertical = widget.scrollDirection == Axis.vertical;
    Widget child = ListView.separated(
      padding: widget.padding,
      scrollDirection: widget.scrollDirection,
      controller: widget.isScrollable ? widget.scrollController : null,
      physics: widget.isScrollable
          ? AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      shrinkWrap: widget.isScrollable ? false : true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: isVertical
                ? (index == 0 ? widget.listPaddingStartAndEnd : 0)
                : 0,
            bottom: isVertical
                ? (index == listLength - 1 ? widget.listPaddingStartAndEnd : 0)
                : 0,
            left: isVertical
                ? 0
                : (index == 0 ? widget.listPaddingStartAndEnd : 0),
            right: isVertical
                ? 0
                : (index == listLength - 1 ? widget.listPaddingStartAndEnd : 0),
          ),
          child: buildItem(index),
        );
      },
      separatorBuilder: (context, index) =>
          widget.separatorBuilder?.call(context, index) ?? SizedBox(),
      itemCount: widget.controller.canLoadMore(params: widget.params)
          ? listLength
          : widget.itemCount,
    );

    if (widget.isRefreshIndicator)
      return RefreshIndicator(
        onRefresh: () async {
          widget.onRefresh?.call();
          await widget.controller.refresh();
        },
        child: child,
      );
    return child;
  }

  int get listLength => widget.controller.isFirstLoad
      ? widget.loadingEffectItemCount
      : widget.itemCount + 1;
}
