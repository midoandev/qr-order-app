# 🍽️ QR Order App

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean--Strict-green.svg)](#-architecture-overview)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A high-performance, QR-based restaurant ordering application built with **Flutter Clean Architecture**.

---

## 📱 App Showcases



  <img src="assets/screenshots/screen_recorder.gif" width="300" alt="Demo Aplikasi">

---

## 🏗 Architecture Overview

This project implements **Strict Clean Architecture** to ensure high maintainability and 100% testability of business logic.

### 1. Domain Layer (Pure Dart)
*   **Entities**: Immutable data objects (e.g., `OrderEntity`).
*   **UseCases**: Orchestrates business rules (e.g., `GetActiveOrdersUseCase`).
*   **Repositories**: Abstract contracts for data operations.
*   *Rule: No Flutter dependencies, No JSON logic.*

### 2. Data Layer
*   **Models**: JSON serialization & mapping (e.g., `UserModel.fromJson`).
*   **DataSources**: `OrderLocalData` (SharedPrefs) & `OrderRemoteData` (API).
*   **RepositoryImpl**: Logic for data retrieval and Entity mapping.

### 3. Presentation Layer
*   **State Management**: `Cubit` (Bloc) with immutable states.
*   **UI**: Material 3 components, `ColorScheme` adaptation, and `i18n`.
*   **Adaptive UI**: UI reacts to data states (e.g., Scan Button morphs into FAB when orders exist).

---

## 🔄 Core Application Flow

### 1. QR Entry & Validation
User scans a table QR. `ScannerCubit` validates the payload and injects `tableId` into the routing state.

### 2. Checkout & Persistent Storage
On successful checkout:
1. `OrderCubit` executes `SaveOrderUseCase`.
2. Data is serialized to JSON and stored in **Local Disk** via `SharedPreferences`.
3. Order ID is added to the active tracking ledger.

### 3. State Recovery
Upon app relaunch or returning to Home, `HomeCubit` re-hydrates the state from Disk, ensuring **Zero Data Loss**.

---

## 🛠 Tech Stack

*   **State Management**: `flutter_bloc` (Cubit).
*   **Routing**: `go_router` (Type-safe & nested navigation).
*   **DI**: `GetIt` (Service Locator).
*   **Local Storage**: `shared_preferences` (Persistent Key-Value).
*   **Testing**: `mocktail` & `bloc_test`.

---

## 🧪 Test with QR Codes

Use these QR codes to test the application logic (scan via the in-app scanner):

<p align="center">
  <img src="assets/qrcodes/table_t001.png" height="180" alt="Table T001">
  <img src="assets/icon/app_icon.png" height="180" alt="Main Showcase">

  <img src="assets/qrcodes/table_t002.png" height="180" alt="Table T002">
</p>
<p align="center">
  <i>Table ID: T001 | Table ID: T002</i>
</p>

---

## 🚀 Getting Started

1.  **Clone & Install**:
    ```bash
    git clone https://github.com/midoandev/qr-order-app.git
    flutter pub get
    ```
2.  **Environment Setup**:
    Create `.env` in the root folder:
    ```env
    BASE_URL=[https://api.your-resto.com](https://api.your-resto.com)
    APP_NAME=QR Order
    ```
3.  **Run Application**:
    ```bash
    flutter run

---


## 📱 Download & Test (APK)

You can download the latest debug build of this application directly from the **GitHub Actions** tab. This allows you to test the app on an Android device without setting up a local development environment.

### Steps to download:
1.  Go to the **Actions** tab in this repository.
2.  Select the most recent **Android Build & Test** workflow run.
3.  Scroll down to the **Artifacts** section at the bottom of the page.
4.  Click on `qr-order-debug-apk` to download the ZIP file.
5.  Extract the ZIP and install the `.apk` file on your Android device.
