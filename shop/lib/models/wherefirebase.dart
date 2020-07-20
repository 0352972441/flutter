class FBWhere {
  static String whereTo(String token, String orderBy, String equalTo) {
    //print("?auth=$token&orderBy=\"$orderBy\"&equaTo=\"$equalTo\"");
    return "?auth=$token&orderBy=\"$orderBy\"&equalTo=\"$equalTo\"";
  }
}
