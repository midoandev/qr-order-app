class CustomizationOptionEntity {
  final int id;
  final String name;
  final double priceModifier;

  CustomizationOptionEntity({
    required this.id,
    required this.name,
    required this.priceModifier,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomizationOptionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          priceModifier == other.priceModifier;

  @override
  int get hashCode => Object.hash(id, name, priceModifier);
}