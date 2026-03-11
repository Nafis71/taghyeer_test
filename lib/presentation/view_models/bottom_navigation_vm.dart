/// View model for managing bottom navigation bar state.
///
/// This class extends [GetxController] and handles the state of the bottom
/// navigation bar, including which tab is currently selected. It provides
/// reactive state management for tab switching.
///
/// Responsibilities:
/// - Track current navigation tab index
/// - Provide reactive updates when tab changes
/// - Manage tab selection state
///
/// The view model uses reactive programming with GetX observables to automatically
/// update the UI when the selected tab changes.
///
/// Tab indices:
/// - 0: Products tab
/// - 1: Posts tab
/// - 2: Settings tab
///
/// Example:
/// ```dart
/// final navVM = Get.find<BottomNavigationVM>();
/// navVM.setCurrentIndex = 1; // Switch to Posts tab
/// final currentTab = navVM.currentIndex;
/// ```
import 'package:get/get.dart';

class BottomNavigationVM extends GetxController {
  /// Reactive observable for current navigation tab index.
  ///
  /// Tracks which tab is currently selected in the bottom navigation bar.
  /// Defaults to 0 (first tab).
  ///
  /// The index corresponds to:
  /// - 0: Products
  /// - 1: Posts
  /// - 2: Settings
  final RxInt _currentIndex = 0.obs;

  /// Gets the current navigation tab index.
  ///
  /// Returns the currently selected tab index.
  ///
  /// Returns:
  /// - [int] representing the current tab index (0-2)
  ///
  /// Example:
  /// ```dart
  /// if (navVM.currentIndex == 0) {
  ///   // Products tab is selected
  /// }
  /// ```
  int get currentIndex => _currentIndex.value;

  /// Sets the current navigation tab index.
  ///
  /// Updates the selected tab and triggers reactive UI updates.
  /// The bottom navigation bar will automatically reflect the change.
  ///
  /// Parameters:
  /// - [index]: The tab index to select (0-2)
  ///
  /// Valid indices:
  /// - 0: Products tab
  /// - 1: Posts tab
  /// - 2: Settings tab
  ///
  /// Example:
  /// ```dart
  /// navVM.setCurrentIndex = 1; // Switch to Posts tab
  /// ```
  set setCurrentIndex(int index) => _currentIndex.value = index;
}