import 'package:flutter/material.dart';

import "package:flutter_markdown/flutter_markdown.dart";

import 'package:safeonaut/src/drug-testing/models/reagents/reagents.dart';

class InstructionsView extends StatefulWidget {
  final Reagent reagent;
  final Function onDone;

  const InstructionsView({
    Key? key,
    required this.reagent,
    required this.onDone,
  }) : super(key: key);

  @override
  createState() => _InstructionsViewState();
}

class _InstructionsViewState extends State<InstructionsView> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _page = 0; // Keep track of current page.

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Show the actual instructions.
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.reagent.instructions.length,
            itemBuilder: (context, index) {
              final instruction = widget.reagent.instructions[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(2, 80, 2, 0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Show the instruction.
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title.
                            Text(
                              instruction.title,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            // Image representation.
                            Image(image: AssetImage(instruction.imagePath)),
                            const SizedBox(height: 10),
                            // Instruction description.
                            MarkdownBody(
                              data: instruction.description
                                  .replaceAll("<reagent>", widget.reagent.name),
                              styleSheet: MarkdownStyleSheet.fromTheme(
                                      Theme.of(context))
                                  .copyWith(
                                      textAlign: WrapAlignment.spaceBetween),
                            ),
                          ],
                        ),
                        // Show navigation buttons.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Move to previous page; don't show when on the first page.
                            (index == 0)
                                ? Container()
                                : TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _page--;
                                        _pageController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 350),
                                          curve: Curves.easeOut,
                                        );
                                      });
                                    },
                                    child: const Icon(Icons.arrow_back_ios),
                                  ),
                            // Move to next page; if on the last page, show the done button.
                            (index == widget.reagent.instructions.length - 1)
                                ? ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      widget.onDone();
                                    },
                                    child: const Text("Done"),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _page++;
                                        _pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 350),
                                            curve: Curves.easeOut);
                                      });
                                    },
                                    child: const Icon(Icons.arrow_forward_ios),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Show button to cancel or skip the instructions.
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Cancel button.
              TextButton(
                // To cancel, pop twice; first the instructions, then the test screen.
                onPressed: () async {
                  // TODO: not so elegant; solve with named route for pop up?
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Skip button; only show when not on the last page already.
              (_page == widget.reagent.instructions.length - 1)
                  ? Container()
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          // Jump to the last page.
                          _page = widget.reagent.instructions.length - 1;
                          _pageController.animateToPage(
                              widget.reagent.instructions.length - 1,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.fastLinearToSlowEaseIn);
                        });
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
