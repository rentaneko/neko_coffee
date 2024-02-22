import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FailurePage extends StatelessWidget {
  const FailurePage({
    super.key,
    required this.error,
    this.padding,
    this.onPressed,
  });
  final String error;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: FailureContent(
          description: error,
          image: 'assets/svg/network.svg',
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    super.key,
    required this.error,
    this.padding,
    this.onPressed,
  });
  final String error;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.topCenter,
      child: FailureContent(
        description: error,
        image: 'assets/svg/network.svg',
        onPressed: onPressed,
      ),
    );
  }
}

class FailureContent extends StatelessWidget {
  const FailureContent({
    super.key,
    required this.description,
    this.image,
    this.onPressed,
  });
  final String description;
  final String? image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (image != null) ...[
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: SvgPicture.asset(
              image!,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
        Text(
          description,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40,
        ),
        if (onPressed != null)
          Container(
            height: 40,
            constraints: const BoxConstraints(
              maxWidth: 136,
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Thử lại',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
