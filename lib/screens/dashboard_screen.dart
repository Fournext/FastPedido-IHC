import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _selectedCategory;
  int _cartItemCount = 2;
  Set<String> _favoriteProducts = {};
  Map<String, int> _productQuantities = {};

  final List<Map<String, dynamic>> categories = [
    {'name': 'Verduras', 'image': 'assets/images/categoria/verduras.png'},
    {'name': 'Carnes', 'image': 'assets/images/categoria/carnes.png'},
    {'name': 'Lácteos', 'image': 'assets/images/categoria/lacteos.png'},
  ];

  final Map<String, List<Map<String, dynamic>>> productsByCategory = {
    'Verduras': [
      {
        'name': 'Lechuga',
        'price': 'Bs. 8.50',
        'image': 'assets/images/lechuga.png',
      },
      {
        'name': 'Tomate',
        'price': 'Bs. 6.00',
        'image': 'assets/images/tomate.png',
      },
      {
        'name': 'Zanahoria',
        'price': 'Bs. 5.50',
        'image': 'assets/images/zanahoria.png',
      },
      {
        'name': 'Cebolla',
        'price': 'Bs. 4.00',
        'image': 'assets/images/cebolla.png',
      },
    ],
    'Carnes': [
      {
        'name': 'Carne Molida de Primera',
        'price': 'Bs. 82.00',
        'image': 'assets/images/carnes/carnemolida.png',
      },
      {
        'name': 'Filete de Pechuga Sofia 1 kg Bandeja',
        'price': 'Bs. 56.90',
        'image': 'assets/images/carnes/filete_pollo_1kg.png',
      },
      {
        'name': 'Picaña Frigor al Vacio kg',
        'price': 'Bs. 166.00',
        'image': 'assets/images/carnes/picaña_frigor.png',
      },
      {
        'name': 'Pollo Frial Entero Sofia kg',
        'price': 'Bs. 24.90',
        'image': 'assets/images/carnes/pollo_frial.png',
      },
      {
        'name': 'Silpancho kg',
        'price': 'Bs. 66.00',
        'image': 'assets/images/carnes/silpancho_procesado.png',
      },
      {
        'name': 'Milanesa de Pollo kg',
        'price': 'Bs. 66.00',
        'image': 'assets/images/carnes/milanesa.png',
      },
    ],
    'Lácteos': [
      {
        'name': 'Nueva Leche Pil Deslactosada 800 ml',
        'price': 'Bs. 9.90',
        'image': 'assets/images/lacteos/leche_delactosada_pil.png',
      },
      {
        'name': 'Mantequilla Pil Con Sal 200 gr',
        'price': 'Bs. 24.50',
        'image': 'assets/images/lacteos/mamtequilla_pil_conSal_200gr.png',
      },
      {
        'name': 'Dulce de Leche Pil 500 gr',
        'price': 'Bs. 25.00',
        'image': 'assets/images/lacteos/dulce_leche_pil.png',
      },
      {
        'name': 'Yogurt Pil Bebible Frutilla 1 L',
        'price': 'Bs. 16.90',
        'image': 'assets/images/lacteos/yogurt_bebible_1lt.png',
      },
      {
        'name': 'Yogurt Griego Delizia Sabor Fresa 170 gr',
        'price': 'Bs. 9.30',
        'image': 'assets/images/lacteos/yogurt_griego.png',
      },
      {
        'name': 'Queso San German Yapacani un',
        'price': 'Bs. 75.00',
        'image': 'assets/images/lacteos/queso_yapacani.png',
      },
    ],
  };

  final List<Map<String, dynamic>> offers = [
    {
      'name': 'Carne molida\nde segunda',
      'price': 'Bs. 53.10',
      'image': 'assets/images/carne_molida.png',
    },
    {
      'name': 'Cereal Nestle\nChocapic\n250gr',
      'price': 'Bs. 46.80',
      'image': 'assets/images/cereal.png',
    },
    {
      'name': 'Gaseosa\nCoca Cola de\n3lt',
      'price': 'Bs. 18.00',
      'image': 'assets/images/coca_cola.png',
    },
  ];

  final List<Map<String, dynamic>> recommended = [
    {
      'name': 'Cerveza\nPaceña Lata\n269 ml CBX',
      'price': 'Bs. 7.40',
      'image': 'assets/images/cerveza.png',
    },
    {
      'name': 'Cereales\nLucky Charms',
      'price': 'Bs. 69.00',
      'image': 'assets/images/lucky_charms.png',
    },
    {
      'name': 'Nutella',
      'price': 'Bs. 176.00',
      'image': 'assets/images/nutella.png',
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
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 45,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.delivery_dining,
                    color: Colors.white,
                    size: 24,
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
            const Text(
              'FastPedido',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: TextDecoration.underline,
                decorationColor: Colors.red,
                decorationThickness: 2.5,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de búsqueda
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar por marca, cate...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 13,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[400],
                            size: 22,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Puntos de Compra',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Sección de Categorías
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: const Text(
                'Categoría',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 115,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = _selectedCategory == category['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = isSelected
                            ? null
                            : category['name'];
                      });
                    },
                    child: Container(
                      width: 95,
                      margin: const EdgeInsets.only(right: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.red
                                    : Colors.grey.shade300,
                                width: isSelected ? 3 : 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Padding(
                                padding: const EdgeInsets.all(4), // antes 12
                                child: Image.asset(
                                  category['image'],
                                  fit: BoxFit.cover, // cambia a cover
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category['name'],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: isSelected ? Colors.red : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // Mostrar productos de categoría seleccionada o las secciones normales
            if (_selectedCategory != null)
              _buildCategoryProducts()
            else ...[
              // Sección de Ofertas
              _buildSectionHeader('Ofertas', () {}),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: offers.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(offers[index]);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Sección de Recomendados
              _buildSectionHeader('Recomendados', () {}),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: recommended.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(recommended[index]);
                  },
                ),
              ),
            ],

            const SizedBox(height: 80),
          ],
        ),
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
              _buildBottomNavItem(Icons.favorite_border, 'Favoritos', () {
                Navigator.pushNamed(context, '/favorites');
              }),
              _buildBottomNavItem(Icons.motorcycle, 'Delivery', () {
                Navigator.pushNamed(context, '/orders');
              }),
              _buildBottomNavItem(Icons.shopping_cart_outlined, 'Carrito', () {
                Navigator.pushNamed(context, '/cart');
              }, badge: _cartItemCount),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryProducts() {
    final products = productsByCategory[_selectedCategory] ?? [];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedCategory!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildProductCard(products[index], fullWidth: true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: Row(
              children: [
                Text(
                  'Ver todos',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 16, color: Colors.grey[600]),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
                fit: BoxFit.cover, // llena todo el espacio
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
          // Sección inferior: cantidad o carrito + corazón
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
              // Corazón siempre a la derecha
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

  Widget _buildBottomNavItem(
    IconData icon,
    String label,
    VoidCallback onTap, {
    int? badge,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
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
            Icon(icon, color: Colors.grey[600], size: 28),
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
