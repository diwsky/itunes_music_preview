# iTunes Music Preview

A Music Player built with Flutter framework & API provided by https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api

<details><summary>Supported Devices</summary>

  * Xiaomi Redmi Note 10 Pro (M2101K6G) running on Android 12 & MIUI 13 but it should work for Android Emulator too.
  * Minimum requirement for Android to be able install this application was set to Android 5.0 (SDK 21).
 
</details>

<details><summary>Supported Features</summary>

  
  1. Search list of music track by artist name
2. Play a preview music track for free
3. Seeking the music player stream to specific time
4. View detail information of music track
5. Detail information include Album Collection, Price, Artist Playlist & more which can directly open browser for more complete access.
</details>


<details><summary>Requirements To Build The Application</summary>

  
  1. Make sure you have Flutter installation in your machine
  2. Clone this repository
  3. Switch into **development** branch
  4. Run ```flutter pub get``` to install all the dependencies inside the project
  5. Run ```flutter pub run build_runner build``` for generating file which need to be generated via code generation. If some error encounter you can add ```--delete-conflicting-outputs``` flag.
  6. After all set up completed you can run via Run button or you can type command ```flutter run``` (default to debug variant), if you want to install the release version just add flag ```--release``` in previous command.
</details>



<details><summary>Deploy Application</summary>

    
     In this step I'm using Android Studio
  
  1. Open application project and find android folder (under project root folder)
  2. ```Right click``` -> ```Flutter``` -> ```Open Android Module in Android Studio```
  3. Go to ```Build``` -> ```Generate Signed Bundle or APK``` (choose Android App Bundle) if you want to deploy to Google Play Store since aab file size is smaller than APK.
  4. In Key store path, click ```Choose existing``` and click ```Project Directory``` (green android logo) -> ```app``` -> ```cert``` there you have a file called ```key.jks```, select this.
  5. Fill key alias and those password, you can find this information in ```build.gradle``` file **(app level)**.
  6. Finally choose the build variant you want to deploy.
   7. Wait for build to finish and there is popup in bottom corner of the IDE said they have an aab or APK files for you.
</details>


