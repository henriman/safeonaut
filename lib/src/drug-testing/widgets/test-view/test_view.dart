import 'package:flutter/material.dart';
import 'package:safeonaut/src/drug-testing/models/reagent_test.dart';
import 'package:safeonaut/src/drug-testing/models/reagents/reagents.dart';
import 'dart:async';

import 'package:safeonaut/src/drug-testing/models/test_group.dart';
import 'package:safeonaut/src/drug-testing/widgets/test-view/instructions_view.dart';

class TestViewArgument {
  final TestGroup testGroup;
  final Reagent reagent;

  const TestViewArgument({required this.testGroup, required this.reagent});
}

class TestView extends StatefulWidget {
  static const routeName = "/test";

  final TestGroup testGroup;
  final Reagent reagent;

  TestView({Key? key, required TestViewArgument args})
      : testGroup = args.testGroup,
        reagent = args.reagent,
        super(key: key);

  @override
  createState() => _TestViewState();
}

class _TestViewState extends State<TestView>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _seconds = 0;

  late final AnimationController _animationController;

  // Track which reactions the user selects.
  late final List<bool> selected;

  @override
  void initState() {
    super.initState();

    selected = List.filled(widget.reagent.reactions.length, false);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.reagent.end),
    )..addListener(() {
        setState(() {}); // Update the view.
      });

    // Show the instructions as soon as the test view is shown.
    Future.delayed(
      Duration.zero,
      _showInstructions,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();

    super.dispose();
  }

  // plain: reaction should still be in progress;
  // green: reaction should be done and results should be selected;
  // red: any changes from now should be ignored.
  Color _getColor() {
    return (_seconds >= widget.reagent.max)
        ? const Color(0xFFCC0000)
        : (_seconds >= widget.reagent.end)
            ? const Color(0xFF00CC00)
            : Theme.of(context).colorScheme.primary;
  }

  // Show the instructions in a pop-up dialog.
  void _showInstructions() {
    showDialog(
      context: context,
      // Disable dismissing the dialog by clicking outside of it.
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
          // Change the behavior of the on-screen back button;
          // instead of only popping the last view (the instructions),
          // also pop the test view.
          onWillPop: () async {
            Navigator.pop(context);
            Navigator.pop(context);
            // Return `false` so that the default behavior doesn't take place.
            return Future.value(false);
          },
          child: InstructionsView(
            reagent: widget.reagent,
            // When the user presses "done", start the timer and begin the animation.
            onDone: () {
              _timer ??= Timer.periodic(
                const Duration(seconds: 1),
                (_) {
                  setState(() {
                    _seconds++;
                  });
                },
              );
              _animationController.forward();
            },
          ),
        );
      },
    );
  }

  // TODO: offer restart?
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test with: ${widget.reagent.name}"),
        actions: [
          // Offer the user the ability to see the instructions again.
          IconButton(
            onPressed: _showInstructions,
            icon: const Icon(Icons.help),
          )
        ],
      ),
      body: Column(
        children: [
          // Bar at the top of the screen which shows the seconds of the reaction.
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}", // Format time.
                    style: TextStyle(
                      fontSize: 25,
                      color: _getColor(),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.timer, color: _getColor()),
                ],
              ),
              Text(
                (_seconds >= widget.reagent.max)
                    ? "Ignore any changes occuring from now own."
                    : (_seconds >= widget.reagent.end)
                        ? "The reaction should now have completed."
                        : "Please wait until the reaction has completed.",
                style: TextStyle(color: _getColor()),
              ),
            ]),
          ),
          // Show a list of all possible reactions.
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
              itemCount: widget.reagent.reactions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                  child: Row(
                    children: [
                      // The reaction gradient.
                      Expanded(
                        child: InkWell(
                          // Select this reaction also when clicking on the gradient.
                          onTap: () {
                            setState(() {
                              selected[index] = !selected[index];
                            });
                          },
                          // We stack two containers on top of each other;
                          // one serves as a background for the gradient,
                          // because this isn't always fully drawn.
                          child: Stack(
                            children: [
                              // Background container.
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(3),
                                  boxShadow: kElevationToShadow[2],
                                ),
                              ),
                              // Gradient.
                              LayoutBuilder(builder: (context, constraints) {
                                return widget.reagent.createWidgetOf(
                                    constraints.maxWidth, index,
                                    progress: _animationController.value);
                              }),
                            ],
                          ),
                        ),
                      ),
                      // Checkbox indicating whether this reaction is selected.
                      Checkbox(
                        value: selected[index],
                        activeColor: Theme.of(context).colorScheme.primary,
                        checkColor: Theme.of(context).colorScheme.onPrimary,
                        onChanged: (value) {
                          setState(() {
                            selected[index] = value!;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Bottom bar with some extra information and the button to go to the analysis.
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(3)),
              boxShadow: kElevationToShadow[2],
              color: Theme.of(context).colorScheme.background,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                    "Please choose which color change occured among the ones listed above. If you are unsure, you can also select multiple ones."),
                ElevatedButton.icon(
                  // Only activate the button if enough time has passed
                  // and at least one reaction was selected.
                  onPressed: (selected.asMap().values.every((b) => !b) ||
                          _seconds < widget.reagent.end)
                      ? null
                      : () {
                          widget.testGroup.tests.add(
                            ReagentTest(
                              reagent: widget.reagent,
                              result: selected
                                  .asMap()
                                  .entries
                                  .where((entry) => entry.value)
                                  .map((entry) => entry.key)
                                  .toSet(),
                            ),
                          );
                          Navigator.popUntil(
                            context,
                            (route) => route.settings.name == "/detail",
                          );
                        },
                  // Give the user information on why the button might be disabled.
                  icon: (_seconds < widget.reagent.end)
                      ? const Text(
                          "Please wait until the reaction has finished.")
                      : (selected.asMap().values.every((b) => !b))
                          ? const Text("Please select at least one reaction.")
                          : const Text("I have selected all that apply"),
                  label: (_seconds < widget.reagent.end)
                      ? const Icon(Icons.hourglass_empty)
                      : (selected.asMap().values.every((b) => !b))
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
