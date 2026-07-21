# Sticky Notes App 📝

A beautiful, light-weight, and persistent Sticky Notes application built with Flutter.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

---

## ✨ Features

- **Create Notes**: Quick and easy note creation dialog with multi-line text input.
- **Edit & Update**: Seamlessly edit existing sticky notes whenever your thoughts change.
- **Delete Notes**: Remove notes you no longer need with a single tap.
- **Vibrant Themes**: Color-coded pastel sticky note cards with shadow effects.
- **Local Persistence**: Notes are saved locally using `shared_preferences` so your data persists across app restarts.
- **Clean Empty State**: User-friendly empty state screen when no notes are available.

---

## 🛠️ Project Structure

```text
lib/
└── main.dart      # Main app entry point, Sticky Notes UI, and SharedPreferences storage logic
pubspec.yaml       # Project configuration & dependencies
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.0.0)
- Dart SDK

### Installation

1. Clone or download the repository:
   ```bash
   git clone <repository-url>
   cd notesapp
   ```

2. Fetch Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

## 📦 Main Dependencies

- [shared_preferences](https://pub.dev/packages/shared_preferences): Persistent local storage for sticky notes JSON data.
