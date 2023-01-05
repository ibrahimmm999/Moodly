import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ConvertTime {
  String convertToAgo(Timestamp input) {
    Duration diff = DateTime.now().difference(input.toDate());

    if (diff.inDays > 0) {
      return DateFormat('dd-MM-yyyy').format(input.toDate()).toString();
    } else if (DateFormat('dd-MM-yyyy').format(input.toDate()) ==
        DateFormat('dd-MM-yyyy').format(DateTime.now())) {
      return DateFormat('Hm').format(input.toDate()).toString();
    } else {
      return 'Yesterday';
    }
  }
}
