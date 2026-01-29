import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../color_res.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const Opacity(
            opacity: 0.1,
            child: ModalBarrier(dismissible: false, color: ColorRes.white),
          ),
        if (isLoading)
          Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              size: 50,
              color: ColorRes.primaryDark,
            ),
          ),
      ],
    );
  }
}
