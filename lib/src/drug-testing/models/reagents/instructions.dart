class Instruction {
  final String title;
  final String imagePath;
  final String description;

  const Instruction({
    required this.title,
    required this.imagePath,
    required this.description,
  });
}

enum Instructions {
  oneReagent,
  twoReagents,
}

// TODO: add instruction regarding time
const Map<Instructions, List<Instruction>> instructions = {
  Instructions.oneReagent: [
    Instruction(
      title: "Gather all supplies",
      imagePath: "assets/instructions/step1.png",
      description: """Gather all necessary supplies. This includes
1. a **ceramic plate** as depicted above (or a ceramic mug if you don\'t have such a plate at hand),
2. the **substance you want to test** together with a **tool with which you are able to gather
a small amount of your substance** and place it on the ceramic plate (or in the mug),
3. the **reagent** you want to use: **<reagent>**.""",
    ),
    Instruction(
      title: "Add a sample",
      imagePath: "assets/instructions/step2.png",
      description:
          """Use your tool to **gather a small sample** of your substance
and place it on the ceramic plate (or in the mug).""",
    ),
    Instruction(
      title: "Check your sample size",
      imagePath: "assets/instructions/step3.png",
      description: """Make sure that your sample **isn't too big**.
You shouldn't use more than **half a pinhead** of your substance.""",
    ),
    Instruction(
      title: "Add your reagent",
      imagePath: "assets/instructions/step4.png",
      description: """Add **one drop** of your substance onto your sample.
Make sure that the dropper bottle with your reagent doesn't touch your sample
as that will contaminate and ruin the reagent.""",
    ),
  ],
};
