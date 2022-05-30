import "package:flutter/material.dart";
import 'package:safeonaut/src/models/substances.dart';
import 'package:safeonaut/src/drug-testing/models/reagents/reaction.dart';
import 'package:safeonaut/src/drug-testing/models/reagents/instructions.dart';

// TODO: make all models serializable so that updates can be send through json

/// A list of all reagents.
final Map<Reagents, Reagent> reagents = {
  Reagents.marquis: Reagent(
    name: "Marquis",
    instructions: instructions[Instructions.oneReagent]!,
    reactions: [
      SpecificReaction(
        substanceIDs: {
          Substances.mdma,
          Substances.mda,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: const Color(0xFFFFFFFF), seconds: 0),
          ColorChange(color: const Color(0xFF774C8F), seconds: 5),
          ColorChange(color: const Color(0xFF000000), seconds: 15),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.fiveAPB,
          Substances.sixAPB,
          Substances.fiveMAPB,
          Substances.sixMAPB,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: Colors.black, seconds: 5),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.methamphetamine,
          Substances.amphetamine,
          Substances.mescaline,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFE56D27), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.methylone,
          Substances.nEthylPentylone,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFE0E445), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.twoCB,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFE9E626), seconds: 5),
          ColorChange(color: const Color(0xFF10522F), seconds: 20)
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.twoCI,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFD5E267), seconds: 5),
          ColorChange(color: const Color(0xFF95CB8C), seconds: 10),
          ColorChange(color: const Color(0xFF254378), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.oxycodone,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFC9B5D2), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.heroin,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: const Color(0xFFAD97AD), seconds: 0),
          ColorChange(color: const Color(0xFF78375A), seconds: 5),
          ColorChange(color: const Color(0xFF901B24), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.aspirin,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFCAC1DF), seconds: 5),
          ColorChange(color: const Color(0xFFEC2731), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.sugar,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFE9EC92), seconds: 10),
          ColorChange(color: Colors.black, seconds: 20),
        ],
      ),
      NoReaction(
        substanceIDs: {
          Substances.mephedrone,
          Substances.alphaPVP,
          Substances.cocaine,
          Substances.ketamine,
          Substances.bzp,
          Substances.pma,
          Substances.pmma,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
      ),
      OtherReaction(
        substanceIDs: {
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
      ),
    ],
    end: 20,
    max: 60,
  ),
  Reagents.ehrlichs: Reagent(
    name: "Ehrlich's",
    instructions: instructions[Instructions.oneReagent]!,
    reactions: [
      SpecificReaction(
        substanceIDs: {
          Substances.lsd,
          Substances.dck,
          Substances.twoFDCK,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFAA536D), seconds: 150),
          ColorChange(color: const Color(0xFF76326A), seconds: 300)
        ],
      ),
      NoReaction(
        substanceIDs: Substance.substances.keys
            .where((key) => key != Substances.lsd)
            .toSet(),
      ),
      OtherReaction(
        substanceIDs: {
          Substances.dck,
          Substances.twoFDCK,
        },
      ),
    ],
    end: 300,
    max: 600,
  ),
  Reagents.liebermann: Reagent(
    name: "Liebermann",
    instructions: instructions[Instructions.oneReagent]!,
    reactions: [
      SpecificReaction(
        substanceIDs: {
          Substances.mdma,
          Substances.mda,
          Substances.fiveAPB,
          Substances.sixAPB,
          Substances.fiveMAPB,
          Substances.sixMAPB,
          Substances.heroin,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: Colors.black, seconds: 5),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.methamphetamine,
          Substances.amphetamine,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFE56D27), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.methylone,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFF65703B), seconds: 5),
          ColorChange(color: Colors.black, seconds: 10),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.mephedrone,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFEFEA2E), seconds: 10),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.alphaPVP,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFE3E178), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.cocaine,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFF4EE42), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.ketamine,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFF2F2D0), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.twoCB,
          Substances.mescaline,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFF1F2019), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.bzp,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFD1C72C), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.pma,
          Substances.pmma,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFF453153), seconds: 10),
          ColorChange(color: const Color(0xFF685126), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.aspirin,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFAE6928), seconds: 20),
        ],
      ),
      SpecificReaction(
        substanceIDs: {
          Substances.sugar,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
        colorChanges: [
          ColorChange(color: Colors.white, seconds: 0),
          ColorChange(color: const Color(0xFFACA2B4), seconds: 20),
        ],
      ),
      NoReaction(
        substanceIDs: {
          Substances.nEthylPentylone,
          Substances.twoCI,
          Substances.tfmpp,
          Substances.oxycodone,
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
      ),
      OtherReaction(
        substanceIDs: {
          Substances.dck,
          Substances.twoFDCK,
          Substances.lsd,
        },
      ),
    ],
    end: 20,
    max: 60,
  ),
};

/// The different reagents.
///
/// This enum is used to give each [Reagent] object a unique id,
/// by which it can also be indexed in the list of all reagents.
enum Reagents {
  marquis,
  simons,
  froehde,
  liebermann,
  morris,
  ehrlichs,
  mandelin,
  mecke,
  folin
}

// TODO: is id needed?
/// A reagent called [name] to test for specific drugs.
///
/// Depending on the substance the reagent is applied to,
/// one of the specified [reactions] will occur.
class Reagent {
  final String name;
  final List<Instruction> instructions;
  final List<Reaction> reactions;
  final int end;
  final int max;

  Reagent({
    required this.name,
    required this.instructions,
    required this.reactions,
    required this.end,
    required this.max,
  });

  Widget createWidgetOf(double maxWidth, int index, {double progress = 1.0}) {
    return reactions[index].reactionWidget(maxWidth, end, progress);
  }
}
