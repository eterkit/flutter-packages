/// Base class for various HealthValue classes.
sealed class HealthValue<T> {
  /// Actual value content.
  T get value;

  /// Creates json representation of this object.
  Map<String, dynamic> toJson();
}

/// Health value with numeric value content.
class NumericHealthValue implements HealthValue {
  /// Default constructor for [NumericHealthValue]
  const NumericHealthValue(this.value);

  /// Creates [NumericHealthValue] from [json].
  factory NumericHealthValue.fromJson(Map<String, dynamic> json) {
    return NumericHealthValue(json['value'] as double);
  }

  @override
  final double value;

  @override
  Map<String, dynamic> toJson() => {
        'value': value,
      };
}
