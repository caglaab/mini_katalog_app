/// 2499.0 -> "$2,499"
String formatPrice(double value) {
  final digits = value.toStringAsFixed(0);
  final buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[i]);
  }
  return '\$${buffer.toString()}';
}
