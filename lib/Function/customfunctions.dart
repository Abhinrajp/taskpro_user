class Customfunctions {
  double ratingfunction(String currentrating, String totalwork) {
    double rating = double.parse(currentrating);
    var works = double.parse(totalwork);
    var totalworks = works * 5;
    var totalrating = (rating / totalworks) * 5;
    return totalrating;
  }
}
