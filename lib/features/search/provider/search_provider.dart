import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';

// Models
import 'package:cream_sns/features/auth/model/user.dart';

// Service
import 'package:cream_sns/features/search/data/search_service.dart';

final searchStateProvider =
    StateNotifierProvider.autoDispose<SearchNotifier, SearchState>((ref) {
      final client = ref.watch(searchClientProvider);
      return SearchNotifier(client);
    });

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier(this._search) : super(SearchState.initial());

  final SearchClient _search;
  Timer? _debounce;

  void onChanged(String searchText) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      state = SearchState.initial().copyWith(query: searchText);
      getSearchResult();
    });
  }

  Future<void> getSearchResult() async {
    if(state.query.isNotEmpty) {
      state = state.copyWith(isLoading: true);

      final response = await _search.getSearchResult(
        searchText: state.query,
      );

      state = state.copyWith(
        users: response,
        isLoading: false,
      );
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

class SearchState {
  SearchState({
    required this.query,
    required this.users,
    required this.isLoading,
  });

  final String query;
  final List<User> users;
  final bool isLoading;

  factory SearchState.initial() => SearchState(
    query: '',
    users: [],
    isLoading: false,
  );

  SearchState copyWith({
    String? query,
    List<User>? users,
    bool? isLoading,
  }) {
    return SearchState(
      query: query ?? this.query,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
