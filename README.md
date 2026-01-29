# Kanbellon 🐧

A robust, offline-first **Kanban Board** application built with Flutter for Linux Desktop.
Features **Google Drive Sync**, **Drag & Drop**, and a hierarchical organization (Workspaces > Boards > Lists > Cards).

![Kanbellon Icon](assets/icon.png)

## Features

-   **Hierarchy**: Organize your work into **Workspaces**, each containing multiple **Boards**.
-   **Kanban**: Drag and drop cards between lists (or across boards via context menu).
-   **Persistence**:
    -   **Desktop**: Saves data to a local `kanban_data.json` file (user selectable).
    -   **Images**: Supports pasting images into cards (stored locally in `img/` folder).
-   **Cloud Sync**:
    -   Optional **Google Drive** integration.
    -   Syncs your JSON data file to a private app folder in your Drive.
    -   Restore data on any machine.
-   **Linux Native**:
    -   System Tray icon.
    -   Native window decorations.
    -   `.deb` package generation.

## Tech Stack

-   **Framework**: Flutter 3.x
-   **Language**: Dart 3.x
-   **State Management**: [Riverpod](https://riverpod.dev/) (v3.0) + [Freezed](https://pub.dev/packages/freezed) (v3.0)
-   **Persistence**: JSON Serialization + `shared_preferences`
-   **Auth**: `google_sign_in` / `googleapis`

## Getting Started

### Prerequisites

-   Flutter SDK installed (`flutter doctor`)
-   Linux toolchain (`sudo apt install clang cmake ninja-build pkg-config libgtk-3-dev`)

### Installation (Development)

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/kanbellon.git
    cd kanbellon
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run Code Generation** (Important for Riverpod/Freezed):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the App**:
    ```bash
    flutter run -d linux
    ```

## Building for Release (Linux .deb)

1.  **Build the binary**:
    ```bash
    flutter build linux --release
    ```
    *Note: If your environment lacks `ld` in llvm path, ensure you have `lld` installed or symlink `/usr/bin/ld`.*

2.  **Package**:
    ```bash
    # Copy artifacts
    cp -r build/linux/x64/release/bundle/* build/debian/usr/lib/kanbellon/
    
    # Generate .deb
    dpkg-deb --build build/debian kanbellon_1.1.4_amd64.deb
    ```

## Project Structure

```
lib/
├── models/          # Freezed data models (KanbanCard, etc.)
├── providers/       # Riverpod Notifiers (Logic & State)
├── services/        # Persistence & Cloud Service abstractions
├── ui/              # Widgets & Screens
└── main.dart        # Entry point
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
