import 'package:get/get.dart';

class BottomNavigationVM extends GetxController {
  final RxInt _currentIndex = 0.obs;

  /// Getter for current navigation tab index.
  ///
  /// Returns the currently selected tab index (0-3).
  int get currentIndex => _currentIndex.value;

  /// Setter for updating current navigation tab index.
  ///
  /// Updates the selected tab and triggers reactive UI updates.
  /// [index] The tab index to select (0-2).
  set setCurrentIndex(int index)=> _currentIndex.value = index;
}