import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _cartItemCount = 2;
  Map<String, int> _productQuantities = {};

  final List<Map<String, dynamic>> favoriteProducts = [
    {
      'name': 'Gaseosa Pepsi\n355 Ml',
      'price': 'Bs. 4.00',
      'image': 'assets/images/pepsi.png',
    },
    {
      'name': 'Papas Pringles\nOriginal 124 gr',
      'price': 'Bs. 49.00',
      'image': 'assets/images/pringles.png',
    },
    {
      'name': 'Queso Leche\nCheesecake\nDelizia 170 g',
      'price': 'Bs. 9.30',
      'image': 'assets/images/queso.png',
    },
    {
      'name': 'Takis Fuego\nMax 240 gr',
      'price': 'Bs. 43.00',
      'image': 'assets/images/takis.png',
    },
    {
      'name': 'Popcorn ACT II\nMantequilla\n99 gr',
      'price': 'Precio',
      'image': 'assets/images/popcorn.png',
    },
    {
      'name': 'Whisky Black\nLabel 750 ml',
      'price': 'Bs. 525.00',
      'image': 'assets/images/whisky.png',
    },
    {
      'name': 'Singani Casa\nReal Etiqueta\nNegra 1 L',
      'price': 'Bs. 98.00',
      'image': 'assets/images/singani.png',
    },
    {
      'name': 'Paneton\nHuereñito\nChocolate 600 g',
      'price': 'Bs. 39.90',
      'image': 'assets/images/paneton.png',
    },
    {
      'name': 'Leche\nChocolatosa\nPil 800 ml',
      'price': 'Bs. 16.80',
      'image': 'assets/images/leche_chocolatosa.png',
    },
    {
      'name': 'Hamburguesa\nIcerito 8',
      'price': 'Bs. 32.80',
      'image': 'assets/images/hamburguesa.png',
    },
    {
      'name': 'Mantequilla Pil\nCon Sal 200 gr',
      'price': 'Bs. 24.50',
      'image': 'assets/images/mantequilla.png',
    },
    {
      'name': 'Vino Aranjuez\nRosé Tinto',
      'price': 'Precio',
      'image': 'assets/images/vino.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar por marca, categoría, producto',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 22),
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Icon(Icons.search, color: Colors.grey[600], size: 28),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Text(
              'Productos Favoritos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  return _buildFavoriteCard(favoriteProducts[index]);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.favorite, 'Favoritos', true, () {
                // Ya estamos en favoritos, no hacer nada
              }),
              _buildBottomNavItem(Icons.motorcycle, 'Delivery', false, () {
                Navigator.pushReplacementNamed(context, '/orders');
              }),
              _buildBottomNavItem(
                Icons.shopping_cart_outlined,
                'Carrito',
                false,
                () {
                  Navigator.pushReplacementNamed(context, '/cart');
                },
                badge: _cartItemCount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> product) {
    final productId = '${product['name']}_${product['price']}';
    final quantity = _productQuantities[productId] ?? 0;
    final showQuantityControls = quantity > 0;

    return Container(
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  product['image'],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.shopping_bag,
                      size: 50,
                      color: Colors.grey[400],
                    );
                  },
                ),
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
          const SizedBox(height: 3),
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
              const Icon(Icons.favorite, size: 22, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    IconData icon,
    String label,
    bool isSelected,
    VoidCallback onTap, {
    int? badge,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.grey[200],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 28,
            ),
            if (badge != null && badge > 0)
              Positioned(
                right: -8,
                top: -8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      '$badge',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
