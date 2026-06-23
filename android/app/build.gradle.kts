workflows:
  veloce-track-dual-build:
    name: Veloce Track Cloud Build (Android & iOS)
    max_build_duration: 60
    instance_type: mac_mini_m1
    environment:
      flutter: stable
      xcode: latest
      cocoapods: default
      java: 17  
    scripts:
      - name: Set up local.properties
        script: echo "flutter.sdk=$FLUTTER_ROOT" > android/local.properties

      - name: Get Flutter Packages
        script: |
          flutter clean
          flutter pub get
          
      - name: Install iOS Pods
        script: |
          cd ios
          pod install

      - name: Build Flutter APK (Android)
        script: flutter build apk --debug

      - name: Build Flutter IPA (iOS)
        script: flutter build ios --debug --no-codesign

    artifacts:
      - build/app/outputs/flutter-apk/**.apk
      - build/ios/iphoneos/*.app