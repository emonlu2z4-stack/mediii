# MediCare — Flutter App (VS Code Ready)

A complete healthcare mobile app built with Flutter + Dart, designed to open and run directly in **VS Code**.

---

## Prerequisites

Install these before opening the project:

| Tool | Download |
|------|----------|
| Flutter SDK (stable) | https://flutter.dev/docs/get-started/install |
| VS Code | https://code.visualstudio.com |
| Dart extension | VS Code → Extensions → search "Dart" |
| Flutter extension | VS Code → Extensions → search "Flutter" |

Verify your Flutter installation:
```bash
flutter doctor
```
All items should show a green checkmark (except optionally Xcode if you're not building for iOS).

---

## Step 1 — Open in VS Code

```bash
# Extract the archive first
tar -xzf medicare_flutter.tar.gz
cd medicare_flutter

# Open in VS Code
code .
```

VS Code will automatically detect the Flutter project and activate the Dart/Flutter extensions.

---

## Step 2 — Add the Doctor Images

Copy these image files from the Expo project into `assets/images/`:

| File | Doctor |
|------|--------|
| `doctor1.png` | Dr. James Wilson |
| `doctor2.png` | Dr. Priya Sharma |
| `doctor3.png` | Dr. Michael Lee |
| `doctor4.png` | Dr. Emily Carter |
| `doctor5.png` | Dr. Sarah Chen |
| `appointment_doctor.png` | Appointment banner |
| `user_avatar.png` | User profile photo |

These are already available in the Replit project at:
`artifacts/medicare/assets/images/`

> If images are missing the app will still run — it shows a placeholder icon instead.

---

## Step 3 — Install dependencies

Open the VS Code terminal (`Ctrl+`` ` or `View → Terminal`) and run:

```bash
flutter pub get
```

---

## Step 4 — Generate platform folders (first time only)

Flutter needs platform-specific folders to run. Generate them with:

```bash
# For Android + iOS + Web
flutter create --platforms android,ios,web .

# Or just web (fastest, no Xcode/Android Studio needed)
flutter create --platforms web .
```

> This only generates the platform folders and does **not** overwrite your `lib/` code.

---

## Step 5 — Run the app

### Option A: Run on Web (easiest, no device needed)
```bash
flutter run -d chrome
```

### Option B: Run on Android emulator
1. Open Android Studio → Device Manager → Create/Start an emulator
2. Back in VS Code terminal:
```bash
flutter run
```

### Option C: Run on iOS simulator (macOS only)
```bash
open -a Simulator
flutter run
```

### Option D: Run on a physical device
Connect your phone via USB and enable USB debugging, then:
```bash
flutter run
```

### Option E: Use VS Code debugger
- Press `F5` or go to **Run → Start Debugging**
- Select a device from the status bar at the bottom of VS Code
- The app will launch with hot-reload enabled

---

## Hot Reload & Hot Restart

While the app is running:
- **Hot Reload**: Press `r` in the terminal (or `Ctrl+S` to save any file)
- **Hot Restart**: Press `R` in the terminal
- **Stop**: Press `q` or `Ctrl+C`

---

## Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (macOS only)
flutter build ios --release

# Web
flutter build web --release
```

---

## Project Structure

```
medicare_flutter/
├── .vscode/
│   ├── launch.json          ← Debug run configurations
│   ├── settings.json        ← VS Code editor settings
│   └── extensions.json      ← Recommended extensions
├── lib/
│   ├── main.dart            ← App entry point
│   ├── theme/
│   │   └── app_theme.dart   ← Colors & Material theme (Inter font via Google Fonts)
│   ├── models/
│   │   ├── doctor.dart
│   │   ├── appointment.dart
│   │   ├── message.dart
│   │   └── user.dart
│   ├── providers/
│   │   └── app_provider.dart  ← All state management (Provider)
│   ├── screens/
│   │   ├── main_navigation.dart  ← Bottom tab navigator
│   │   ├── home_screen.dart
│   │   ├── doctors_screen.dart
│   │   ├── appointments_screen.dart
│   │   ├── messages_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── doctor_detail_screen.dart
│   │   └── chat_screen.dart
│   └── widgets/
│       ├── doctor_card.dart
│       ├── search_bar_widget.dart
│       ├── quick_action_button.dart
│       └── section_header.dart
├── assets/
│   └── images/              ← Place doctor images here
├── web/                     ← Web platform files
├── test/
│   └── widget_test.dart
├── analysis_options.yaml    ← Dart linting rules
├── .metadata                ← Flutter project metadata
├── .gitignore
└── pubspec.yaml             ← Dependencies & assets
```

---

## Dependencies Used

| Package | Purpose |
|---------|---------|
| `provider` | State management |
| `google_fonts` | Inter font (no manual download needed) |
| `shared_preferences` | Local data persistence |
| `intl` | Date formatting |

---

## Screens

| Screen | Features |
|--------|---------|
| **Home** | Greeting, search, upcoming appointment card, quick actions, top doctors, health tips |
| **Doctors** | Search by name/specialty, filter chips, availability badge, favorites |
| **Appointments** | Upcoming / Completed / Cancelled tabs, cancel dialog, Prescriptions toggle |
| **Messages** | Chat thread list with unread badges, online indicator |
| **Profile** | Stats, allergies, health menu, settings |
| **Doctor Detail** | About, ratings, day picker, time slot booking |
| **Chat** | Real-time messaging, keyboard-aware input |
