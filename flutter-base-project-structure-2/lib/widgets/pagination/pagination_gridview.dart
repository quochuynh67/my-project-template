import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'pagination_helper.dart';

///only used for vertical ListView
class PaginationGridView extends StatefulWidget {
  final PaginationHelper controller;

  final ScrollController? scrollController;

  final int itemCount;

  final IndexedWidgetBuilder itemBuilder;

  final Map<String, dynamic>? params;

  final WidgetBuilder? loadingIndicatorBuilder;

  final IndexedWidgetBuilder? loadingEffectItemBuilder;

  final int loadingEffectItemCount;

  final double listPaddingStartAndEnd;

  final double paddingOutline;

  final Axis scrollDirection;

  final int crossAxisCount;

  final double mainAxisSpacing;

  final double crossAxisSpacing;

  final double childAspectRatio;

  final double itemPercentBeforeLoadMore;

  final bool isScrollable;

  final EdgeInsets? paddingItem;

  final Function()? onRefresh;

  final bool isRefreshIndicator;

  PaginationGridView({
    required this.controller,
    required this.itemBuilder,
    required this.itemCount,
    this.scrollController,
    this.loadingIndicatorBuilder,
    this.loadingEffectItemBuilder,
    this.loadingEffectItemCount = 10,
    this.listPaddingStartAndEnd = 0,
    this.paddingOutline = 0,
    this.scrollDirection = Axis.vertical,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1,
    this.itemPercentBeforeLoadMore = 30,
    this.params,
    this.isScrollable = true,
    this.paddingItem,
    this.onRefresh,
    this.isRefreshIndicator = true,
  });

  @override
  _PaginationGridViewState createState() => _PaginationGridViewState();
}

class _PaginationGridViewState extends State<PaginationGridView> {
  Widget buildItem(int index) {
    //loading items
    if (widget.controller.isFirstLoad) {
      return widget.loadingEffectItemBuilder?.call(context, index) ??
          SizedBox();
    }
    //normal item
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
            widget.loadingEffectItemBuilder?.call(context, index) ?? CircularProgressIndicator(),
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isVertical = widget.scrollDirection == Axis.vertical;

    Widget child = GridView.builder(
        scrollDirection: widget.scrollDirection,
        padding: EdgeInsets.all(widget.paddingOutline),
        controller: widget.isScrollable ? widget.scrollController : null,
        physics: widget.isScrollable
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        shrinkWrap: widget.isScrollable ? false : true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            childAspectRatio: widget.childAspectRatio,
            crossAxisSpacing: widget.crossAxisSpacing,
            mainAxisSpacing: widget.mainAxisSpacing),
        itemCount: widget.controller.canLoadMore(params: widget.params)
            ? listLength
            : widget.itemCount,
        itemBuilder: (BuildContext ctx, index) {
          return Padding(
              padding: widget.paddingItem ??
                  EdgeInsets.only(
                      top: isVertical
                          ? (index <= (widget.crossAxisCount - 1)
                              ? widget.listPaddingStartAndEnd
                              : 0)
                          : 0,
                      bottom: isVertical
                          ? (index >= widget.itemCount
                              ? widget.listPaddingStartAndEnd
                              : 0)
                          : 0,
                      left: !isVertical
                          ? (index <= (widget.crossAxisCount - 1)
                              ? widget.listPaddingStartAndEnd
                              : 0)
                          : 0,
                      right: !isVertical
                          ? (index >= widget.itemCount
                              ? widget.listPaddingStartAndEnd
                              : 0)
                          : 0),
              child: buildItem(index));
        });
    if (widget.isRefreshIndicator)
      return RefreshIndicator(
        onRefresh: () async {
          if (widget.onRefresh != null) {
            widget.onRefresh?.call();
          }
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
