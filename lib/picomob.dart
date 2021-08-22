import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';

/// Indivisible units of MOB coins.
@immutable
class PicoMob {
  /// PicoMob from a coin fraction, e.g., 243.1543
  PicoMob.fromMobFraction(double coins) : _picoMobs = BigInt.from(coins * 1e12);

  /// PicoMob from a coin fraction as a `String`, e.g., "243.1543"
  PicoMob.fromMobFractionString(String coins)
      : _picoMobs = BigInt.parse(
            (Decimal.parse(coins) * Decimal.parse('1e12')).toString());

  /// PicoMob from a pico count value, i.e., the smallest unit of MOB.
  ///
  /// 1 pico MOB = 0.000_000_000_001 MOB
  PicoMob.fromPicoInt(int picoMobs) : _picoMobs = BigInt.from(picoMobs);

  /// PicoMob from a pico count value represented as a `BigInt`.
  ///
  /// 1 pico MOB = 0.000_000_000_001 MOB
  const PicoMob.fromPicoBigInt(this._picoMobs);

  final BigInt _picoMobs;

  /// Add `other` `PicoMob` to this `PicoMob` and returns the result.
  PicoMob operator +(PicoMob other) {
    return PicoMob.fromPicoBigInt(_picoMobs + other._picoMobs);
  }

  /// Subtracts `other` `PicoMob` from this `PicoMob` and returns the result.
  PicoMob operator -(PicoMob other) {
    return PicoMob.fromPicoBigInt(_picoMobs - other._picoMobs);
  }

  /// Multiplies `this` `PicoMob` by the `other` `PicoMob` and returns the result.
  PicoMob operator *(PicoMob other) {
    return PicoMob.fromPicoBigInt(_picoMobs * other._picoMobs);
  }

  /// Returns the number of pico MOBs as a `BigInt`.
  BigInt picoCountAsBigInt() => _picoMobs;

  /// Returns the number of pico MOBs as a `String`.
  String picoCountAsString() => _picoMobs.toString();

  /// Returns the fractional number of MOB as a `double`.
  double mobFractionAsDouble() => _picoMobs.toDouble() / 1e12;

  /// Returns the fractional number of MOB as a `String`.
  String mobFractionAsString() => (_picoMobs.toDouble() / 1e12).toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PicoMob &&
          runtimeType == other.runtimeType &&
          _picoMobs == other._picoMobs;

  @override
  int get hashCode => _picoMobs.hashCode;
}
