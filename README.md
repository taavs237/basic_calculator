Basic Calculator

A Flutter-based calculator application developed as a course assignment.

The calculator supports full mathematical expressions (e.g. 5+6/2) with correct operator precedence and stores calculation history in the cloud using Firebase Firestore.

Equation Support

The calculator is not limited to two numbers.
Users can enter complete mathematical expressions such as:

5+6/2

10-3*2

7/2

Expressions are parsed and evaluated with correct operator precedence (multiplication and division before addition and subtraction).

Each calculation is stored in history in the following format:

expression = result


Example:

5+6/2 = 8

Cloud Storage (Firebase Firestore)

Calculation history is stored in Firebase Firestore instead of local storage.

Firestore data structure:

users
 └── {uid}
      └── history
           ├── calculation documents


Each user has a separate history stored under their unique user ID.

Authentication

The application uses Firebase Anonymous Authentication.

No login or password is required

Each user is automatically assigned a unique UID

The UID is used to associate Firestore data with its owner

Authentication runs transparently in the background and is used only for access control.

Firestore Security Rules

Firestore access is restricted so that users can only read and write their own data.

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    match /users/{userId}/history/{docId} {
      allow read, write: if request.auth != null
                         && request.auth.uid == userId;
    }

    match /{document=**} {
      allow read, write: if false;
    }
  }
}


This ensures:

Only authenticated users can access the database

Users can only access their own history

All other database access is denied

Firebase Web API Key Notice

The file firebase_options.dart contains a Firebase Web API key.

This key is public by design and required for Firebase Web applications.
It does not grant access to Firestore data on its own.

All data access is protected by:

Firebase Authentication

Firestore security rules

Technologies Used

Flutter

Dart

Firebase Firestore

Firebase Authentication (Anonymous)

Assignment Requirements Coverage

Equation support (not limited to two numbers)

Cloud-based history storage using Firestore

User-specific access control

Firestore security rules limiting access to the author only
