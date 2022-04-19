import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final Widget logoPicture = SvgPicture.asset(
  "assets/logo.svg",
  semanticsLabel: 'Acme Logo',
  height: 150,
  width: 150,
  color: Colors.white,
);
