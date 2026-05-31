import 'package:equatable/equatable.dart';
import 'package:mnb_mobile/app/modules/primary/data/model/json_parse.dart';

/// Mirrors the quotation payload (§10 of api.md).
class QuotationModel extends Equatable {
  final String id;
  final String projectRequestId;
  final String? scopeOfWork;
  final double offeredPrice;
  final int durationDays;
  final String status;

  const QuotationModel({
    required this.id,
    required this.projectRequestId,
    this.scopeOfWork,
    this.offeredPrice = 0,
    this.durationDays = 0,
    this.status = 'pending',
  });

  factory QuotationModel.fromJson(Map<String, dynamic> json) {
    return QuotationModel(
      id: asString(json['id']),
      projectRequestId: asString(json['project_request_id']),
      scopeOfWork: asStringOrNull(json['scope_of_work']),
      offeredPrice: asDouble(json['offered_price']),
      durationDays: asInt(json['duration_days']),
      status: asString(json['status'], fallback: 'pending'),
    );
  }

  @override
  List<Object?> get props =>
      [id, projectRequestId, scopeOfWork, offeredPrice, durationDays, status];
}

/// Mirrors `QuotationAcceptResponse` (§10.3 of api.md).
class QuotationAcceptModel extends Equatable {
  final String quotationId;
  final String orderId;
  final String status;

  const QuotationAcceptModel({
    required this.quotationId,
    required this.orderId,
    required this.status,
  });

  factory QuotationAcceptModel.fromJson(Map<String, dynamic> json) {
    return QuotationAcceptModel(
      quotationId: asString(json['quotation_id']),
      orderId: asString(json['order_id']),
      status: asString(json['status']),
    );
  }

  @override
  List<Object?> get props => [quotationId, orderId, status];
}
