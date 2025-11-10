import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../bloc/random_image_bloc.dart';

typedef NetworkImageBuilder = Widget Function(
  BuildContext context,
  String imageUrl,
  Color accentColor,
);

class RandomImageView extends StatelessWidget {
  const RandomImageView({
    super.key,
    this.networkImageBuilder,
  });

  final NetworkImageBuilder? networkImageBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<RandomImageBloc, RandomImageState>(
      builder: (context, state) {
        final backgroundColor =
            state.backgroundColor ?? theme.colorScheme.surface;
        final foregroundColor = _foregroundColorFor(backgroundColor, theme);
        final buttonBackgroundColor = _buttonBackgroundColor(backgroundColor);
        final buttonForegroundColor = _foregroundColorFor(
          buttonBackgroundColor,
          theme,
        );
        const appBarHeight = 300.0;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(appBarHeight),
            child: _CurvedAppBar(
              backgroundColor: buttonBackgroundColor,
              foregroundColor: buttonForegroundColor,
              height: appBarHeight,
            ),
          ),
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            color: backgroundColor,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: _buildContent(
                          context,
                          state,
                          foregroundColor,
                          networkImageBuilder,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Semantics(
                      button: true,
                      enabled: !state.isLoading,
                      label: 'Load another random image',
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () => context.read<RandomImageBloc>().add(
                                  const RandomImageEvent.refreshRequested(),
                                ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: buttonBackgroundColor,
                            foregroundColor: buttonForegroundColor,
                            disabledBackgroundColor: buttonBackgroundColor
                                .withValues(alpha: 0.6),
                            disabledForegroundColor: buttonForegroundColor
                                .withValues(alpha: 0.8),
                            textStyle: theme.textTheme.titleMedium?.copyWith(
                              color: buttonForegroundColor,
                            ),
                          ),
                          child: state.isLoading
                              ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.6,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      buttonForegroundColor,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Another',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: buttonForegroundColor,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    RandomImageState state,
    Color foregroundColor,
    NetworkImageBuilder? networkImageBuilder,
  ) {
    if (state.isLoading && state.image == null) {
      return _LoadingIndicator(color: foregroundColor);
    }

    if (state.isFailure) {
      return _ErrorMessage(
        message: state.errorMessage ?? 'Something went wrong.',
        color: foregroundColor,
      );
    }

    final imageUrl = state.image?.url;
    if (imageUrl == null || imageUrl.isEmpty) {
      return _ErrorMessage(
        message: 'No image to display right now.',
        color: foregroundColor,
      );
    }

    final imageName =
        Uri.tryParse(imageUrl)?.pathSegments.lastOrNull ?? 'Random image';

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCubic,
        );
        final offsetTween = Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        );
        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: offsetTween.animate(curvedAnimation),
            child: child,
          ),
        );
      },
      child: Align(
        key: ValueKey(imageUrl),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipPath(
              clipper: const TopBumpClipper(),
              child: AspectRatio(
                aspectRatio: 1,
                child: networkImageBuilder != null
                    ? networkImageBuilder!(context, imageUrl, foregroundColor)
                    : CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 300),
                        fadeOutDuration: const Duration(milliseconds: 200),
                        placeholder: (_, __) =>
                            _LoadingIndicator(color: foregroundColor),
                        errorWidget: (_, __, ___) => _ErrorMessage(
                          message: 'Could not load image.',
                          color: foregroundColor,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              imageName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: foregroundColor.withValues(alpha: 0.95),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _foregroundColorFor(Color background, ThemeData theme) {
    final luminance = background.computeLuminance();

    if (luminance >= 0.7) {
      return Colors.black87;
    }
    if (luminance <= 0.2) {
      return Colors.white;
    }

    return luminance > 0.45 ? Colors.black87 : Colors.white;
  }

  Color _buttonBackgroundColor(Color background) {
    final luminance = background.computeLuminance();
    if (luminance <= 0.45) {
      return Color.lerp(background, Colors.white, 0.3) ??
          background.withValues(alpha: 0.9);
    }
    return Color.lerp(background, Colors.black, 0.25) ??
        background.withValues(alpha: 0.9);
  }
}

class _CurvedAppBar extends StatelessWidget {
  const _CurvedAppBar({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.height,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackground = backgroundColor.withValues(alpha: 0.92);
    return ClipPath(
      clipper: const AppBarBumpClipper(),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: effectiveBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Aurora Gallery',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: Image.asset(
                    'assets/Aurora Text Logo.png',
                    fit: BoxFit.contain,
                    semanticLabel: 'Aurora logo',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortestSide = constraints.biggest.shortestSide;
        final size = shortestSide.isFinite && shortestSide > 0
            ? shortestSide / 5
            : 48.0;
        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: SpinKitSpinningLines(
              color: color,
              size: size,
              lineWidth: size * 0.05,
            ),
          ),
        );
      },
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.message, required this.color});

  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          size: 48,
          color: color.withValues(alpha: 0.85),
        ),
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: color.withValues(alpha: 0.9)),
        ),
      ],
    );
  }
}

class TopBumpClipper extends CustomClipper<Path> {
  const TopBumpClipper({this.cornerRadius = 24, this.bumpHeightFactor = 0.4});

