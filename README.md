# fireauth_ui

[![Build Status](https://www.bitrise.io/app/5200f74e30b34a48/status.svg?token=OC_Yo2MikC22ZFfwKpXavg)](https://www.bitrise.io/app/5200f74e30b34a48) 
[![pub package](https://img.shields.io/pub/v/fireauth_ui.svg)](https://pub.dartlang.org/packages/fireauth_ui)

Allows you to quickly connect common Firebase auth with basic UI.

## Support Sign-in Providers List

| Sign in method    | Support           |
| ----------------- |:-----------------:|
| Email             | ✅                |
| Phone             | ❌                |
| Google            | ✅                |
| Play Games        | ❌                |
| Facebook          | ✅                |
| Twitter           | ❌                |
| Github            | ❌                |

Support language

- English

- Chinses (Tranditional)

Email sign in demo screen

![email_demo_video](docs/email_demo.gif)

## Installation

Add to your pubspec dependencies:
```yaml
fireauth_ui: ^0.0.1
```

Please follow below guides to setup.

1. Open Firebase Console ( https://console.firebase.google.com/ )

2. Create your project

3. Add Firebase to your iOS app
    
    - Open **"ios/Runner.xcworkspace"**
    
    - Drag that **"GoogleService-Info.plist"** into the Runner directory then dialog will show up and ask you to select the targets, select the **Runner** target

4. Add Firebase to your Android app
    - Place **"google-services.json"** in **"android/app"** folder

    - If your project required **"Google Sign in"**, please ensure config **"Debug signing certificate SHA-1"** also.

        > You can run this command to get SHA-1 hash from android debug keystore
        > Noted: debug keystore password is "android"

        ```
        keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
        ```
    - Open **"android/build.gradle"**
        ```gradle
        buildscript {
            dependencies {
                // Add this line
                classpath 'com.google.gms:google-services:3.2.1'
            }
        }
        ```
    - Open **"android/app/build.gradle"**
        ```gradle
        dependencies {
            // Add this line
            compile 'com.google.firebase:firebase-core:16.0.0'
        }
        ...
        // Add to the bottom of the file
        apply plugin: 'com.google.gms.google-services'

        ```

5. Go to **"Authentication"** Section

6. Select Sign-in method

7. Enable **"Sign-in providers"** which you need, please see [support list](#support-sign-in-providers-list)

    - Email Sign in
        - Just enable it
    
    - Google Sign-in
        
        - Add the **CFBundleURLTypes** attributes below into the **"/ios/Runner/Info.plist"** file.

        ```xml
        <key>CFBundleURLTypes</key>
        <array>
            <dict>
                <key>CFBundleTypeRole</key>
                <string>Editor</string>
                <key>CFBundleURLSchemes</key>
                <array>
                    <!-- TODO Replace this value: -->
                    <!-- Copied from GoogleServices-Info.plist key REVERSE_CLIENT_ID -->
                    <string>com.googleusercontent.apps.861823949799-vc35cprkp249096uujjn0vvnmcvjppkn</string>
                </array>
            </dict>
        </array>
        ```
    - Facebook Sign-in
        
        - Open https://developers.facebook.com/

        - Click **My App** then select **Add New App**

        - In **Facebook Login** section, click **Setup**

        - Follow instruction in facebook developer page to setup iOS and Android

        > **Take care** when paste facebook's **CFBundleURLTypes** into plist
        > <br/>Don't overwrite **Google Sign-in** CFBundleURLTypes

        - Finally, remember copy OAuth redirect URI to Firebase's facebook sign-in
          > Paste URI in Facebook Login > Settings > Valid OAuth Refirect URIs


## Getting Started

Add the following import to your Dart code:

```dart
import 'package:fireauth_ui/fireauth_ui.dart';
```

You can install packages from the command line:

with Flutter:

```
flutter packages get
```

Sample code show you how to present sign in page
```dart
Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new FireAuthUISignInPage(
                providers: [
                    FireAuthUIProvider.Email,
                    FireAuthUIProvider.Facebook,
                    FireAuthUIProvider.Google,
                ],
              )),
    );
```

## Dependencies

[flutter_facebook_login](https://pub.dartlang.org/packages/flutter_facebook_login)

[firebase_auth](https://pub.dartlang.org/packages/firebase_auth)

[google_sign_in](https://pub.dartlang.org/packages/google_sign_in)

License
-------

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.