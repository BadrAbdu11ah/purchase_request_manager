import 'package:purchase_request_manager/model/order/order_model.dart';

class PaginatedOrders {
  final List<OrderModel> orders;
  final int currentPage;
  final int lastPage;
  final int total;

  PaginatedOrders({
    required this.orders,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });
}
