# kmp-tuist-ios-starter
Kotlin Multiplatform (KMP) iOS starter project built with tuist instead of Xcode project

## How to run iOS project

1. Install and configure [mise](https://docs.tuist.io/guide/introduction/installation.html)
2. Run `tuist generate` in `iosApp` directory
3. Start `iosApp.xcworkspace` as usual

## About KMP project

This is a Kotlin Multiplatform project targeting iOS.

* `/iosApp` contains iOS applications. Even if you’re sharing your UI with Compose Multiplatform, 
  you need this entry point for your iOS app. This is also where you should add SwiftUI code for your project.

* `/shared` is for the code that will be shared between all targets in the project.
  The most important subfolder is `commonMain`. If preferred, you can add code to the platform-specific folders here too.


Learn more about [Kotlin Multiplatform](https://www.jetbrains.com/help/kotlin-multiplatform-dev/get-started.html)…