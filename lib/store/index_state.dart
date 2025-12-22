class IndexState {
  final bool isLoading;
  final List<String> ids;

  const IndexState({this.isLoading = false, this.ids = const []});

  IndexState copyWith({bool? isLoading, List<String>? ids}) {
    return IndexState(
      isLoading: isLoading ?? this.isLoading,
      ids: ids ?? this.ids,
    );
  }
}
