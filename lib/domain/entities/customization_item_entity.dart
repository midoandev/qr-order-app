class CustomizationItemEntity {
  final int optionId;
  final int quantity;

  CustomizationItemEntity({
    required this.optionId,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CustomizationItemEntity &&
              runtimeType == other.runtimeType && optionId == other.optionId &&
              quantity == other.quantity;

  @override
  int get hashCode => Object.hash(optionId, quantity);


}
