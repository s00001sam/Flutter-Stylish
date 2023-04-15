import 'package:json_annotation/json_annotation.dart';

part 'Colors.g.dart';

@JsonSerializable()
class Colors {
  String? code;
  String? name;

  factory Colors.fromJson(Map<String, dynamic> json) => _$ColorsFromJson(json);

  Map<String, dynamic> toJson() => _$ColorsToJson(this);

  Colors({
    required this.code,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Colors &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          name == other.name);

  @override
  int get hashCode => code.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Colors{ code: $code, name: $name,}';
  }

  Colors copyWith({
    String? code,
    String? name,
  }) {
    return Colors(
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': this.code,
      'name': this.name,
    };
  }

  factory Colors.fromMap(Map<String, dynamic> map) {
    return Colors(
      code: map['code'] as String,
      name: map['name'] as String,
    );
  }
}
