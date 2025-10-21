class PointsService {
  // Singleton global - Asegura que solo exista una instancia de PointsService
  static final PointsService _instance = PointsService._internal();
  factory PointsService() => _instance;
  PointsService._internal();

  int _userPoints = 0; // Almacena los puntos actuales del usuario
  int get userPoints => _userPoints;/// Obtiene los puntos actuales del usuario

  /// Extrae los puntos desde el texto del precio.
  /// "price" es el precio en formato texto (ej: "Bs. 5.50")
  /// Retorna solo el número entero antes del punto decimal (ej: 5)
  /// Si no se encuentra un número válido, retorna 0.
  int calculatePointsFromPrice(String price) {
    final match = RegExp(r'\d+').firstMatch(price);
    if (match != null) {
      final value = int.tryParse(match.group(0) ?? '0') ?? 0;
      return value;
    }
    return 0;
  }

  /// "isAdding" determina si se suman (true) o restan (false) los puntos
  /// Actualiza los puntos del usuario basado en el precio. 
  /// Si se están restando puntos, nunca permitirá que el total sea negativo.
  void updatePoints(String price, {required bool isAdding}) {
    final points = calculatePointsFromPrice(price);
    if (isAdding) {
      _userPoints += points;
    } else {
      _userPoints = (_userPoints - points).clamp(0, double.infinity).toInt();
    }
  }

  /// Reinicia los puntos del usuario a 0.
  /// Útil cuando se completa una compra o se necesita resetear el contador.
  void reset() {
    _userPoints = 0;
  }
}
