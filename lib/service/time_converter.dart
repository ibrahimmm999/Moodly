import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ConvertTime {
  String convertToAgo(Timestamp input) {
    Duration diff = DateTime.now().difference(input.toDate());

    if (diff.inDays >= 1) {
      if (diff.inDays > 7) {
        return (DateFormat('dd MMMM yyyy').format(input.toDate())).toString();
      } else {
        return '${diff.inDays} days ago';
      }
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} seconds ago';
    } else {
      return 'just now';
    }
  }
}
