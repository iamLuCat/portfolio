import 'package:flutter/material.dart';
import 'package:portfolio/app/config/app_color.dart';

class HoverBorderContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final bool isPopular;
  final bool isTransparent;
  final double borderRadius;

  const HoverBorderContainer({
    super.key,
    required this.child,
    this.width,
    this.padding,
    this.isPopular = false,
    this.isTransparent = false,
    this.borderRadius = 10,
  });

  @override
  State<HoverBorderContainer> createState() => _HoverBorderContainerState();
}

class _HoverBorderContainerState extends State<HoverBorderContainer> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    if (widget.isTransparent) {
      bgColor = _isHovering ? AppColor.white : AppColor.transparent;
    } else {
      bgColor = widget.isPopular ? AppColor.black : AppColor.white;
    }

    Color borderColor;
    if (_isHovering) {
      borderColor = AppColor.primary;
    } else {
      borderColor = widget.isPopular || widget.isTransparent ? AppColor.transparent : AppColor.grey200;
    }

    List<BoxShadow>? boxShadow;
    if (!widget.isTransparent && !widget.isPopular) {
      boxShadow = [
        BoxShadow(
            color: _isHovering ? AppColor.primary.withValues(alpha: 0.2) : AppColor.grey100,
            blurRadius: 15,
            offset: const Offset(0, 5)
        )
      ];
    } else if (widget.isPopular) {
      boxShadow = [const BoxShadow(color: AppColor.black26, blurRadius: 20, offset: Offset(0, 10))];
    } else if (widget.isTransparent && _isHovering) {
      boxShadow = [BoxShadow(color: AppColor.grey200, blurRadius: 10, offset: const Offset(0, 5))];
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: boxShadow,
        ),
        transform: _isHovering ? Matrix4.translationValues(0, -5, 0) : Matrix4.identity(),
        child: widget.child,
      ),
    );
  }
}
