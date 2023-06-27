import 'package:flutter/material.dart';
import 'package:mdp_pokedex_app/src/presentation/common/constants/colors.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    this.color,
    this.width,
    this.height,
    this.child,
  });

  final Widget? child;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        color: color ?? AppColors.primary,
      ),
      child: child,
    );
  }
}