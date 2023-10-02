import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz/core/const.dart';

IconData getIconMapping(Categories category) {
  switch (category) {
    case Categories.science:
      return Icons.science;
    case Categories.history:
      return Icons.history;
    case Categories.music:
      return Icons.music_note;

    default:
      return Icons.place;
  }
}
