class RestaurantEntity {
  final String id;
  final String name;
  final String tableId;

  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.tableId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          tableId == other.tableId;

  @override
  int get hashCode => Object.hash(id, name, tableId);
}