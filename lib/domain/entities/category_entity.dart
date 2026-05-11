class CategoryEntity {
  final int id;
  final String name;
  final int sortOrder;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.sortOrder,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          sortOrder == other.sortOrder;

  @override
  int get hashCode => Object.hash(id, name, sortOrder);
}