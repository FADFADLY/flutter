# 🎓🚀 Graduation Project — Flutter App

> 💡 **Comprehensive, production-grade Flutter application** showcasing advanced techniques, clean architecture, and full backend integration.  
> 🛠 Built with **Cubit/BLoC**, **Firebase**, **Hive**, and other industry-ready tools.  
> 📱 **Multi-platform support**: Android, iOS, Windows, Linux.

---

## 📸✨ Screenshots

Explore the app's capabilities, visual polish, and adaptive UI across platforms:

| 🖼 ![Screenshot 1](assets/1.png) | 🖼 ![Screenshot 2](assets/2.png) | 🖼 ![Screenshot 3](assets/3.png) |
|---|---|---|
| 🖼 ![Screenshot 4](assets/4.png) | 🖼 ![Screenshot 5](assets/5.png) | 🖼 ![Screenshot 6](assets/6.png) |
| 🖼 ![Screenshot 7](assets/7.png) | 🖼 ![Screenshot 8](assets/8.png) | 🖼 ![Screenshot 9](assets/9.png) |
| 🖼 ![Screenshot 10](assets/10.png) | 🖼 ![Screenshot 11](assets/11.png) | 🖼 ![Screenshot 12](assets/12.png) |
| 🖼 ![Screenshot 13](assets/13.png) | 🖼 ![Screenshot 14](assets/14.png) | 🖼 ![Screenshot 15](assets/15.png) |
| 🖼 ![Screenshot 16](assets/16.png) |  |  |

---

## 📑📌 Table of Contents

