import 'package:intl/intl.dart';

class DateTimeUtils {
  static final DateTimeUtils share = DateTimeUtils();

  static String displayTimeSocial(int timestamp) {
    final now = DateTime.now();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = now.difference(dateTime);

    // Nhỏ hơn 1 phút
    if (difference.inMinutes < 1) {
      return '${difference.inSeconds} giây trước';
    }

    // Từ 1 phút đến dưới 1 giờ
    if (difference.inHours < 1) {
      return '${difference.inMinutes} phút trước';
    }

    // Từ 1 giờ đến dưới 24 giờ
    if (difference.inDays < 1) {
      return '${difference.inHours} giờ trước';
    }

    // Từ 1 ngày đến dưới 30 ngày
    if (difference.inDays < 30) {
      return '${difference.inDays} ngày trước';
    }

    // Trên 30 ngày, hiển thị định dạng đầy đủ
    final DateFormat formatter = DateFormat('HH:mm dd-MM-yyyy');
    return formatter.format(dateTime);
  }
}
