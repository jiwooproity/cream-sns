import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Provider
import 'package:cream_sns/features/search/provider/search_provider.dart';

// Widgets
import 'package:cream_sns/features/search/widgets/user_box.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchStateProvider);
    final users = searchState.users;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => onChange(ref, value),
              decoration: const InputDecoration(
                hintText: "검색할 내용을 입력해 주세요.",
                hintStyle: TextStyle(fontSize: 15),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColors.black),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 20,
                ),
              ),
            ),
            Expanded(
              child: users.isNotEmpty
                  ? ListView(
                      children: users.map((user) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.grey),
                            ),
                          ),
                          child: UserBox(user: user),
                        );
                      }).toList(),
                    )
                  : const Center(child: Text("검색 결과가 없습니다.")),
            ),
          ],
        ),
      ),
    );
  }

  void onChange(WidgetRef ref, String value) {
    ref.read(searchStateProvider.notifier).onChanged(value);
  }
}
