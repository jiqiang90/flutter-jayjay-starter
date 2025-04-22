import 'package:flutter/material.dart';

class LoadingOverlay {
  static Future<T> show<T>({
    required BuildContext context,
    required Future<T> Function() asyncFunction,
    String? message,
  }) async {
    final overlay = OverlayEntry(
      builder: (context) => _LoadingOverlay(
        message: message,
      ),
    );

    Overlay.of(context).insert(overlay);

    try {
      final result = await asyncFunction();
      overlay.remove();
      return result;
    } catch (e) {
      overlay.remove();
      rethrow;
    }
  }
}

class _LoadingOverlay extends StatelessWidget {
  final String? message;

  const _LoadingOverlay({
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
} 