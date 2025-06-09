# EV Charging Station Flutter App 🚗⚡

A mobile application built using **Flutter**, **Dart**, **BLoC** state management, and **Retrofit** for networking. This app allows users to locate electric vehicle charging stations, view their status in real-time, and get summary details via an interactive map interface.

## 📱 Features

- 📍 Charging stations displayed on a map (Google Maps)
- 🔄 Live status updates via backend polling
- 🔒 Firebase authentication (Phone, Email, etc.)
- 🎯 Clean BLoC architecture
- 📡 API integration with Retrofit
- ⚙️ Modular, scalable, and maintainable code

---

## 🛠️ Technologies Used

| Technology | Description |
|------------|-------------|
| Flutter    | UI Toolkit for building apps |
| Dart       | Programming language |
| BLoC       | State management |
| Retrofit   | Networking (REST API) |
| Firebase   | Auth and real-time updates |
| PostgreSQL | Backend database |
| Node.js    | Backend server (GCP App Engine) |

---

## 📂 Folder Structure


---

## 🔌 Setup Instructions

### 1. Clone the repo

git clone https://github.com/ghanendrakumar171/ev-charging-app.git

Generate Retrofit API files
flutter pub run build_runner build --delete-conflicting-outputs

4. Run the app

flutter run
