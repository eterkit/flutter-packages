/// Extension that helps to get the element at the given index
/// or null if the index is out of bounds.
extension ListElementAtOrNull<T> on List<T> {
  /// Extension method that helps to get the element at the given index
  /// or null if the index is out of bounds.
  T? elementAtOrNull(int index) {
    try {
      return elementAt(index);
    } catch (e) {
      return null;
    }
  }
}
