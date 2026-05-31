import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Helpers for resolving image URLs.
///
/// When the backend does not provide an image (`null`/empty), we fall back to a
/// deterministic placeholder from picsum.photos keyed by a [seed] (usually an
/// entity id). Using the id as the seed means each card/profile gets a distinct
/// but stable image instead of every item sharing the same bundled asset.

String _placeholderUrl(String seed, int width, int height) {
  final safeSeed = seed.isEmpty ? 'mnb' : Uri.encodeComponent(seed);
  return 'https://picsum.photos/seed/$safeSeed/$width/$height';
}

/// Returns [url] when it is a usable network image, otherwise a seeded
/// placeholder URL.
String imageUrlOrPlaceholder(
  String? url, {
  required String seed,
  int width = 600,
  int height = 400,
}) {
  if (url != null && url.trim().isNotEmpty && url.startsWith('http')) {
    return url;
  }
  return _placeholderUrl(seed, width, height);
}

/// Convenience [ImageProvider] (cached) for use in `DecorationImage`.
ImageProvider networkOrPlaceholder(
  String? url, {
  required String seed,
  int width = 600,
  int height = 400,
}) {
  return CachedNetworkImageProvider(
    imageUrlOrPlaceholder(url, seed: seed, width: width, height: height),
  );
}
