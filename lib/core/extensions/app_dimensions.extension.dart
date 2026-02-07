import 'package:flutter/material.dart';

extension AppDimensionsExtension on BuildContext {
  /// General Padding
  EdgeInsets get padding4 => const EdgeInsets.all(4.0);
  EdgeInsets get padding8 => const EdgeInsets.all(8.0);
  EdgeInsets get padding16 => const EdgeInsets.all(16.0);
  EdgeInsets get padding24 => const EdgeInsets.all(24.0);
  EdgeInsets get padding32 => const EdgeInsets.all(32.0);

  /// Symmetric Padding
  EdgeInsets get paddingHorizontal4 =>
      const EdgeInsets.symmetric(horizontal: 4.0);
  EdgeInsets get paddingHorizontal8 =>
      const EdgeInsets.symmetric(horizontal: 8.0);
  EdgeInsets get paddingHorizontal16 =>
      const EdgeInsets.symmetric(horizontal: 16.0);

  EdgeInsets get paddingVertical4 => const EdgeInsets.symmetric(vertical: 4.0);
  EdgeInsets get paddingVertical8 => const EdgeInsets.symmetric(vertical: 8.0);
  EdgeInsets get paddingVertical16 =>
      const EdgeInsets.symmetric(vertical: 16.0);
  EdgeInsets get paddingH16V8 =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  /// Padding for each side
  EdgeInsets get paddingTop4 => const EdgeInsets.only(top: 4.0);
  EdgeInsets get paddingTop8 => const EdgeInsets.only(top: 8.0);
  EdgeInsets get paddingTop16 => const EdgeInsets.only(top: 16.0);

  EdgeInsets get paddingBottom4 => const EdgeInsets.only(bottom: 4.0);
  EdgeInsets get paddingBottom8 => const EdgeInsets.only(bottom: 8.0);
  EdgeInsets get paddingBottom16 => const EdgeInsets.only(bottom: 16.0);

  EdgeInsets get paddingLeft4 => const EdgeInsets.only(left: 4.0);
  EdgeInsets get paddingLeft8 => const EdgeInsets.only(left: 8.0);
  EdgeInsets get paddingLeft16 => const EdgeInsets.only(left: 16.0);

  EdgeInsets get paddingRight4 => const EdgeInsets.only(right: 4.0);
  EdgeInsets get paddingRight8 => const EdgeInsets.only(right: 8.0);
  EdgeInsets get paddingRight16 => const EdgeInsets.only(right: 16.0);

  EdgeInsets get noteCardPadding => const EdgeInsets.all(20);
  EdgeInsets get tasksPerDayCardHeaderPadding =>
      const EdgeInsets.only(top: 8.0, right: 16, left: 16);

  BorderRadiusGeometry get radius24 => BorderRadiusGeometry.circular(24);
  BorderRadiusGeometry get radius16 => BorderRadiusGeometry.circular(16);
  BorderRadiusGeometry get radius12 => BorderRadiusGeometry.circular(12);
  BorderRadiusGeometry get radius4 => BorderRadiusGeometry.circular(4);
  BorderRadiusGeometry get radius8 => BorderRadiusGeometry.circular(8);
}
