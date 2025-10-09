import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _cartItemCount = 3;
  Map<String, int> _cartQuantities = {
    'Coca Cola de 2L Descartable': 2,
    'Pollo Sofia': 1,
    'Manzana Roja': 1,
  };

  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Coca Cola de 2L\nDescartable',
      'pricePerUnit': 'Bs 18.00 c/u',
      'totalPrice': 'Bs 54.00',
      'image': 'assets/images/coca_cola.png',
      'id': 'Coca Cola de 2L Descartable',
    },
    {
      'name': 'Pollo Sofia',
      'pricePerUnit': 'Bs 23.00 x Kilo',
      'totalPrice': 'Bs 46.00',
      'image': 'assets/images/pollo.png',
      'id': 'Pollo Sofia',
    },
    {
      'name': 'Manzana Roja',
      'pricePerUnit': 'Bs 14.00 x Kilo',
      'totalPrice': 'Bs 28.00',
      'image': 'assets/images/manzana.png',
      'id': 'Manzana Roja',
    },
  ];

  final List<Map<String, dynamic>> suggestions = [
    {
      'name': 'Carne molida\nde segunda',
      'price': 'Bs. 53.10',
      'image': 'assets/images/carne_molida.png',
    },
    {
      'name': 'Jugo liquido\npara de 3lts',
      'price': 'Bs. 18.00',
      'image': 'assets/images/jugo.png',
    },
    {
      'name': 'Detergente en\npolvo todo\ncolor floral',
      'price': 'Bs. 21.70',
      'image': 'assets/images/detergente.png',
    },
  ];

  double get totalAmount {
    double total = 0.0;
    for (var item in cartItems) {
      String priceStr = item['totalPrice'].replaceAll('Bs ', '');
      total += double.parse(priceStr);
    }
    return total;
  }

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
        title: const Text(
          'Carrito',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        children: [
          // Lista de productos en el carrito
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return _buildCartItem(cartItems[index]);
              },
            ),
          ),
          // Sección inferior fija
          Container(
            color: Colors.white,
            child: Column(
              children: [
                // Botones de acción
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _cartQuantities.clear();
                              _cartItemCount = 0;
                            });
                          },
                          icon: const Icon(Icons.delete, size: 18),
                          label: const Text('Eliminar Todo'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Lógica de puntos de descuento
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Puntos de Descuentos\nGanados'),
                        ),
                      ),
                    ],
                  ),
                ),
                // Total
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  color: Colors.grey[200],
                  child: Text(
                    'Total: Bs ${totalAmount.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                // Sugerencias
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '¿Quieres algo mas?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                // Lista horizontal de sugerencias
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      return _buildSuggestionCard(suggestions[index]);
                    },
                  ),
                ),
                // Botón realizar compra
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Lógica para realizar compra
                        _showPurchaseDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Realizar Compra',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
              _buildBottomNavItem(
                Icons.favorite_border,
                'Favoritos',
                false,
                () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/favorites',
                    (route) => false,
                  );
                },
              ),
              _buildBottomNavItem(Icons.motorcycle, 'Delivery', false, () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/orders',
                  (route) => false,
                );
              }),
              _buildBottomNavItem(
                Icons.shopping_cart_outlined,
                'Carrito',
                true,
                () {
                  // Ya estamos en el carrito
                },
                badge: _cartItemCount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    final quantity = _cartQuantities[item['id']] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4E4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Imagen del producto
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item['image'],
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.shopping_bag,
                    size: 30,
                    color: Colors.grey[400],
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Información del producto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['pricePerUnit'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  item['totalPrice'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Controles de cantidad y eliminar
          Column(
            children: [
              // Controles de cantidad
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity > 0) {
                          _cartQuantities[item['id']] = quantity - 1;
                          if (_cartQuantities[item['id']] == 0) {
                            _cartQuantities.remove(item['id']);
                            _cartItemCount--;
                          }
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.remove_circle_outline,
                        size: 24,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _cartQuantities[item['id']] = quantity + 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.add_circle_outline,
                        size: 24,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Botón eliminar
              GestureDetector(
                onTap: () {
                  setState(() {
                    _cartQuantities.remove(item['id']);
                    _cartItemCount--;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(Map<String, dynamic> product) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4E4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              product['image'],
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.shopping_bag,
                  size: 30,
                  color: Colors.grey[400],
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product['price'],
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            product['name'],
            style: TextStyle(fontSize: 8, color: Colors.grey[800]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  // Agregar a carrito
                },
                child: const Icon(
                  Icons.add_circle_outline,
                  size: 16,
                  color: Colors.red,
                ),
              ),
              const Icon(Icons.favorite_border, size: 16, color: Colors.grey),
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

  void _showPurchaseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Realizar Compra'),
          content: Text(
            '¿Confirmar compra por un total de Bs ${totalAmount.toStringAsFixed(2)}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Compra Exitosa!'),
          content: const Text('Tu pedido ha sido procesado correctamente.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _cartQuantities.clear();
                  _cartItemCount = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
