import 'package:safeonaut/src/drug-testing/models/reagents/reagents.dart';

/// A single test conducted with a given [reagent].
///
/// [result] is the reaction (i. e., the color change) which has occured
/// as the index of possible reactions; if the user is unsure,
/// they can also choose multiple reactions.
class ReagentTest {
  final Reagent reagent;
  Set<int> result;

  ReagentTest({required this.reagent, this.result = const {}});
}

