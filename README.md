# Flutter Login App

A simple Flutter application with email/password authentication powered by **Firebase Auth** and user data stored in **Cloud Firestore**.

---

## Features

- Email & password sign up / sign in
- Firebase Authentication integration
- User profile stored in Firestore
- Form validation
- Persistent session (stays logged in on app restart)
- Logout

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Authentication | Firebase Authentication |
| Database | Cloud Firestore |
| State | setState / Provider |

---


## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- A [Firebase](https://firebase.google.com) project with **Authentication** and **Firestore** enabled

### Installation

**1. Clone the repository**
```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

**2. Install dependencies**
```bash
flutter pub get
```

**3. Connect Firebase**

Install the Firebase CLI and FlutterFire CLI if not already done:
```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
```

Then configure your project:
```bash
firebase login
flutterfire configure
```

This generates `lib/firebase_options.dart` automatically.

**4. Run the app**
```bash
flutter run
```

---

## 🔧 Firebase Setup

### Authentication
In the Firebase console, go to **Authentication → Sign-in method** and enable **Email/Password**.

### Firestore
In the Firebase console, go to **Firestore Database** and create a database in test mode.

Recommended collection structure:
```
users/
└── {uid}/
    ├── email: string
    ├── displayName: string
    └── createdAt: timestamp
```

### Firestore Rules (basic)
```js
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.x.x
  firebase_auth: ^4.x.x
  cloud_firestore: ^4.x.x
```

---
