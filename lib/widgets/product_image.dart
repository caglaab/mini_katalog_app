import 'package:flutter/material.dart';

/// Görsel yolu http(s) ile başlıyorsa internetten (Image.network),
/// değilse assets klasöründen (Image.asset) yükler.
/// Yüklenirken dönen çember, hata olursa ikon gösterir.
class ProductImage extends StatelessWidget {
  final String path;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
  });

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Icon(Icons.image_not_supported_outlined, color: Colors.grey.shade500),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: fit,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }

    return Image.asset(
      path,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );
  }
}
