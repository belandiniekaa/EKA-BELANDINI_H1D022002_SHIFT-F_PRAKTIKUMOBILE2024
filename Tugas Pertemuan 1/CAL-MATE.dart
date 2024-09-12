// Import libraries
import 'dart:async';
import 'package:intl/intl.dart'; // Untuk format tanggal

// Exception jika bulan atau tahun tidak valid
class InvalidDateException implements Exception {
  String errorMessage() => 'Oops! The month or year you entered is invalid.';
}

// Class CalendarMate untuk menampilkan kalender
class CalendarMate {
  // Fungsi untuk memvalidasi input tahun dan bulan
  bool validateYearAndMonth(int year, int month) {
    return (year > 0 && month >= 1 && month <= 12);
  }

  // Fungsi untuk menampilkan kalender
  Future<void> displayCalendar(int year, int month) async {
    if (!validateYearAndMonth(year, month)) {
      throw InvalidDateException();
    }

    // Nama bulan
    String monthName = DateFormat.MMMM().format(DateTime(year, month));

    print('\nThis is the monthly calendar you want!');
    print('\n              $monthName $year');
    print('Mo  Tu   We  Th   Fr   Sa   Su');

    // Dapatkan hari pertama dari bulan dan tahun yang diberikan
    DateTime firstDayOfMonth = DateTime(year, month, 1);

    // Dapatkan jumlah hari dalam bulan
    int daysInMonth = daysInGivenMonth(year, month);

    // Hitung offset untuk hari pertama dalam seminggu
    int startDay = firstDayOfMonth.weekday; // 1 = Monday, 7 = Sunday

    // Array untuk menyimpan kalender, diisi dengan hari dalam bulan
    List<String> days = List.filled(42, '  '); // Array untuk menampung kalender (maksimum 6 minggu)

    // Mengisi hari-hari dalam kalender
    for (int i = 0; i < daysInMonth; i++) {
      days[startDay + i - 1] = (i + 1).toString().padLeft(2, '  '); // Lebar tetap 2 spasi
    }

    // Iterasi untuk menampilkan kalender per minggu
    for (int i = 0; i < 42; i += 7) {
      print(days.sublist(i, i + 7).map((day) => day.isEmpty ? '    ' : day).join('   ')); // Print setiap minggu
    }

    // Simulasi delay dengan async/await
    await performAsyncTask();
  }

  // Fungsi untuk menghitung jumlah hari dalam bulan
  int daysInGivenMonth(int year, int month) {
    return (month == 12)
        ? DateTime(year + 1, 1, 0).day
        : DateTime(year, month + 1, 0).day;
  }
}

// Fungsi async untuk menunda tugas asinkron
Future<void> performAsyncTask() async {
  await Future.delayed(Duration(seconds: 1));
  print('Thank you for using Cal-Mate, I\'ll be waiting for you again!');
}

// Fungsi utama untuk menjalankan program
void main() async {
  print('Welcome to CAL-MATE! ^^');
  print(
      'Your best-mate to display the monthly calendar easily. Just select the month and year, then CAL-MATE will display a calendar with a clear and organized display.');

  // Tidak menggunakan input user, gunakan contoh tahun dan bulan
  int year = 2024;
  int month = 7;

  print('\nEnter the year you want: $year');
  print('Enter the month in number: $month');

  CalendarMate calMate = CalendarMate();

  try {
    // Memulai proses dengan async
    await calMate.displayCalendar(year, month);
  } catch (e) {
    if (e is InvalidDateException) {
      print(e.errorMessage());
    }
  }
}
