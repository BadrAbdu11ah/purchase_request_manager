import 'package:purchase_request_manager/core/class/state_request.dart';

StateRequest handlingData(dynamic response) {
  if (response is StateRequest) {
    return response;
  }
  return StateRequest.success;
}
