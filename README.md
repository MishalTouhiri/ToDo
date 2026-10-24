# TodoMonth

A Flutter app for planning a month one week at a time.

**Live demo:** https://mishaltouhiri.github.io/ToDo/

![Flutter](https://img.shields.io/badge/Flutter-Dart-02569B?logo=flutter&logoColor=white) ![Material 3](https://img.shields.io/badge/Material-3-6750A4) ![Arabic & English](https://img.shields.io/badge/i18n-Arabic%20%26%20English-0f766e)

| English | العربية | Empty week |
|:---:|:---:|:---:|
| <img src="docs/screenshots/en-tasks.webp" width="240" alt="Tasks in English"> | <img src="docs/screenshots/ar-tasks.webp" width="240" alt="المهام بالعربي"> | <img src="docs/screenshots/en-empty.webp" width="240" alt="Empty week"> |

## Features

- Four week tabs per month, each showing its dates and how many tasks are done
- Monthly progress ring across all weeks
- Add and rename tasks from a bottom sheet; tick to complete
- Delete from the task menu or by swiping, with Undo
- Move between months; every month keeps its own plan
- Tasks are saved on the device (`shared_preferences`)
- Material 3 with light and dark themes
- English and Arabic (right to left), following the device language

## Tech stack

Flutter · Dart · Material 3 · `shared_preferences` · `flutter_localizations` · widget tests · GitHub Actions → GitHub Pages

## Run

```bash
flutter pub get
flutter run          # or: flutter run -d chrome
flutter test
```
