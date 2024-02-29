mixin PaginationHelper<T> {
  bool get isLoading;

  bool get isFirstLoad => isLoading;

  Future<void> loadMore({Map<String, dynamic>? params});

  void reset({Object? data});

  bool canLoadMore({Map<String, dynamic>? params});

  int get limit => 14;

  Future<void> refresh();
}
