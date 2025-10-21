import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isFavorite;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onToggleFavorite;

  const OfferCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final showQuantityControls = quantity > 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen + badge
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFFFDFDFD),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        product['image'],
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.shopping_bag, size: 60, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                if (product.containsKey('discount'))
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        '-${product['discount']}',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Información del producto
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Precios
                  Row(
                    children: [
                      Text(
                        product['price'],
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (product.containsKey('originalPrice')) ...[
                        const SizedBox(width: 6),
                        Text(
                          product['originalPrice'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ]
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Nombre
                  Expanded(
                    child: Text(
                      product['name'],
                      style: const TextStyle(fontSize: 11, color: Colors.black87, height: 1.2),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Controles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showQuantityControls
                          ? Row(children: [
                              GestureDetector(onTap: onRemove, child: const Icon(Icons.remove_circle_outline, size: 18, color: Colors.red)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              GestureDetector(onTap: onAdd, child: const Icon(Icons.add_circle_outline, size: 18, color: Colors.red)),
                            ])
                          : GestureDetector(
                              onTap: onAdd,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                child: const Icon(Icons.add_shopping_cart, size: 14, color: Colors.white),
                              ),
                            ),
                      GestureDetector(
                        onTap: onToggleFavorite,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
