import 'package:flutter/material.dart';

class TabsView extends StatelessWidget {
  final List<Widget> children;

  const TabsView({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: children.map((widget) => widget).toList(),
      ),
    );
  }
}
