enum CustomIcon { flagIconEN, flagIconTR }

String getPath(CustomIcon country) {
  return 'assets/icons/${country.name}.png';
}
