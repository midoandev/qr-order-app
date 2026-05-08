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
}
