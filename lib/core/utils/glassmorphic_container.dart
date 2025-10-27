import 'dart:ui';
import 'package:flutter/material.dart';

/// Glassmorphic Container Widget
/// Creates a modern frosted glass effect popular in iOS/macOS design
/// Features:
/// - Blur effect using BackdropFilter
/// - Semi-transparent background
/// - Subtle border
/// - Customizable blur intensity and colors
class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double blur;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Gradient? gradient;

  const GlassmorphicContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 16.0,
    this.blur = 10.0,
    this.color = Colors.white,
    this.borderColor = Colors.white,
    this.borderWidth = 1.5,
    this.padding,
    this.margin,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor.withOpacity(0.2),
          width: borderWidth,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blur,
            sigmaY: blur,
          ),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient: gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(0.1),
                      color.withOpacity(0.05),
                    ],
                  ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Glassmorphic Card Widget
/// Pre-configured glassmorphic container optimized for card layouts
class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const GlassmorphicCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final card = GlassmorphicContainer(
      borderRadius: 20,
      blur: 15,
      color: isDark ? Colors.white : Colors.black,
      borderColor: isDark ? Colors.white : Colors.black,
      borderWidth: 1.5,
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: card,
        ),
      );
    }

    return card;
  }
}

/// Glassmorphic AppBar
/// Creates a frosted glass effect app bar
class GlassmorphicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final Widget? leading;
  final double blur;

  const GlassmorphicAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.blur = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: AppBar(
          title: title,
          actions: actions,
          leading: leading,
          backgroundColor: isDark
              ? Colors.black.withOpacity(0.3)
              : Colors.white.withOpacity(0.3),
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ]
                    : [
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.02),
                      ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Glassmorphic Bottom Sheet
/// Creates a frosted glass bottom sheet
class GlassmorphicBottomSheet extends StatelessWidget {
  final Widget child;
  final double? height;

  const GlassmorphicBottomSheet({
    super.key,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                    ]
                  : [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.05),
                    ],
            ),
            border: Border(
              top: BorderSide(
                color: isDark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  /// Show glassmorphic bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    double? height,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      builder: (context) => GlassmorphicBottomSheet(
        height: height,
        child: child,
      ),
    );
  }
}
