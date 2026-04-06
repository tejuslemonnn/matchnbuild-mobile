# MnB: MatchNBuild

## Tech Stack

- **Flutter** 3.38.7
- **State Management**: flutter_bloc
- **Dependency Injection & Routing**: flutter_modular
- **Network**: Dio (REST)
- **Local Storage**: Hive, SharedPreferences
- **Code Generation**: json_serializable

## Architecture

```
lib/
├── app/
│   ├── controller/          # Global app state (AppControllerBloc)
│   ├── data/                 # App-level data layer
│   │   ├── datasource/       # Remote data sources
│   │   └── repository/       # Repository implementations
│   ├── domain/               # App-level domain layer
│   │   ├── repository/       # Repository interfaces
│   │   └── usecase/          # Use cases
│   ├── modules/              # Feature modules
│   │   ├── auth/             # Authentication module
│   │   │   ├── data/
│   │   │   │   ├── local/    # Local datasource (Hive)
│   │   │   │   ├── remote/   # Remote datasource (API)
│   │   │   │   └── repository/
│   │   │   ├── domain/
│   │   │   │   ├── entity/
│   │   │   │   ├── repository/
│   │   │   │   └── usecase/
│   │   │   └── presentation/
│   │   │       ├── controller/  # BLoC
│   │   │       └── pages/
│   │   └── primary/          # Main app module (after login)
│   ├── pages/                # Shared pages (splash, etc.)
│   ├── widgets/              # Shared widgets
│   ├── app_module.dart       # Root module (DI bindings)
│   └── app_widget.dart       # Root widget
├── core/
│   └── models/               # Core/shared models
├── services/
│   ├── error/                # Error handling
│   ├── api.dart              # Dio REST client
│   └── api_result.dart       # API result wrapper
├── models/                   # Shared models
├── theme/                    # App theming
├── tool/                     # Utilities
├── l10n/                     # Localization
└── main.dart                 # Entry point
```

### Folder Descriptions

#### Data Layer (`data/`)

| Folder | Description |
|--------|-------------|
| **datasource/** | Kelas yang bertanggung jawab untuk mengambil data dari sumber eksternal. Terbagi menjadi: |
| `├── local/` | **Local DataSource** - Mengakses data dari penyimpanan lokal (Hive, SharedPreferences). Contoh: menyimpan/mengambil token, cache user data. |
| `└── remote/` | **Remote DataSource** - Mengakses data dari API (REST). Contoh: login request, fetch profile dari server. |
| **repository/** | Implementasi konkret dari repository interface. Menggabungkan data dari local dan remote datasource, menangani logic seperti caching dan error handling. |

#### Domain Layer (`domain/`)

| Folder | Description |
|--------|-------------|
| **entity/** | Model domain murni yang merepresentasikan business object. Tidak bergantung pada framework atau library eksternal. |
| **repository/** | Interface/abstract class yang mendefinisikan kontrak untuk operasi data. Domain layer hanya mengenal interface ini, bukan implementasinya. |
| **usecase/** | Business logic yang spesifik untuk satu aksi. Setiap use case memiliki satu tanggung jawab (Single Responsibility). Contoh: `LoginUseCase`, `GetProfileUseCase`. |

#### Presentation Layer (`presentation/`)

| Folder | Description |
|--------|-------------|
| **controller/** | BLoC (Business Logic Component) yang mengelola state UI. Menerima event dari UI, memanggil use case, dan emit state baru. |
| **pages/** | Widget Flutter yang membangun UI. Menggunakan `BlocBuilder`/`BlocListener` untuk bereaksi terhadap perubahan state. |

#### Other Folders

| Folder | Description |
|--------|-------------|
| **core/models/** | Model yang digunakan di seluruh aplikasi (shared across modules). |
| **services/** | Utility services seperti API client, error handling. |
| **theme/** | Konfigurasi tema aplikasi (colors, text styles, dll). |
| **tool/** | Helper functions dan utilities. |
| **l10n/** | File lokalisasi untuk multi-bahasa. |

### Data Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                        PRESENTATION                              │
│  ┌─────────┐    Event    ┌─────────┐    State    ┌─────────┐   │
│  │  Page   │ ──────────> │  BLoC   │ ──────────> │  Page   │   │
│  └─────────┘             └────┬────┘             └─────────┘   │
└───────────────────────────────┼─────────────────────────────────┘
                                │ calls
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                          DOMAIN                                  │
│                      ┌───────────┐                               │
│                      │  UseCase  │                               │
│                      └─────┬─────┘                               │
│                            │ uses                                │
│                      ┌─────▼─────┐                               │
│                      │ Repository│ (interface)                   │
│                      └───────────┘                               │
└───────────────────────────────────────────────────────────────────┘
                                │ implemented by
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                           DATA                                   │
│  ┌─────────────────┐                                            │
│  │ RepositoryImpl  │                                            │
│  └────────┬────────┘                                            │
│           │ uses                                                 │
│    ┌──────┴──────┐                                              │
│    ▼             ▼                                              │
│ ┌──────────┐ ┌──────────┐                                       │
│ │  Local   │ │  Remote  │                                       │
│ │DataSource│ │DataSource│                                       │
│ └────┬─────┘ └────┬─────┘                                       │
│      │            │                                              │
│      ▼            ▼                                              │
│   [Hive]      [API/REST]                                     │
└─────────────────────────────────────────────────────────────────┘
```

## Layer Responsibilities

| Layer | Responsibility |
|-------|----------------|
| **Presentation** | UI (Pages, Widgets) + State (BLoC) |
| **Domain** | Business logic (UseCases), Repository interfaces, Entities |
| **Data** | Repository implementations, DataSources (Remote/Local), Models |

### Setup

1. Clone the repository
2. Copy `.env.example` to `.env` and configure:

   ```
   BASE_URL=your_api_url
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Generate code:

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. Run the app:

   ```bash
   flutter run
   ```

## Code Generation

This project uses code generation for:

- **json_serializable**: JSON serialization
- **hive_generator**: Hive type adapters

Run after modifying annotated files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Project Structure Conventions

### Module Structure

Each feature module follows Clean Architecture:

```
module/
├── data/
│   ├── local/datasource/     # Local storage
│   ├── remote/datasource/    # API calls
│   └── repository/           # Repository impl
├── domain/
│   ├── entity/               # Domain entities
│   ├── repository/           # Repository interface
│   └── usecase/              # Business logic
├── presentation/
│   ├── controller/           # BLoC
│   └── pages/                # UI
└── module.dart               # Module definition
```

### Dependency Injection

- Register dependencies in module's `binds()` method
- Use `Modular.get<T>()` to resolve dependencies
- Parent module bindings are accessible in child modules

## Key Dependencies

| Package | Purpose |
|---------|---------|
| flutter_modular | DI, Routing, Module management |
| flutter_bloc | State management |
| dio | REST API client |
| hive | Local NoSQL storage |
| dartz | Functional programming (Either) |