  final double cornerRadius;
  final double bumpHeightFactor;

  @override
  Path getClip(Size size) {
    final safeCornerRadius = cornerRadius
        .clamp(0, size.shortestSide / 2)
        .toDouble();
    final leftCornerX = safeCornerRadius;
    final rightCornerX = size.width - safeCornerRadius;

    final bumpHeight = (size.height - safeCornerRadius) * bumpHeightFactor;

    final path = Path()
      ..moveTo(0, safeCornerRadius)
      ..quadraticBezierTo(0, 0, leftCornerX, 0)
      ..quadraticBezierTo(size.width * 0.5, bumpHeight, rightCornerX, 0)
      ..quadraticBezierTo(size.width, 0, size.width, safeCornerRadius)
      ..lineTo(size.width, size.height - safeCornerRadius)
      ..quadraticBezierTo(size.width, size.height, rightCornerX, size.height)
      ..lineTo(leftCornerX, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - safeCornerRadius)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant TopBumpClipper oldClipper) {
    return oldClipper.cornerRadius != cornerRadius ||
        oldClipper.bumpHeightFactor != bumpHeightFactor;
  }
}

class AppBarBumpClipper extends CustomClipper<Path> {
  const AppBarBumpClipper({
    this.depthFactor = 0.25,
    this.cornerLiftFactor = 0.12,
  });

  final double depthFactor;
  final double cornerLiftFactor;

  @override
  Path getClip(Size size) {
    final depth = (size.height * depthFactor).clamp(0.0, size.height);
    final rawCurveY = size.height - depth;
    final cornerLift = (size.height * cornerLiftFactor).clamp(0.0, rawCurveY);
    final cornerY = rawCurveY - cornerLift;

    return Path()
      ..moveTo(0, 0)
      ..lineTo(0, cornerY * 0.6)
      ..quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        cornerY * 0.6,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant AppBarBumpClipper oldClipper) =>
      oldClipper.depthFactor != depthFactor ||
      oldClipper.cornerLiftFactor != cornerLiftFactor;
}

class ArcText extends StatelessWidget {
  const ArcText({
    super.key,
    required this.text,
    required this.color,
    this.height = 80,
    this.leftAngleOffset = -math.pi / 10,
    this.rightAngleOffset = math.pi / 10,
  });

  final String text;
  final Color color;
  final double height;
  final double leftAngleOffset;
  final double rightAngleOffset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style =
        theme.textTheme.titleMedium?.copyWith(
          color: color.withValues(alpha: 0.9),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ) ??
        TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w600);

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _ArcTextPainter(
          text: text,
          style: style,
          leftAngleOffset: leftAngleOffset,
          rightAngleOffset: rightAngleOffset,
        ),
      ),
    );
  }
}

class _ArcTextPainter extends CustomPainter {
  _ArcTextPainter({
    required this.text,
    required this.style,
    required this.leftAngleOffset,
    required this.rightAngleOffset,
  });

  final String text;
  final TextStyle style;
  final double leftAngleOffset;
  final double rightAngleOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final trimmed = text.trim().isEmpty ? 'Random Image' : text.trim();
    final path = Path()
      ..moveTo(0, size.height * 0.85)
      ..quadraticBezierTo(
        size.width / 2,
        size.height * 0.05,
        size.width,
        size.height * 0.85,
      );

    final metric = path.computeMetrics().isEmpty
        ? null
        : path.computeMetrics().first;
    if (metric == null) {
      return;
    }

    final spanChars = trimmed.characters.toList();
    double totalAdvance = 0;

    for (final char in spanChars) {
      final painter = TextPainter(
        text: TextSpan(text: char, style: style),
        textDirection: TextDirection.ltr,
      )..layout();
      final width = painter.width;
      totalAdvance += width;
    }

    final pathLength = metric.length;
    if (totalAdvance == 0 || pathLength <= 0) {
      return;
    }

    final effectiveSpacing = math.max(
      (pathLength - totalAdvance) / (spanChars.length + 1),
      0.0,
    );
    double distance = effectiveSpacing;

    final count = spanChars.length;
    for (var i = 0; i < count; i++) {
      final char = spanChars[i];
      final painter = TextPainter(
        text: TextSpan(text: char, style: style),
        textDirection: TextDirection.ltr,
      )..layout();

      final halfAdvance = painter.width / 2;
      final tangent = metric.getTangentForOffset(
        math.min(distance + halfAdvance, pathLength),
      );
      if (tangent != null) {
        canvas.save();
        canvas.translate(tangent.position.dx, tangent.position.dy);
        final t = count <= 1 ? 0.5 : i / (count - 1);
        final angleOffset =
            leftAngleOffset + (rightAngleOffset - leftAngleOffset) * t;
        canvas.rotate(tangent.angle - math.pi / 2 + angleOffset);
        painter.paint(canvas, Offset(-halfAdvance, -painter.height * 0.65));
        canvas.restore();
      }

      distance += painter.width + effectiveSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant _ArcTextPainter oldDelegate) {
    return oldDelegate.text != text ||
        oldDelegate.style != style ||
        oldDelegate.leftAngleOffset != leftAngleOffset ||
        oldDelegate.rightAngleOffset != rightAngleOffset;
  }
}
