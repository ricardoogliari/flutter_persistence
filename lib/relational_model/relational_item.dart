class RelationalItem {
  int? id;
  final double quantity;
  final String description;
  final String receptor;

  RelationalItem({
    this.id,
    required this.quantity,
    required this.description,
    required this.receptor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'description': description,
      'receptor': receptor,
    };
  }
}