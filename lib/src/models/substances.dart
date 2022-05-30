/// A (psychoactive) substance called [name].
class Substance {
  final String name;
  final Uri? wikiLink;

  Substance({required this.name, required String? wikiLink})
      : wikiLink = (wikiLink == null) ? null : Uri.parse(wikiLink);

  @override
  String toString() {
    return name;
  }

  static final Map<Substances, Substance> substances = {
    Substances.mdma: Substance(
      name: "MDMA",
      wikiLink: "https://psychonautwiki.org/wiki/MDMA",
    ),
    Substances.mda: Substance(
      name: "MDA",
      wikiLink: "https://psychonautwiki.org/wiki/MDA",
    ),
    Substances.fiveAPB: Substance(
      name: "5-APB",
      wikiLink: "https://psychonautwiki.org/wiki/5-APB",
    ),
    Substances.sixAPB: Substance(
      name: "6-APB",
      wikiLink: "https://psychonautwiki.org/wiki/6-APB",
    ),
    Substances.fiveMAPB: Substance(
      name: "5-MAPB",
      wikiLink: "https://psychonautwiki.org/wiki/5-MAPB",
    ),
    Substances.sixMAPB: Substance(
      name: "6-MAPB",
      wikiLink: null,
    ),
    Substances.methamphetamine: Substance(
      name: "Methamphetamine",
      wikiLink: "https://psychonautwiki.org/wiki/Methamphetamine",
    ),
    Substances.amphetamine: Substance(
      name: "Amphetamine",
      wikiLink: "https://psychonautwiki.org/wiki/Amphetamine",
    ),
    Substances.methylone: Substance(
      name: "Methylone",
      wikiLink: "https://psychonautwiki.org/wiki/Methylone",
    ),
    Substances.nEthylPentylone: Substance(
      name: "Ephylone",
      wikiLink: "https://psychonautwiki.org/wiki/Ephylone",
    ),
    Substances.mephedrone: Substance(
      name: "Mephedrone",
      wikiLink: "https://psychonautwiki.org/wiki/Mephedrone",
    ),
    Substances.alphaPVP: Substance(
      name: "A-PVP",
      wikiLink: "https://psychonautwiki.org/wiki/A-PVP",
    ),
    Substances.cocaine: Substance(
      name: "Cocaine",
      wikiLink: "https://psychonautwiki.org/wiki/Cocaine",
    ),
    Substances.ketamine: Substance(
      name: "Ketamine",
      wikiLink: "https://psychonautwiki.org/wiki/Ketamine",
    ),
    Substances.dck: Substance(
      name: "Deschloroketamine",
      wikiLink: "https://psychonautwiki.org/wiki/Deschloroketamine",
    ),
    Substances.twoFDCK: Substance(
      name: "2-Fluorodeschloroketamine",
      wikiLink: "https://psychonautwiki.org/wiki/2-Fluorodeschloroketamine",
    ),
    Substances.twoCB: Substance(
      name: "2C-B",
      wikiLink: "https://psychonautwiki.org/wiki/2C-B",
    ),
    Substances.twoCI: Substance(
      name: "2C-I",
      wikiLink: "https://psychonautwiki.org/wiki/2C-I",
    ),
    Substances.mescaline: Substance(
      name: "Mescaline",
      wikiLink: "https://psychonautwiki.org/wiki/Mescaline",
    ),
    Substances.lsd: Substance(
      name: "LSD",
      wikiLink: "https://psychonautwiki.org/wiki/LSD",
    ),
    Substances.bzp: Substance(
      name: "BZP",
      wikiLink: null,
    ),
    Substances.tfmpp: Substance(
      name: "TFMPP",
      wikiLink: null,
    ),
    Substances.pma: Substance(
      name: "PMA",
      wikiLink: "https://psychonautwiki.org/wiki/PMA",
    ),
    Substances.pmma: Substance(
      name: "PMMA",
      wikiLink: "https://psychonautwiki.org/wiki/PMMA",
    ),
    Substances.oxycodone: Substance(
      name: "Oxycodone",
      wikiLink: "https://psychonautwiki.org/wiki/Oxycodone",
    ),
    Substances.heroin: Substance(
      name: "Heroin",
      wikiLink: "https://psychonautwiki.org/wiki/Heroin",
    ),
    Substances.aspirin: Substance(
      name: "Aspirin",
      wikiLink: null,
    ),
    Substances.sugar: Substance(
      name: "Sugar",
      wikiLink: null,
    ),
  };
}

/// The different substances.
///
/// This enum is used to give each [Substance] object a unique id,
/// by which it can also be indexed in the list of all substances.
enum Substances {
  mdma,
  mda,
  fiveAPB,
  sixAPB,
  fiveMAPB,
  sixMAPB,
  methamphetamine,
  amphetamine,
  methylone,
  nEthylPentylone,
  mephedrone,
  alphaPVP,
  cocaine,
  ketamine,
  dck,
  twoFDCK,
  twoCB,
  twoCI,
  mescaline,
  lsd,
  bzp,
  tfmpp,
  pma,
  pmma,
  oxycodone,
  heroin,
  aspirin,
  sugar
}
