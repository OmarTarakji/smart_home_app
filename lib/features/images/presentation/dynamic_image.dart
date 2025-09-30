import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/utils/extensions.dart';

class DynamicImage extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final String svgFallback;
  final String svgError = Images.BROKEN_IMAGE;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const DynamicImage({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.svgFallback = Images.FALLBACK,
    this.height = 150,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return _buildImageContent(context);
  }

  Widget _buildImageContent(BuildContext context) {
    // Local file takes highest priority
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (_, _, _) => _buildFallback(context, svgError),
      );
    }

    // Network image next
    if (imageUrl?.isNotEmpty ?? false) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (_, _) => _buildLoadingPlaceholder(context),
        errorWidget: (_, _, _) => _buildFallback(context, svgError),
      );
    }

    // Fallback when no image is provided
    return _buildFallback(context, svgFallback);
  }

  Widget _buildFallback(BuildContext context, String image) {
    final foregroundColor =
        this.foregroundColor ?? context.colorScheme.secondary.withAlpha(150);
    final backgroundColor =
        this.backgroundColor ?? context.colorScheme.secondaryContainer;

    return Container(
      alignment: Alignment.center,
      color: backgroundColor,
      height: height,
      child: SvgPicture.asset(
        image,
        height: height * 0.8,
        colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
      ),
    );
  }

  Widget _buildLoadingPlaceholder(BuildContext context) {
    final backgroundColor =
        this.backgroundColor ?? context.colorScheme.secondaryContainer;

    return Container(
      height: height,
      color: backgroundColor,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class DynamicImageEditor extends DynamicImage {
  const DynamicImageEditor({
    super.key,
    super.imageUrl,
    super.imageFile,
    super.svgFallback,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: _buildImageContent(context),
    );
  }

  @override
  Widget _buildFallback(BuildContext context, String image) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(12),
        dashPattern: const [8, 8],
        borderPadding: const EdgeInsets.all(1.5),
        strokeWidth: 3,
        color: context.colorScheme.outlineVariant,
      ),
      child: Container(
        alignment: Alignment.center,
        height: height,
        child: SvgPicture.asset(
          image,
          height: height * 0.85,
          colorFilter: ColorFilter.mode(
            context.colorScheme.outlineVariant,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class RoundedImage extends DynamicImage {
  const RoundedImage({
    super.key,
    super.imageUrl,
    super.imageFile,
    super.svgFallback,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height,
      height: height,
      child: ClipOval(child: _buildImageContent(context)),
    );
  }
}
