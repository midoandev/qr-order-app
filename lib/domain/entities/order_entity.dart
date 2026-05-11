class OrderEntity {
  final int id;
  final String tableId;
  final String status; // pending, confirmed, preparing, ready, served
  final double totalPrice;
  final String? customerNote;
  final String? estimatedTime;

  OrderEntity({
    required this.id,
    required this.tableId,
    required this.status,
    required this.totalPrice,
    this.customerNote,
    this.estimatedTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          tableId == other.tableId &&
          status == other.status &&
          totalPrice == other.totalPrice &&
          customerNote == other.customerNote &&
          estimatedTime == other.estimatedTime;

  @override
  int get hashCode =>
      Object.hash(id, tableId, status, totalPrice, customerNote, estimatedTime);
}
