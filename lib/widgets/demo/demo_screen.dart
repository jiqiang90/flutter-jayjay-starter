import 'package:flutter/material.dart';
import 'package:jayjay_starter/widgets/demo/demo_section.dart';

class DemoScreen extends StatelessWidget {
  final String title;
  final List<DemoSection> sections;
  final EdgeInsets? padding;

  const DemoScreen({
    super.key,
    required this.title,
    required this.sections,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: padding ?? const EdgeInsets.all(16),
        children: sections,
      ),
    );
  }
} 