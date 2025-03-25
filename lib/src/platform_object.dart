// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

/// Represents a platform-side object, e.g., Android or iOS object, within
/// Flutter code.
abstract class PlatformObject {
  const PlatformObject({required this.id});

  /// The hashcode of this object on the platform side, e.g., Android or iOS.
  final int id;
}
