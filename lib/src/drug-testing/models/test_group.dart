import 'package:safeonaut/src/drug-testing/models/reagent_test.dart';
import 'package:safeonaut/src/models/substances.dart';

/// A group of [tests] conducted with different reagents.
class TestGroup {
  String name;
  List<ReagentTest> tests;

  TestGroup({required this.name, this.tests = const []});

  Set<Substance> getResults() {
    Set<Substance> results = Substance.substances.values.toSet();

    for (var test in tests) {
      results = results.intersection(
        test.result
            .map((r) => test.reagent.reactions[r].substances)
            .reduce((subs1, subs2) => subs1.union(subs2)),
      );
    }

    return results;
  }
}