1. [📖 Introduction](#-introduction)  
2. [🚀 Features](#-features)  
3. [🛠 Getting Started](#-getting-started)  
4. [🗂 Project Structure](#-project-structure)  
5. [🏛 Core Services & Architecture](#-core-services--architecture)  
6. [📂 Feature Details](#-feature-details)  
7. [🔥 Firebase Integration](#-firebase-integration)  
8. [🎨 Assets](#-assets)  
9. [💻 Platform Support](#-platform-support)  
10. [🧩 Dependency Injection](#-dependency-injection)  
11. [📦 Dependencies](#-dependencies)  
12. [🤝 Contributing](#-contributing)  
13. [📜 License](#-license)  
14. [📚 Further Resources](#-further-resources)  

---

## 📖 Introduction

The **Graduation Project App** is a **feature-rich, production-grade Flutter application** built using **clean architecture** principles, **modular code organization**, and **strong separation of concerns**.  

It integrates with:  
- 🌐 A **custom backend API**.  
- 🔥 **Firebase services** for authentication, storage, and messaging.  

---

## 🚀 Features

- 🔐 **Authentication**: Sign up, login, password reset, logout.  
- 💬 **Community**: Posts, comments, reactions, and voting system.  
- 😊 **Mood Tracker**: Log moods, write notes, view statistics.  
- 📆 **Habit Tracker**: Manage habits, timers, and yoga stopwatch.  
- 📚🎧 **Books & Podcasts**: Browse media content, PDF viewing, audio playback.  
- 👤 **Profile**: Edit and view personal data.  
- 🧠 **Testing/Quizzes**: Interactive quizzes with results storage.  
- 🤖 **Chatbot**: Real-time chat experience with offline history.  
- 📴 **Offline Handling**: Assets for no-internet and empty states.  
- 📱💻 **Multi-Platform**: Android, iOS, Windows, Linux.  
- 🔥 **Firebase Integration**: Auth, Firestore, Storage, Messaging.  

---

## 🛠 Getting Started

### 1️⃣ Clone the Repository
```sh
git clone https://github.com/FADFADLY/flutter.git
cd flutter
```

### 2️⃣ Install Flutter SDK  
📄 Follow the [Official Flutter Installation Guide](https://docs.flutter.dev/get-started/install).

### 3️⃣ Install Dependencies
```sh
flutter pub get
```

### 4️⃣ Configure Firebase  
- ✏ Update `lib/firebase_options.dart` with your Firebase project keys.  
- 📖 Follow the [FlutterFire setup guide](https://firebase.flutter.dev/docs/overview).  

### 5️⃣ Run the App
#### 📱 Mobile:
```sh
flutter run
```
#### 💻 Desktop:
```sh
flutter run -d windows
flutter run -d linux
```

---

## 🗂 Project Structure

```text
lib/
  core/
    services/
      remote/              # 🌐 API services
      networking/          # 🔗 HTTP client & interceptors
      get_it_services.dart # 🧩 Dependency Injection
    errors/                # ⚠ Exception handling
  features/
    auth/                  # 🔐 Authentication module
    community/             # 💬 Posts, comments, votes
    mood_tracker/          # 😊 Mood logging
    habits/                # 📆 Habit tracker
    books/                 # 📚 Books module
    podcasts/              # 🎧 Podcasts module
    profile/               # 👤 User profile
    test/                  # 🧠 Quizzes/tests
    chatbot/               # 🤖 Chatbot
  generated/               # ⚙ Generated files (assets, localization)
assets/                    # 🖼 Images, audio, JSON states
windows/                   # 💻 Windows-specific code
linux/                     # 💻 Linux-specific code
```

---

## 🏛 Core Services & Architecture

- 🧹 **Clean Architecture**: Data, Domain, and Presentation layers separated.  
- 🎯 **Cubit/BLoC**: State management solution.  
- 📦 **Repository Pattern**: Abstracts business logic from UI.  
- 🔐 **Secure Storage**: `flutter_secure_storage` for sensitive data.  
- 📴 **Offline Support**: `Hive` for local caching.  

---

## 📂 Feature Details

### 🔐 Authentication
- 🆕 Registration, Login, Password Reset.
- 🔑 Token storage in secure storage.
- 🔄 Cubit states for each flow.

### 💬 Community & Posts
- ✏ Create, update, delete posts.
- 💭 Comment system.
- 👍 Voting and reactions.

### 😊 Mood Tracker
- 📝 Track moods with notes.
- 📊 View statistics & history.

### 📆 Habits
- 🛠 Create and manage habits.
- ⏱ Timers and yoga stopwatch.

### 📚🎧 Books & Podcasts
- 📄 PDF book viewing.
- 🎵 Podcast audio playback with waveform animations.

### 👤 Profile
- ✏ Update and view personal info.

### 🧠 Testing
- ❓ Quizzes with calculated results.
- 🗂 Store test history.

### 🤖 Chatbot
- 💬 Real-time interaction.
- 📴 Offline chat history (Hive).

---

## 🔥 Firebase Integration

- 🔐 **Authentication**: Login/Signup.  
- ☁ **Cloud Firestore**: Data storage.  
- 📢 **Cloud Messaging**: Push notifications.  
- 🗂 **Firebase Storage**: Files and images.  

---

## 🎨 Assets

- 📂 Managed via `lib/generated/assets.dart`.  
- Includes:  
  - 🖼 Images, icons, SVGs.  
  - 🎞 Lottie animations.  
  - 📄 JSON empty states.  
- Organized into:  
  - `images/`, `audio/`, `tests/`, etc.  

---

## 💻 Platform Support

- 📱 **Mobile**: Android & iOS.  
- 💻 **Desktop**: Windows & Linux.  
- 📏 **Adaptive UI**: Using `flutter_screenutil` & `device_preview`.  

---

## 🧩 Dependency Injection

- 🛠 **get_it** for service & repository registration.  
- 📍 Centralized in `get_it_services.dart`.  

---

## 📦 Dependencies

| 📦 Package | 📝 Purpose |
|------------|-----------|
| flutter_bloc | 🎯 State management |
| get_it | 🧩 Dependency Injection |
| firebase_core, firebase_auth, cloud_firestore | 🔥 Firebase integration |
| hive, hive_flutter, hive_generator | 💾 Local storage |
| flutter_secure_storage | 🔐 Secure token storage |
| cached_network_image | 🖼 Optimized image loading |
| flutter_native_splash | 💦 Custom splash screens |
| flutter_launcher_icons | 🎨 App icon generation |
| file_picker, image_picker | 📂 File & image selection |
| audioplayers, just_audio, audio_waveforms | 🎵 Audio playback |
| fl_chart | 📊 Charts for statistics |
| table_calendar | 📅 Calendar-based UI |
| lottie | 🎞 Lottie animations |
| shimmer, skeletonizer | ✨ Loading placeholders |
| modal_progress_hud_nsn | ⏳ Progress HUD overlays |
| persistent_bottom_nav_bar | 📍 Bottom navigation |
| pull_to_refresh, custom_refresh_indicator | 🔄 Pull-to-refresh |
| permission_handler | 🔑 App permissions |
| vibration | 📳 Device vibration control |
| intl, intl_utils | 🌎 Internationalization |
| dartz | ⚙ Functional programming utilities |

---

## 🤝 Contributing

1. 🍴 **Fork & clone** the repository.  
2. 🆕 Create a new branch:
   ```sh
   git checkout -b feature/AmazingFeature
   ```
3. 💾 Commit changes:
   ```sh
   git commit -m "Add AmazingFeature"
   ```
4. 📤 Push to branch:
   ```sh
   git push origin feature/AmazingFeature
   ```
5. 📬 Open a **Pull Request**.

---

## 📜 License

📄 This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file.

---

## 📚 Further Resources

- 📖 [Flutter Documentation](https://docs.flutter.dev/)  
- 🔥 [FlutterFire Documentation](https://firebase.flutter.dev/)  
- 🎯 [BLoC Documentation](https://bloclibrary.dev/)  

---
