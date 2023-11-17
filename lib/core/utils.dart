import 'package:flutter/material.dart';

String kModuloImage(int index, {int padding = 8}) {
  final int evaluatedIndex = index + padding;

  if (evaluatedIndex % 8 == 0) {
    return "assets/images/party8.png";
  }
  if (evaluatedIndex % 8 == 1) {
    return "assets/images/party7.png";
  }
  if (evaluatedIndex % 8 == 2) {
    return "assets/images/party6.png";
  }
  if (evaluatedIndex % 8 == 3) {
    return "assets/images/party5.png";
  }
  if (evaluatedIndex % 8 == 4) {
    return "assets/images/party4.png";
  }
  if (evaluatedIndex % 8 == 5) {
    return "assets/images/party3.png";
  }
  if (evaluatedIndex % 8 == 6) {
    return "assets/images/party2.png";
  }
  if (evaluatedIndex % 8 == 7) {
    return "assets/images/party1.png";
  }

  return "assets/images/party1.png";
}

Color kModuloBackgroundColor(BuildContext context, int index, {int padding = 1}) {
  final int evaluatedIndex = index + padding;

  if (evaluatedIndex % 3 == 0) {
    return Theme.of(context).colorScheme.secondaryContainer;
  }
  if (evaluatedIndex % 3 == 1) {
    return Theme.of(context).colorScheme.tertiaryContainer;
  }
  if (evaluatedIndex % 3 == 2) {
    return Theme.of(context).colorScheme.primaryContainer;
  }

  return Theme.of(context).colorScheme.primaryContainer;
}

Color kModuloColor(BuildContext context, int index, {int padding = 1}) {
  final int evaluatedIndex = index + padding;

  if (evaluatedIndex % 3 == 0) {
    return Theme.of(context).colorScheme.secondary;
  }
  if (evaluatedIndex % 3 == 1) {
    return Theme.of(context).colorScheme.tertiary;
  }
  if (evaluatedIndex % 3 == 2) {
    return Theme.of(context).colorScheme.primary;
  }

  return Theme.of(context).colorScheme.primary;
}

Color kModuloTextContainerColor(BuildContext context, int index, {int padding = 1}) {
  final int evaluatedIndex = index + padding;

  if (evaluatedIndex % 3 == 0) {
    return Theme.of(context).colorScheme.onSecondaryContainer;
  }
  if (evaluatedIndex % 3 == 1) {
    return Theme.of(context).colorScheme.onTertiaryContainer;
  }
  if (evaluatedIndex % 3 == 2) {
    return Theme.of(context).colorScheme.onPrimaryContainer;
  }

  return Theme.of(context).colorScheme.onPrimaryContainer;
}

Color kModuloTextColor(BuildContext context, int index, {int padding = 1}) {
  final int evaluatedIndex = index + padding;

  if (evaluatedIndex % 3 == 0) {
    return Theme.of(context).colorScheme.onSecondary;
  }
  if (evaluatedIndex % 3 == 1) {
    return Theme.of(context).colorScheme.onTertiary;
  }
  if (evaluatedIndex % 3 == 2) {
    return Theme.of(context).colorScheme.onPrimary;
  }

  return Theme.of(context).colorScheme.onPrimary;
}
