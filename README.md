# Link Manager

![app](assets/images/logo.png)

Link Manager is a mobile app designed to help students efficiently manage and organize important academic links. The app allows users to store links to various resources, such as timetables, departmental websites, and more, making it easy to access them when needed.

| Kategorie           | Požadavek v předmětu       | Má implementace (Flutter)       | Důkazy / Poznámky                  |
|---------------------|---------------------------|--------------------------------|-----------------------------------|
| **Jazyk**          | Kotlin                   | Dart                           | Celý kód v Dartu                 |
| **Architektura**   | ViewModel + LiveData     | BLoC/Cubit                     | `lib/bloc/`                      |
| **UI**             | 5+ obrazovek             | Hlavní, profil, kalkulačka, nastavení, dialogy, search | Screenshoty UI |
|                    | LazyColumn               | ListView.builder               | `lib/screens/home.dart`          |
| **Navigace**       | Navigation Component     | GoRouter                       | `lib/router.dart`               |
| **Databáze**       | Room (SQLite)            | Firestore + SharedPreferences  | Cloud DB + lokální nastavení     |
| **Síť**            | Retrofit                 | Firebase SDK                   | Auth + Firestore                |
| **Notifikace**     | AlarmManager             | FCM + flutter_local_notifications | `lib/services/notifier.dart`   |
| **Práva**          | Runtime permissions      | `POST_NOTIFICATIONS` + síťové  | `AndroidManifest.xml`           |
| **Lokalizace**     | -                        | Čeština, angličtina, ruština   | `lib/l10n/`                     |
| **Téma**           | Vlastní vzhled           | Material 3                     | `lib/theme/`                     |

| **Doplňkové funkce**            |                                  |
|---------------------------------|----------------------------------|
| Přihlášení přes Google         | Okamžitá synchronizace dat       |
| Multiplatformní (iOS+Android)  | Jedna codebase pro obě platformy |
| Offline chybová stránka        | Informuje o ztrátě spojení       |
| Výpočet váženého průměru       | Komplexní kalkulačka známek      |
| Fulltextové vyhledávání        | Rychlé filtrování odkazů         |
## Installation

To run this project locally, follow these steps:

1. Clone the repository:
   git clone https://github.com/your-username/link-manager.git

2. Install the required dependencies:
   flutter pub get

3. Run the app:
   flutter run

## License

This project is licensed under the [MIT License](LICENSE).
