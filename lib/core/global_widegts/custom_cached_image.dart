import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

enum CustomImageType {
  avatar,
  grid,
  article,
  banner,
  minimal,
}

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final CustomImageType type;
  final double radius;
  final String? fallbackAsset; // Optional for banner

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    required this.type,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius = 30,
    this.fallbackAsset,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CustomImageType.avatar:
        return CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: radius,
            backgroundImage: imageProvider,
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: CircleAvatar(
              radius: radius,
              backgroundColor: Colors.white,
            ),
          ),

          errorWidget: (context, url, error) => CircleAvatar(
            radius: radius,
            backgroundColor: Colors.red[300],
            child: Icon(Icons.error, color: Colors.white),
          ),
        );

      case CustomImageType.grid:
        return CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: width,
              height: height,
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: Icon(Icons.broken_image, color: Colors.grey[600]),
          ),
        );

      case CustomImageType.article:
        return CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: width,
              height: height ?? 180,
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: width,
            height: height ?? 180,
            color: Colors.grey[200],
            child: Center(
              child: Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
        );

      case CustomImageType.banner:
        return CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => fallbackAsset != null
              ? Image.asset(fallbackAsset!, fit: fit, width: width, height: height)
              : Container(color: Colors.grey[300]),
          errorWidget: (context, url, error) => fallbackAsset != null
              ? Image.asset(fallbackAsset!, fit: fit, width: width, height: height)
              : Icon(Icons.broken_image),
        );

      case CustomImageType.minimal:
        return CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: width,
              height: height,
              color: Colors.white,
              child: Center(
                child: Icon(Icons.image, color: Colors.grey[400]),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Icon(Icons.broken_image, color: Colors.red[300]),
          ),
        );
    }
  }
}