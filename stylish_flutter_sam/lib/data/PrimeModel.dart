import 'package:json_annotation/json_annotation.dart';

part 'PrimeModel.g.dart';

@JsonSerializable()
class PrimeModel {
  String? status;
  String? message;
  String? prime;

  factory PrimeModel.fromJson(Map<String, dynamic> json) =>
      _$PrimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrimeModelToJson(this);

//<editor-fold desc="Data Methods">
  PrimeModel({
    this.status,
    this.message,
    this.prime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrimeModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          message == other.message &&
          prime == other.prime);

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ prime.hashCode;

  @override
  String toString() {
    return 'PrimeModel{ status: $status, message: $message, prime: $prime,}';
  }

  PrimeModel copyWith({
    String? status,
    String? message,
    String? prime,
  }) {
    return PrimeModel(
      status: status ?? this.status,
      message: message ?? this.message,
      prime: prime ?? this.prime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': this.status,
      'message': this.message,
      'prime': this.prime,
    };
  }

  factory PrimeModel.fromMap(Map<String, dynamic> map) {
    return PrimeModel(
      status: map['status'] as String,
      message: map['message'] as String,
      prime: map['prime'] as String,
    );
  }

//</editor-fold>
}
