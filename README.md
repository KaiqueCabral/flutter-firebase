# flutter_firebase

This project was made to show how to connect Flutter to Firebase using package [cloud_firestore](https://pub.dev/packages/cloud_firestore).

The project also works on Flutter Web, but you need to do some changes.

Follow these steps to make the project work on your machine:

On [Firebase Console](https://console.firebase.google.com/):
To learn how to do it, you watch the video here:
https://www.youtube.com/watch?v=Wa0rdbb53I8&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC&index=2

The playlist is very good, I recommend.

On your machine (I'm assuming you already have Flutter installed):
1. Open VS Code (Or Android Studio)
2. Create a new Flutter project
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

I recommend you to click in "Raw" in the beginning of this page.

File: web/index.html
1. Open the file: web/index.html
2. Go to Firebase > Select the project > Settings > General > Your Applications > Web > Copy the content
3. You have to past before the script "main.dart.js". Your file will look like this file: 
[Web Configuration](https://raw.githubusercontent.com/KaiqueCabral/flutter-firebase/master/web.html.md)
