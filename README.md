#  State restoration on iOS 13 using Scenes

On iOS 13, Apple supported the multiwindowed applications using UIScenes. The lifecycle of the UIScene is managed by new delegate namely, SceneDelegate in XCode project. Following are the steps which can be used to support the state preservation of the application using the scene delegate.

1. Enable the state preservation by implementing "stateRestorationActivity" in the SceneDelegate. You can simply return the scene.userActivity in this method.
2. Define the NSUserActivityTypes array in the Info.plist to register the list of the activities supported.
3. Create and register the new NSUserActivity in the SceneDelegate when the application goes to background in the "sceneWillResignActive". You can decide which activity type to save depending upon the active view controller at this time.
4. Once the appplication comes to foreground again restore the NSUserActivity in "willConnectTo".



