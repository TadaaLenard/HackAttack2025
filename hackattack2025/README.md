hackattack2025

README.txt

Welcome to the hackattack2025 Flutter project!

This application is designed to work with a backend server. Once you have the app running, it should be fully functional provided the backend is accessible.

---

## Getting Started

To run this Flutter project on your device, please follow these steps:

### Prerequisites

1.  **Flutter SDK:** Make sure you have the Flutter SDK installed on your machine. You can find installation instructions here:
    https://docs.flutter.dev/get-started/install

2.  **IDE (Recommended):**
    * Visual Studio Code with the Flutter extension, OR
    * Android Studio with the Flutter and Dart plugins.

3.  **Device/Emulator:** You'll need a physical Android or iOS device, or an Android emulator/iOS simulator.

---

### Running the Application

1.  **Clone the Repository:**
    First, clone this project from GitHub to your local machine:
    ```bash
    git clone https://github.com/TadaaLenard/HackAttack2025.git
    ```

2.  **Navigate to the Project Directory:**
    Now, change your directory into the Flutter project's root folder. It's located *inside* the cloned repository:
    ```bash
    cd HackAttack2025/hackattack2025
    ```

3.  **Get Flutter Dependencies:**
    Once you're in the correct directory, run the following command to fetch all the necessary packages for the project:
    ```bash
    flutter pub get
    ```

4.  **Connect a Device or Start an Emulator:**
    Make sure you have a device connected (Android via USB with debugging enabled, or an iOS device) or an emulator/simulator running. You can check for available devices with:
    ```bash
    flutter devices
    ```

5.  **Run the Application:**
    With your device or emulator ready, run the application using this command:
    ```bash
    flutter run
    ```
    The app will then build and install on your selected device/emulator. The first build might take a little time.

---

### Troubleshooting

* **"flutter command not found":** Double-check that Flutter is correctly installed and added to your system's PATH.
* **Dependency issues:** Try running `flutter clean` followed by `flutter pub get`.
* **Device not found:** Verify your device is properly connected and recognized by your system (e.g., check USB debugging on Android, or trust the computer on iOS).
* **Backend Connectivity:** If the app runs but doesn't seem to get data, ensure your backend server is running and accessible from your device's network. You might need to check any configured backend URLs in the app's source code if you suspect a misconfiguration.

For more help with Flutter development, refer to the official Flutter documentation:
https://docs.flutter.dev/

Thank you for using hackattack2025!
