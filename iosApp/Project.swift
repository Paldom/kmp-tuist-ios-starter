import ProjectDescription

let project = Project(
    name: "iosApp",
    targets: [
        .target(
            name: "iosApp",
            destinations: .iOS,
            product: .app,
            bundleId: "${BUNDLE_ID}${TEAM_ID}",
            infoPlist: .extendingDefault(with: [
                "CFBundleShortVersionString": "1.0",
                "CFBundleVersion": "1",
                "LSRequiresIPhoneOS": true,
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": false
                ],
                "UIRequiredDeviceCapabilities": ["armv7"],
                "UISupportedInterfaceOrientations": [
                    "UIInterfaceOrientationPortrait",
                    "UIInterfaceOrientationLandscapeLeft",
                    "UIInterfaceOrientationLandscapeRight"
                ],
                "UISupportedInterfaceOrientations~ipad": [
                    "UIInterfaceOrientationPortrait",
                    "UIInterfaceOrientationPortraitUpsideDown",
                    "UIInterfaceOrientationLandscapeLeft",
                    "UIInterfaceOrientationLandscapeRight"
                ],
                "UILaunchStoryboardName": "LaunchScreen.storyboard",
            ]),
            sources: ["iosApp/Sources/**"],
            resources: ["iosApp/Resources/**"],
            scripts: [
                .pre(script: """
                if [ \"YES\" = \"$OVERRIDE_KOTLIN_BUILD_IDE_SUPPORTED\" ]; then
                  echo \"Skipping Gradle build task invocation due to OVERRIDE_KOTLIN_BUILD_IDE_SUPPORTED environment variable set to \\\"YES\\\"\"
                  exit 0
                fi
                cd \"$SRCROOT/..\"
                ./gradlew :shared:embedAndSignAppleFrameworkForXcode
                """, name: "Compile Kotlin Framework", basedOnDependencyAnalysis: false)
            ],
            dependencies: [],
            settings: .settings(
                base: [
                    "FRAMEWORK_SEARCH_PATHS": ["$(inherited)", "$(SRCROOT)/../shared/build/xcode-frameworks/$(CONFIGURATION)/$(SDK_NAME)"],
                    "OTHER_LDFLAGS": ["$(inherited)", "-framework", "shared"],
                ], configurations: [
                    .debug(name: "Debug", xcconfig: "Configuration/Config.xcconfig"),
                    .release(name: "Release", xcconfig: "Configuration/Config.xcconfig")
                ])
        ),
        .target(
            name: "iosAppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.iosAppTests",
            infoPlist: .default,
            sources: ["iosApp/Tests/**"],
            resources: [],
            dependencies: [.target(name: "iosApp")]
        ),
    ]
)
