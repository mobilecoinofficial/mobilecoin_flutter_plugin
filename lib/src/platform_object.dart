/// Represents a platform-side object, e.g., Android or iOS object, within
/// Flutter code.
abstract class PlatformObject {
  PlatformObject({required this.id});

  /// The hashcode of this object on the platform side, e.g., Android or iOS.
  final int id;
}
