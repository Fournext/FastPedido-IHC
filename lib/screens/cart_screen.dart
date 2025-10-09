import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<String, int> _cartQuantities = {};

  // Variables para manejar las sugerencias
  Set<String> _favoriteSuggestions = {};
  Map<String, int> _suggestionQuantities = {};

  List<Map<String, dynamic>> cartItems = [];

  // Calculamos dinámicamente el número de items en el carrito
  int get _cartItemCount {
    return _cartQuantities.values.fold(0, (sum, quantity) => sum + quantity);
  }

  final List<Map<String, dynamic>> suggestions = [
    {
      'name': 'Carne molida\nde segunda',
      'price': 'Bs. 53.10',
      'image': 'assets/images/carne_molida.png',
    },
    {
      'name': 'Jugo Aquarius Pera 3 L',
      'price': 'Bs. 20.00',
      'image': 'assets/images/aquario.png',
    },
    {
      'name': 'Detergente Polvo Omo Limon 1800 gr',
      'price': 'Bs. 59.90',
      'image': 'assets/images/detergente.png',
    },
  ];

  double get totalAmount {
    double total = 0.0;

    // Calcular total de productos en el carrito principal
    for (var item in cartItems) {
      final quantity = _cartQuantities[item['id']] ?? 0;
      if (quantity > 0) {
        // Extraer el precio unitario del campo pricePerUnit
        double unitPrice = _extractPrice(item['pricePerUnit']);
        total += unitPrice * quantity;
      }
    }

    return total;
  }

  // Función para extraer el precio numérico de un string con formato "Bs. XX.XX"
  double _extractPrice(String priceString) {
    // Buscar números con punto decimal
    RegExp regExp = RegExp(r'\d+\.?\d*');
    Match? match = regExp.firstMatch(priceString);
    if (match != null) {
      String numberStr = match.group(0)!;
      return double.tryParse(numberStr) ?? 0.0;
    }
    return 0.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Procesar productos enviados desde el dashboard
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments['dashboardProducts'] != null) {
      _addDashboardProducts(
        arguments['dashboardProducts'] as List<Map<String, dynamic>>,
      );
    }
  }

  void _addDashboardProducts(List<Map<String, dynamic>> dashboardProducts) {
    for (var product in dashboardProducts) {
      final productId = product['id'];
      final quantity = (product['quantity'] ?? 0) as int;

      if (quantity > 0) {
        // Verificar si el producto ya existe en el carrito
        bool productExists = cartItems.any((item) => item['id'] == productId);

        if (productExists) {
          // Si existe, actualizar la cantidad y recalcular el precio total
          int newQuantity = (_cartQuantities[productId] ?? 0) + quantity;
          _cartQuantities[productId] = newQuantity;

          // Recalcular el precio total del producto existente
          var existingItem = cartItems.firstWhere(
            (item) => item['id'] == productId,
          );
          double unitPrice = _extractPrice(existingItem['pricePerUnit']);
          existingItem['totalPrice'] =
              'Bs. ${(unitPrice * newQuantity).toStringAsFixed(2)}';
        } else {
          // Si no existe, agregar el producto al carrito
          cartItems.add({
            'name': product['name'],
            'pricePerUnit': product['pricePerUnit'],
            'totalPrice': product['totalPrice'],
            'image': product['image'],
            'id': productId,
          });
          _cartQuantities[productId] = quantity;
        }
      }
    }
    setState(() {});
  }

  void _transferSuggestionToCart(
    Map<String, dynamic> product,
    String productId,
    int quantity,
  ) {
    // Calcular el precio unitario y total
    double unitPrice = _extractPrice(product['price']);

    // Verificar si el producto ya existe en el carrito
    bool productExists = cartItems.any((item) => item['id'] == productId);

    if (productExists) {
      // Si existe, actualizar la cantidad
      int newQuantity = (_cartQuantities[productId] ?? 0) + quantity;
      _cartQuantities[productId] = newQuantity;

      // Actualizar el totalPrice del producto existente
      var existingItem = cartItems.firstWhere(
        (item) => item['id'] == productId,
      );
      existingItem['totalPrice'] =
          'Bs. ${(unitPrice * newQuantity).toStringAsFixed(2)}';
    } else {
      // Si no existe, agregar el producto al carrito
      cartItems.add({
        'name': product['name'],
        'pricePerUnit': product['price'],
        'totalPrice': 'Bs. ${(unitPrice * quantity).toStringAsFixed(2)}',
        'image': product['image'],
        'id': productId,
      });
      _cartQuantities[productId] = quantity;
    }

    setState(() {});
  }

  void _updateCartItemQuantity(String productId, int newQuantity) {
    // Encontrar el producto en el carrito y actualizar su cantidad y precio total
    var cartItem = cartItems.firstWhere((item) => item['id'] == productId);
    _cartQuantities[productId] = newQuantity;

    // Recalcular el precio total
    double unitPrice = _extractPrice(cartItem['pricePerUnit']);
    cartItem['totalPrice'] =
        'Bs. ${(unitPrice * newQuantity).toStringAsFixed(2)}';
  }

  void _removeFromCart(String productId) {
    _cartQuantities.remove(productId);
    cartItems.removeWhere((item) => item['id'] == productId);
    _suggestionQuantities.remove(productId); // También limpiar de sugerencias
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
            child: cartItems.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Tu carrito está vacío',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Agrega productos para comenzar',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
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
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _cartQuantities.clear();
                              cartItems.clear();
                              _suggestionQuantities
                                  .clear(); // Limpiar también las sugerencias
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Text(
                            'Puntos de Descuentos\nGanados',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Total
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 2),
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
                  height: 180,
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
                      onPressed: cartItems.isEmpty
                          ? null
                          : () {
                              // Lógica para realizar compra
                              _showPurchaseDialog();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cartItems.isEmpty
                            ? Colors.grey
                            : Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        cartItems.isEmpty ? 'Carrito Vacío' : 'Realizar Compra',
                        style: const TextStyle(
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
                  Navigator.pushReplacementNamed(context, '/favorites');
                },
              ),
              _buildBottomNavItem(Icons.motorcycle, 'Delivery', false, () {
                Navigator.pushReplacementNamed(context, '/orders');
              }),
              _buildBottomNavItem(
                Icons.shopping_cart_outlined,
                'Carrito',
                true,
                () {
                  // Ya estamos en el carrito
                },
                badge: _cartItemCount > 0 ? _cartItemCount : null,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
      child: Row(
        children: [
          // Imagen del producto (más grande y centrada)
          Container(
            width: 90, // antes 60
            height: 90, // antes 60
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item['image'],
                fit: BoxFit.cover,
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
                        if (quantity > 1) {
                          int newQuantity = quantity - 1;
                          _cartQuantities[item['id']] = newQuantity;
                          // Recalcular el precio total
                          double unitPrice = _extractPrice(
                            item['pricePerUnit'],
                          );
                          item['totalPrice'] =
                              'Bs. ${(unitPrice * newQuantity).toStringAsFixed(2)}';
                        } else {
                          // Si la cantidad es 1, eliminar el producto del carrito
                          String productId = item['id'];
                          _cartQuantities.remove(productId);
                          cartItems.removeWhere(
                            (cartItem) => cartItem['id'] == productId,
                          );
                          _suggestionQuantities.remove(
                            productId,
                          ); // También limpiar de sugerencias
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
                        int newQuantity = quantity + 1;
                        _cartQuantities[item['id']] = newQuantity;
                        // Recalcular el precio total
                        double unitPrice = _extractPrice(item['pricePerUnit']);
                        item['totalPrice'] =
                            'Bs. ${(unitPrice * newQuantity).toStringAsFixed(2)}';
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
                    String productId = item['id'];
                    _cartQuantities.remove(productId);
                    cartItems.removeWhere(
                      (cartItem) => cartItem['id'] == productId,
                    );
                    _suggestionQuantities.remove(
                      productId,
                    ); // También limpiar de sugerencias
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
    final productId = '${product['name']}_${product['price']}';
    final isFavorite = _favoriteSuggestions.contains(productId);
    final quantity = _suggestionQuantities[productId] ?? 0;
    final showQuantityControls = quantity > 0;

    return Container(
      width: 145,
      margin: const EdgeInsets.only(right: 10),
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
                fit: BoxFit.cover, // llena toda la tarjeta
                width: double.infinity,
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
                            int newQuantity = quantity - 1;
                            if (newQuantity > 0) {
                              _suggestionQuantities[productId] = newQuantity;
                              // Actualizar en el carrito principal
                              _updateCartItemQuantity(productId, newQuantity);
                            } else {
                              _suggestionQuantities.remove(productId);
                              // Eliminar del carrito principal
                              _removeFromCart(productId);
                            }
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
                          int newQuantity = quantity + 1;
                          _suggestionQuantities[productId] = newQuantity;
                          // Actualizar en el carrito principal
                          _updateCartItemQuantity(productId, newQuantity);
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
                      _suggestionQuantities[productId] = 1;
                    });
                    // Transferir inmediatamente al carrito principal
                    _transferSuggestionToCart(product, productId, 1);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product['name']} agregado al carrito'),
                        duration: const Duration(seconds: 1),
                        backgroundColor: Colors.green,
                      ),
                    );
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
                      _favoriteSuggestions.remove(productId);
                    } else {
                      _favoriteSuggestions.add(productId);
                    }
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? '${product['name']} eliminado de favoritos'
                            : '${product['name']} agregado a favoritos',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
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
                    color: Color(
                      0xFFFF9800,
                    ), // Color naranja/amarillo como en la imagen
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
                Navigator.pushNamed(
                  context,
                  '/delivery-date',
                  arguments: {'totalAmount': totalAmount},
                );
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
}
