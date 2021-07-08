import 'package:flutter/material.dart';

/// labels
///
/// h stands for height
///
/// w stands for width
///
/// tr stands for tinier
///
/// t stands for tiny
///
/// n stands for normal
///
/// b stands for big
///
/// bg stands for bigger
class Spacing {
  //Sizes
  static get tinier => tiny / 2;
  static get tiny => normal / 2;
  static get normal => 16.0;
  static get big => normal * 2;
  static get bigger => normal * 3;

  /// tinier height
  static Widget get htr => SizedBox(height: tinier);

  /// tiny height
  static Widget get ht => SizedBox(height: tiny);

  /// normal height
  static Widget get hn => SizedBox(height: normal);

  /// big height
  static Widget get hb => SizedBox(height: big);

  /// bigger height
  static Widget get hbg => SizedBox(height: bigger);

  /// tinier width
  static Widget get wtr => SizedBox(width: tinier);

  /// tiny width
  static Widget get wt => SizedBox(width: tiny);

  /// normal width
  static Widget get wn => SizedBox(width: normal);

  /// big width
  static Widget get wb => SizedBox(width: big);

  /// bigger width
  static Widget get wbg => SizedBox(width: bigger);
}
