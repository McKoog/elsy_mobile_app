parseSettingsSting(String value) {
  final splitSize = 1;
  RegExp exp = new RegExp(r"\d{" + "$splitSize" + "}");
  Iterable<Match> matches = exp.allMatches(value);
  var list = matches.map((m) => int.tryParse(m.group(0)!));
  return list;
}
