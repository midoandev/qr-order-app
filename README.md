## 🏗 Architecture Overview

This project uses **Strict Clean Architecture** to ensure the code is scalable and easy to test.

### Project Layers:

1. **Domain Layer (Pure Dart)**: Contains business logic. No Flutter dependencies.
* `Entities`: Plain data objects.
* `UseCases`: Single responsibility logic (e.g., `GetActiveOrdersUseCase`).
* `Repositories`: Abstract interfaces.


2. **Data Layer**: Infrastructure implementation.
* `Models`: Handle JSON serialization and mapping.
* `DataSources`: Local storage (`SharedPreferences`) or Remote API.
* `RepositoryImpl`: Connects DataSources and converts Models to Entities.


3. **Presentation Layer**: UI and State Management.
* `Cubits`: Manage immutable states (Loading, Loaded, Error).
* `Pages/Widgets`: Material 3 UI with i18n support.



---

## 🔄 Core Application Flow

### 1. QR Scan & Table Entry

* The user scans a table QR code.
* `ScannerCubit` validates the data and navigates to the `MenuPage` using the `tableId`.

### 2. Cart & Order Management

* The `CartCubit` manages items, add-ons, and notes in the local state.
* Logic is validated at the Domain level before being passed to the order stage.

### 3. Checkout & Data Persistence

* When checkout is successful, `OrderCubit` calls the `saveOrder` method in the Data Layer.
* The order is converted to a JSON string and saved in `SharedPreferences`.
* The Order ID is added to an active tracking list in local storage.

### 4. Active Order Recovery (Home Page)

* When the `HomePage` opens, `HomeCubit` triggers `GetActiveOrdersUseCase`.
* The app reads stored JSON from `SharedPreferences` and restores the `OrderEntity` list.
* **Adaptive UI**: If active orders exist, the "Scan" button moves to a **FloatingActionButton (FAB)** to make room for the order list.

---

## 🛠 Tech Stack

* **State Management**: `flutter_bloc` (Cubit).
* **Navigation**: `go_router` (Custom animations).
* **Dependency Injection**: `GetIt`.
* **Local Storage**: `shared_preferences` (Persistent JSON).
* **Testing**: `mocktail` & `bloc_test`.

---

## 🚀 How to Run

1. Ensure Flutter SDK is installed.
2. Run `flutter pub get`.
3. Create `.env` file for API configurations.
4. Run `flutter run`.

---

### Final Engineering Audit

* **Persistence**: Data is saved to Disk (Disk Storage), not just RAM. It will not disappear on refresh.
* **Clean Code**: Models handle all JSON logic. Cubits only see Entities.
* **UX**: The UI adapts automatically based on the presence of active orders.