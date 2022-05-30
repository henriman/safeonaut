import 'package:flutter/material.dart';
import 'package:safeonaut/src/models/substances.dart';

abstract class Reaction {
  Set<Substance> substances;
  Widget reactionWidget(double maxWidth, int totalSeconds, double progress);

  Reaction({
    required Set<Substances> substanceIDs,
  }) : substances =
            substanceIDs.map((key) => Substance.substances[key]!,).toSet();
}

// TODO: add no reaction, unknown and inconsistent
// i. e. no reaction and "other" for unknown and inconsistent"
/// The [colorChanges] occuring when a given reagent is applied to one of the [substances].
class SpecificReaction extends Reaction {
  final List<ColorChange> colorChanges;

  SpecificReaction({
    required Set<Substances> substanceIDs,
    required this.colorChanges,
  }) : super(substanceIDs: substanceIDs);

  @override
  Widget reactionWidget(double maxWidth, int totalSeconds, double progress) {
    return Container(
      width: maxWidth * progress,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        boxShadow: kElevationToShadow[2],
        gradient: _createGradient(totalSeconds, progress),
      ),
    );
  }

  LinearGradient _createGradient(int totalSeconds, double progress) {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment((progress == 0) ? 1 : 1 / progress, 0),
      stops: colorChanges.map((cc) => cc.seconds / totalSeconds).toList(),
      colors: colorChanges.map((cc) => cc.color).toList(),
    );
  }
}

class NoReaction extends Reaction {
  NoReaction({required Set<Substances> substanceIDs})
      : super(substanceIDs: substanceIDs);

  @override
  Widget reactionWidget(double maxWidth, int totalSeconds, double progress) {
    return Container(
      width: maxWidth,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        boxShadow: kElevationToShadow[2],
        color: Colors.grey[400],
      ),
      child: const Text(
        "NO REACTION",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class OtherReaction extends Reaction {
  OtherReaction({required Set<Substances> substanceIDs})
      : super(substanceIDs: substanceIDs);

  @override
  Widget reactionWidget(double maxWidth, int totalSeconds, double progress) {
    return Container(
      width: maxWidth,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        boxShadow: kElevationToShadow[2],
        color: Colors.grey[400],
      ),
      child: const Text(
        "OTHER",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

/// The color change of the reagent which occurs after a given amount of time.
///
/// After [seconds], the reagent changes to [color].
class ColorChange {
  final Color color;
  final int seconds;

  ColorChange({required this.color, required this.seconds});
}
