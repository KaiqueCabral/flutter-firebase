# flutter_firebase

This project was made to show how to connect Flutter to Firebase using package [cloud_firestore](https://pub.dev/packages/cloud_firestore).

The project also works on Flutter Web, but you need to do some changes.

Follow these steps to make the project work on your machine:

On [Firebase Console](https://console.firebase.google.com/):
To know how to do it, you can use this link:
https://www.youtube.com/watch?v=Wa0rdbb53I8&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC&index=2

The playlist is very good, I recommend.

On your machine (I'm assuming you already have Flutter installed):
1. Open VS Code (Or Android Studio)
2. Create a new Project of Flutter
3. Copy the folder LIB (From this repository)
4. Paste (overwrite) the folder in your project
5. See below how to make it work for both Flutter Web and Android


## How to make it work on Android

File: android/app/build.gradle
1. Open the file: android/app/build.gradle
2. Search for "apply plugin"
3. Paste this code:
    apply plugin: 'com.google.gms.google-services'
4. Search for "minSdkVersion"
5. Change the version to 21
6. Also in defaultConfig, insert this code:
    multiDexEnabled true
7. In the end of this file, insert this code:
    implementation 'androidx.multidex:multidex:2.0.1'
8. Done!

File: android/build.gradle (WARNING! It's another file)
1. Open the file: android/build.gradle
2. In the section "dependencies", insert this code:
    classpath 'com.google.gms:google-services:4.3.3'
3. Done!

## How to make it work on Web

File: web/index.html
1. Open the file: web/index.html
2. Go to Firebase > Select the project > Settings > General > Your Applications > Web > Copy the content
3. You have to past before the script "main.dart.js". Your file will look like this:

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="A new Flutter project.">

  <!-- iOS meta tags & icons -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="flutter_firebase">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Favicon -->
  <link rel="shortcut icon" type="image/png" href="favicon.png"/>

  <title>flutter_firebase</title>
  <link rel="manifest" href="manifest.json">
</head>
<body>
  <!-- This script installs service_worker.js to provide PWA functionality to
       application. For more information, see:
       https://developers.google.com/web/fundamentals/primers/service-workers -->
  <script>
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', function () {
        navigator.serviceWorker.register('flutter_service_worker.js');
      });
    }
  </script>
  <!-- The core Firebase JS SDK is always required and must be listed first -->
  <script src="https://www.gstatic.com/firebasejs/7.12.0/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/7.12.0/firebase-auth.js"></script>
  <script src="https://www.gstatic.com/firebasejs/7.12.0/firebase-firestore.js"></script>

  <!-- TODO: Add SDKs for Firebase products that you want to use
      https://firebase.google.com/docs/web/setup#available-libraries -->
  <script src="https://www.gstatic.com/firebasejs/7.12.0/firebase-analytics.js"></script>

  <script>
    // Your web app's Firebase configuration
    const firebaseConfig = {
      apiKey: "[YOUR_API]",
      authDomain: "[YOUR_AUTH_DOMAIN]",
      databaseURL: "[YOUR_DATABASE_URL]",
      projectId: "[YOUR_PROJECT_ID]",
      storageBucket: "[YOUR_STORAGE_BUCKET]",
      messagingSenderId: "[YOUR_MESSAGING_SENDER_ID]",
      appId: "[YOUR_APP_ID]",
      measurementId: "[YOUR_MEASUREMENT_ID]"
    };
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
    firebase.analytics();
  </script>
  <script src="main.dart.js" type="application/javascript"></script>
</body>
</html>
