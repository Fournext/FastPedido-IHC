import 'package:flutter/material.dart';

class RecommendedScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final String title;
  final int pageSize;

  const RecommendedScreen({
    super.key,
    required this.products,
    this.title = 'Recomendados',
    this.pageSize = 8,
  });

  @override
  State<RecommendedScreen> createState() => _RecommendedScreenState();
}

class _RecommendedScreenState extends State<RecommendedScreen> {
  final List<Map<String, dynamic>> _visible = [];
  late final ScrollController _controller;
  bool _isLoadingMore = false;
  int _loaded = 0;

  // Variables para favoritos y cantidades (copiadas del Dashboard)
  Set<String> _favoriteProducts = {};
  Map<String, int> _productQuantities = {};

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
    _loadMore(); // primera carga
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.pixels >=
            _controller.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadMore();
    }
  }

  void _loadMore() {
    if (_loaded >= widget.products.length) return;
    setState(() => _isLoadingMore = true);

    final next = (_loaded + widget.pageSize).clamp(0, widget.products.length);
    _visible.addAll(widget.products.sublist(_loaded, next));
    _loaded = next;

    setState(() => _isLoadingMore = false);
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.products.length - _loaded;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔙 Botón de volver + logo
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.red,
                          size: 22,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 6),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 40,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.delivery_dining,
                              color: Colors.white,
                              size: 20,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'FastPedido',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red,
                          decorationThickness: 2,
                        ),
                      ),
                    ],
                  ),

                  // 🏷️ Título (Recomendaciones)
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // 🔽 CUERPO PRINCIPAL
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: _controller,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: _visible.length,
                itemBuilder: (context, index) {
                  final product = _visible[index];
                  return _buildProductCard(product, fullWidth: true);
                },
              ),
            ),

            if (_isLoadingMore)
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: CircularProgressIndicator(),
              ),

            if (remaining > 0 && !_isLoadingMore)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _loadMore,
                  child: Text('Cargar más ($remaining)'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 📦 Copia exacta del _buildProductCard adaptado para esta pantalla
  Widget _buildProductCard(
    Map<String, dynamic> product, {
    bool fullWidth = false,
  }) {
    final productId = '${product['name']}_${product['price']}';
    final isFavorite = _favoriteProducts.contains(productId);
    final quantity = _productQuantities[productId] ?? 0;
    final showQuantityControls = quantity > 0;

    return Container(
      width: fullWidth ? null : 145,
      margin: EdgeInsets.only(right: fullWidth ? 0 : 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                product['image'],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.shopping_bag,
                    size: 60,
                    color: Colors.grey[400],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product['price'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Text(
            product['name'],
            style: TextStyle(
              fontSize: 10.5,
              height: 1.3,
              color: Colors.grey[800],
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showQuantityControls)
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (quantity > 0) {
                            _productQuantities[productId] = quantity - 1;
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.remove_circle_outline,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _productQuantities[productId] = quantity + 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.add_circle_outline,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              else
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _productQuantities[productId] = 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add_shopping_cart,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isFavorite) {
                      _favoriteProducts.remove(productId);
                    } else {
                      _favoriteProducts.add(productId);
                    }
                  });
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 22,
                  color: isFavorite ? Colors.red : Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
