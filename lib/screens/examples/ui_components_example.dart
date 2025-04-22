import 'package:flutter/material.dart';
import 'package:jayjay_starter/widgets/demo/demo_button.dart';
import 'package:jayjay_starter/widgets/demo/demo_screen.dart';
import 'package:jayjay_starter/widgets/demo/demo_section.dart';
import 'package:jayjay_starter/widgets/dialogs/app_dialog.dart';
import 'package:jayjay_starter/widgets/loading/loading_overlay.dart';
import 'package:jayjay_starter/widgets/ads/ad_banner.dart';
import 'package:jayjay_starter/widgets/error/error_handler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class UIComponentsExample extends StatelessWidget {
  const UIComponentsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScreen(
      title: 'UI Components Example',
      sections: [
        DemoSection(
          title: 'Dialogs',
          children: [
            DemoButton(
              text: 'Show Basic Dialog',
              onPressed: () => AppDialog.show(
                context: context,
                title: 'Basic Dialog',
                content: 'This is a basic dialog example.',
              ),
            ),
            DemoButton(
              text: 'Show Confirmation Dialog',
              onPressed: () => AppDialog.showConfirmation(
                context: context,
                title: 'Confirm Action',
                content: 'Are you sure you want to proceed?',
              ),
            ),
            DemoButton(
              text: 'Show Error Dialog',
              onPressed: () => AppDialog.showError(
                context: context,
                message: 'Something went wrong!',
              ),
            ),
            DemoButton(
              text: 'Show Success Dialog',
              onPressed: () => AppDialog.showSuccess(
                context: context,
                message: 'Operation completed successfully!',
              ),
            ),
          ],
        ),
        DemoSection(
          title: 'Loading Overlay',
          children: [
            DemoButton(
              text: 'Show Loading Overlay',
              onPressed: () => LoadingOverlay.show(
                context: context,
                asyncFunction: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  return true;
                },
                message: 'Loading...',
              ),
            ),
          ],
        ),
        DemoSection(
          title: 'Error Widgets',
          children: [
            DemoButton(
              text: 'Show Error Widget',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: const Text('Error Widget Demo')),
                    body: ErrorHandler.buildErrorWidget(
                      'This is an error message',
                    ),
                  ),
                ),
              ),
            ),
            DemoButton(
              text: 'Show Retry Widget',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: const Text('Retry Widget Demo')),
                    body: ErrorHandler.buildRetryWidget(
                      message: 'Failed to load data',
                      onRetry: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Retry clicked!'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        DemoSection(
          title: 'Ad Banner',
          children: [
            const AdBanner(
              size: AdSize.banner,
              margin: EdgeInsets.symmetric(vertical: 16),
            ),
          ],
        ),
      ],
    );
  }
}
