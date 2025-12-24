import 'package:flutter/material.dart';
import '../../utils/breakpoints.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget body;
  final Widget? navigationRail; // For Tablet/Desktop
  final Widget? secondaryBody; // For Desktop (Right Panel)
  final Widget? bottomNavigation; // For Mobile
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;

  const AdaptiveScaffold({
    super.key,
    required this.body,
    this.navigationRail,
    this.secondaryBody,
    this.bottomNavigation,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final layoutMode = ResponsiveUtils.getLayoutMode(width);

        // Mobile Layout
        if (layoutMode == LayoutMode.mobile) {
          return Scaffold(
            appBar: appBar,
            drawer: drawer,
            endDrawer: endDrawer,
            body: body,
            bottomNavigationBar: bottomNavigation,
            backgroundColor: backgroundColor,
          );
        }

        // Tablet/Desktop Layout
        return Scaffold(
          appBar: appBar,
          drawer: drawer, // Still allow drawer on tablet if needed
          endDrawer: endDrawer,
          backgroundColor: backgroundColor,
          body: Row(
            children: [
              // Left Pane: Navigation
              if (navigationRail != null)
                SafeArea(
                  child: navigationRail!,
                ),

              // Center Pane: Main Content
              Expanded(
                child: body,
              ),

              // Right Pane: Secondary Content (Desktop only)
              if (layoutMode == LayoutMode.desktop && secondaryBody != null) ...[
                const VerticalDivider(width: 1),
                SizedBox(
                  width: 360, // Fixed width for right panel
                  child: secondaryBody,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
