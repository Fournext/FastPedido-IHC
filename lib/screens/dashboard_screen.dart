import 'package:flutter/material.dart';
import 'package:fast_pedido/screens/Recommended_screen.dart';
import 'offers_screen.dart';
import 'package:fast_pedido/widgets/bottom_menu.dart';
import 'package:fast_pedido/widgets/product_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _selectedCategory;
  Set<String> _favoriteProducts = {};
  Map<String, int> _productQuantities = {};
  int _userPoints = 0; // Puntos del usuario

  // Calculamos dinámicamente el número de items en el carrito
  int get _cartItemCount {
    return _productQuantities.values.fold(0, (sum, quantity) => sum + quantity);
  }

  // Método para calcular puntos basado en el precio del producto
  int _calculatePointsForProduct(String price) {
    final priceMatch = RegExp(r'\d+').firstMatch(price);
    if (priceMatch != null) {
      final matchedString = priceMatch.group(0) ?? '0';
      final points = int.tryParse(matchedString) ?? 1;
      return points; // Solo la parte entera
    }
    return 1; // Punto mínimo si no se puede calcular
  }

  // Método para actualizar puntos cuando se agrega/quita un producto
  void _updatePoints(String productPrice, bool isAdding) {
    final points = _calculatePointsForProduct(productPrice);
    setState(() {
      if (isAdding) {
        _userPoints += points;
      } else {
        _userPoints = (_userPoints - points).clamp(0, double.infinity).toInt();
      }
    });
  }

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
        'image': 'assets/images/verduras/lechuga.jpg',
      },
      {
        'name': 'Tomate',
        'price': 'Bs. 6.00',
        'image': 'assets/images/verduras/tomate.png',
      },
      {
        'name': 'Zanahoria',
        'price': 'Bs. 5.50',
        'image': 'assets/images/verduras/zanahoria.png',
      },
      {
        'name': 'Cebolla',
        'price': 'Bs. 4.00',
        'image': 'assets/images/verduras/cebolla.png',
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
      'originalPrice': 'Bs. 65.00',
      'discount': '18%',
      'image': 'assets/images/ofertas/carnemolidasegunda.png',
    },
    {
      'name': 'Cereal Nestle\nChocapic\n250gr',
      'price': 'Bs. 46.80',
      'originalPrice': 'Bs. 58.50',
      'discount': '20%',
      'image': 'assets/images/ofertas/chocapic.png',
    },
    {
      'name': 'Gaseosa\nCoca Cola de\n3lt',
      'price': 'Bs. 18.00',
      'originalPrice': 'Bs. 22.50',
      'discount': '20%',
      'image': 'assets/images/ofertas/cocacola3l.png',
    },
  ];

  final List<Map<String, dynamic>> recommended = [
    {
      'name': 'Cerveza\nPaceña Lata\n269 ml CBX',
      'price': 'Bs. 7.40',
      'image': 'assets/images/recomendacion/cerveza.png',
    },
    {
      'name': 'Cereales\nLucky Charms',
      'price': 'Bs. 69.00',
      'image': 'assets/images/recomendacion/cereales.png',
    },
    {
      'name': 'Nutella',
      'price': 'Bs. 176.00',
      'image': 'assets/images/recomendacion/nutella.png',
    },

    {
      'name': 'Gaseosa Coca Cola Clasica Pack 6 un 300 ml',
      'price': 'Bs. 19.00',
      'image': 'assets/images/recomendacion/coca_pack.png',
    },
    {
      'name': 'Gaseosa Coca Cola Original Two Pack 3 L',
      'price': 'Bs. 38.00',
      'image': 'assets/images/recomendacion/coca_3lt.png',
    },
    {
      'name': 'Whisky Johnnie Walker Black Label 1 L',
      'price': 'Bs. 670.00',
      'image': 'assets/images/recomendacion/wisky.png',
    },

    {
      'name': 'Whisky Johnnie Walker Swing 750 ml',
      'price': 'Bs. 885.00',
      'image': 'assets/images/recomendacion/wiskyW.png',
    },
    {
      'name': 'Hamburguesa Hipermaxi Carne 6 un',
      'price': 'Bs. 31.90',
      'image': 'assets/images/recomendacion/hamburguesa.png',
    },
    {
      'name': 'Helado Delizia Chocolate 1 L',
      'price': 'Bs. 26.50',
      'image': 'assets/images/recomendacion/helado.png',
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
                      border: Border.all(color: Colors.grey[300]!, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.stars, color: Colors.grey[600], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '$_userPoints pts',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
              _buildSectionHeader('Ofertas', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OffersScreen()),
                );
              }),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: offers.length,
                  itemBuilder: (context, index) {
                    final product = offers[index];
                    final productId = '${product['name']}_${product['price']}';
                    final isFavorite = _favoriteProducts.contains(productId);
                    final quantity = _productQuantities[productId] ?? 0;

                    return ProductCard(
                      product: product,
                      fullWidth: false,
                      quantity: quantity,
                      isFavorite: isFavorite,
                      onAdd: () {
                        setState(() {
                          _productQuantities[productId] = quantity + 1;
                        });
                        _updatePoints(product['price'], true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product['name']} agregado al carrito',
                            ),
                            duration: const Duration(seconds: 1),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      onRemove: () {
                        setState(() {
                          if (quantity > 1) {
                            _productQuantities[productId] = quantity - 1;
                          } else {
                            _productQuantities.remove(productId);
                          }
                        });
                        _updatePoints(product['price'], false);
                      },
                      onToggleFavorite: () {
                        setState(() {
                          if (isFavorite) {
                            _favoriteProducts.remove(productId);
                          } else {
                            _favoriteProducts.add(productId);
                          }
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Sección de Recomendados
              _buildSectionHeader('Recomendados', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecommendedScreen(
                      title: 'Recomendados',
                      products: recommended, // le pasas la lista completa
                    ),
                  ),
                );
              }),
              const SizedBox(height: 12),
              // 🔽 Solo mostramos una vista previa de 6 productos
              Builder(
                builder: (context) {
                  final recommendedPreview = recommended.take(6).toList();
                  return SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: recommendedPreview.length,
                      itemBuilder: (context, index) {
                        final product = recommendedPreview[index];
                        final productId =
                            '${product['name']}_${product['price']}';
                        final isFavorite = _favoriteProducts.contains(
                          productId,
                        );
                        final quantity = _productQuantities[productId] ?? 0;

                        return ProductCard(
                          product: product,
                          fullWidth: false,
                          quantity: quantity,
                          isFavorite: isFavorite,
                          onAdd: () {
                            setState(() {
                              _productQuantities[productId] = quantity + 1;
                            });
                            _updatePoints(product['price'], true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product['name']} agregado al carrito',
                                ),
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          onRemove: () {
                            setState(() {
                              if (quantity > 1) {
                                _productQuantities[productId] = quantity - 1;
                              } else {
                                _productQuantities.remove(productId);
                              }
                            });
                            _updatePoints(product['price'], false);
                          },
                          onToggleFavorite: () {
                            setState(() {
                              if (isFavorite) {
                                _favoriteProducts.remove(productId);
                              } else {
                                _favoriteProducts.add(productId);
                              }
                            });
                          },
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],

            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(
        cartBadge: _cartItemCount > 0 ? _cartItemCount : null,
        onFavorites: () {
          List<Map<String, dynamic>> dashboardFavoritesToSend = [];
          _collectFavoriteProducts(offers, dashboardFavoritesToSend);
          _collectFavoriteProducts(recommended, dashboardFavoritesToSend);

          if (_selectedCategory != null) {
            final products = productsByCategory[_selectedCategory] ?? [];
            _collectFavoriteProducts(products, dashboardFavoritesToSend);
          }

          Navigator.pushNamed(
            context,
            '/favorites',
            arguments: {
              'dashboardFavorites': _favoriteProducts.toList(),
              'dashboardFavoriteProducts': dashboardFavoritesToSend,
            },
          );
        },
        onDelivery: () => Navigator.pushNamed(context, '/orders'),
        onCart: () => _navigateToCart(),
        onProfile: () => Navigator.pushNamed(context, '/profile'),
        selected: '',
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

  // ProductCard widget handles product presentation; local builder removed.

  Widget _buildCategoryProducts() {
    final categoryName = _selectedCategory ?? '';
    final products = productsByCategory[_selectedCategory] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(
            categoryName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final productId = '${product['name']}_${product['price']}';
              final isFavorite = _favoriteProducts.contains(productId);
              final quantity = _productQuantities[productId] ?? 0;

              return ProductCard(
                product: product,
                fullWidth: false,
                quantity: quantity,
                isFavorite: isFavorite,
                onAdd: () {
                  setState(() {
                    _productQuantities[productId] = quantity + 1;
                  });
                  _updatePoints(product['price'], true);
                },
                onRemove: () {
                  setState(() {
                    if (quantity > 1) {
                      _productQuantities[productId] = quantity - 1;
                    } else {
                      _productQuantities.remove(productId);
                    }
                  });
                  _updatePoints(product['price'], false);
                },
                onToggleFavorite: () {
                  setState(() {
                    if (isFavorite) {
                      _favoriteProducts.remove(productId);
                    } else {
                      _favoriteProducts.add(productId);
                    }
                  });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _navigateToCart() {
    // Preparar los productos del dashboard para enviar al carrito
    List<Map<String, dynamic>> dashboardProducts = [];
    List<Map<String, dynamic>> dashboardFavoritesToSend = [];

    // Recopilar productos favoritos del dashboard con sus datos completos
    _collectFavoriteProducts(offers, dashboardFavoritesToSend);
    _collectFavoriteProducts(recommended, dashboardFavoritesToSend);

    if (_selectedCategory != null) {
      final products = productsByCategory[_selectedCategory] ?? [];
      _collectFavoriteProducts(products, dashboardFavoritesToSend);
    }

    // Revisar ofertas con cantidades
    for (var offer in offers) {
      final productId = '${offer['name']}_${offer['price']}';
      final quantity = _productQuantities[productId] ?? 0;
      if (quantity > 0) {
        dashboardProducts.add({
          'name': offer['name'],
          'pricePerUnit': offer['price'],
          'totalPrice': offer['price'], // Se calculará en el carrito
          'image': offer['image'],
          'id': productId,
          'quantity': quantity,
        });
      }
    }

    // Revisar recomendados con cantidades
    for (var recommended in recommended) {
      final productId = '${recommended['name']}_${recommended['price']}';
      final quantity = _productQuantities[productId] ?? 0;
      if (quantity > 0) {
        dashboardProducts.add({
          'name': recommended['name'],
          'pricePerUnit': recommended['price'],
          'totalPrice': recommended['price'], // Se calculará en el carrito
          'image': recommended['image'],
          'id': productId,
          'quantity': quantity,
        });
      }
    }

    // Revisar productos de categorías con cantidades
    if (_selectedCategory != null) {
      final products = productsByCategory[_selectedCategory] ?? [];
      for (var product in products) {
        final productId = '${product['name']}_${product['price']}';
        final quantity = _productQuantities[productId] ?? 0;
        if (quantity > 0) {
          dashboardProducts.add({
            'name': product['name'],
            'pricePerUnit': product['price'],
            'totalPrice': product['price'], // Se calculará en el carrito
            'image': product['image'],
            'id': productId,
            'quantity': quantity,
          });
        }
      }
    }

    // Navegar al carrito con los productos
    Navigator.pushNamed(
      context,
      '/cart',
      arguments: {
        'dashboardProducts': dashboardProducts,
        'dashboardFavoriteProducts': dashboardFavoritesToSend,
        'currentPoints': _userPoints, // Enviar puntos actuales
      },
    );

    // Limpiar las cantidades del dashboard después de enviar al carrito
    setState(() {
      _productQuantities.clear();
    });
  }

  void _collectFavoriteProducts(
    List<Map<String, dynamic>> productList,
    List<Map<String, dynamic>> favoritesToSend,
  ) {
    for (var product in productList) {
      final productId = '${product['name']}_${product['price']}';
      if (_favoriteProducts.contains(productId)) {
        favoritesToSend.add({
          'name': product['name'],
          'price': product['price'],
          'image': product['image'],
          'id': productId,
        });
      }
    }
  }
}
