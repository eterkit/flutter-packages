/// Helper extension to convert `bool` to `int`.
extension BoolToNumberExtension on bool {
  /// Integer representation of `this` `bool`.
  int get number => this == true ? 1 : 0;
}
