# Flutter Task: Weather App Using Feature-Based Full Clean Architecture

## Objective

Build a production-style **Weather App** using Flutter to demonstrate **feature-based full Clean Architecture**, API integration, state management, routing, localization, dynamic theming, and persisted user preferences.

## Required Stack

The app must use:

* Feature-based Full Clean Architecture
* Every feature must contain its own `data`, `domain`, and `presentation` layers
* Dependency injection must be handled using `GetIt` with `injectable`
* GoRouter
* Dio
* FPDart
* Cubit
* HydratedCubit
* Freezed
* Flutter official localization using `gen-l10n`

## API

Use a real weather API, preferably **Open-Meteo**, because it does not require an API key.

The app should display:

* Current temperature
* Weather condition
* Min/max temperature
* Wind speed
* Humidity if available
* Daily forecast
* Hourly forecast if implemented

## Required Screens

The app must include:

1. **Splash Screen**

   * Restore saved language and theme
   * Initialize app settings
   * Navigate to Weather Home

2. **Weather Home Screen**

   * Display current weather
   * Search for a city
   * Refresh weather
   * Show loading, success, empty, and error states
   * Navigate to details and settings

3. **Weather Details Screen**

   * Show detailed weather data
   * Show forecast cards

4. **Settings Screen**

   * Switch language between English and Arabic
   * Switch theme between Light, Dark, and System
   * Persist theme and language using HydratedCubit

## Mandatory Architecture Rule

The project must use **feature-based Clean Architecture**, not a layer-first structure.

The app should be structured like this:

```text
lib/
├── core/                               # App-wide infrastructure and utilities only
│   ├── constants/
│   │   └── app_constants.dart
│   ├── di/
│   │   ├── injection.dart
│   │   └── injection.config.dart
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── localization/
│   │   ├── locale_keys.dart            # Optional helper/constants only
│   │   └── localization_extensions.dart
│   ├── network/
│   │   ├── api_client.dart             # Dio instance and base configuration
│   │   ├── network_info.dart           # Connectivity checker
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart
│   │       ├── error_interceptor.dart
│   │       └── logging_interceptor.dart
│   ├── routes/
│   │   ├── app_router.dart             # GoRouter configuration
│   │   └── route_names.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   └── utils/
│       ├── helpers.dart
│       └── validators.dart
│
├── l10n/                               # Flutter official localization files
│   ├── app_en.arb
│   └── app_ar.arb
│
├── features/
│   ├── splash/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── cubit/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── weather/
│   │   ├── data/
│   │   │   ├── data_sources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── cubit/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   └── settings/
│       ├── data/
│       ├── domain/
│       └── presentation/
│           ├── cubit/
│           ├── screens/
│           └── widgets/
│
└── shared/                             # Shared feature for cross-feature reusable flows
    ├── data/
    │   ├── models/
    │   │   └── user_model.dart
    │   ├── data_sources/
    │   │   ├── auth_local_data_source.dart
    │   │   └── auth_remote_data_source.dart
    │   └── repositories/
    │       └── auth_repository_impl.dart
    ├── domain/
    │   ├── entities/
    │   │   └── user.dart
    │   ├── repositories/
    │   │   └── auth_repository.dart
    │   └── usecases/
    │       ├── get_current_user.dart
    │       └── logout.dart
    └── presentation/
        └── widgets/
            ├── app_bar_widget.dart
            ├── loading_widget.dart
            ├── empty_widget.dart
            └── error_widget.dart
```

All business flow must pass through:

```text
Cubit → UseCase → Repository Contract → Repository Implementation → Data Source
```

## Core Folder - App-Wide Infrastructure

The `core/` folder must exist for app-wide shared infrastructure and utilities.

Use `core/` for code that is not owned by a specific feature and does not contain feature business logic.

Allowed inside `core/`:

* App constants
* Dependency injection setup
* Failure and exception base classes
* Dio client setup
* Network connectivity checker
* Dio interceptors
* GoRouter configuration
* Route names
* App theme
* App colors
* App text styles
* Localization helpers/extensions
* Generic validators
* Generic helpers

Not allowed inside `core/`:

* Feature-specific Cubits
* Feature-specific entities
* Feature-specific models
* Feature-specific repositories
* Feature-specific use cases
* Feature-specific data sources
* Weather business logic
* Settings business logic
* UI widgets that belong to one feature only

Important distinction:

* `core/` is for app-wide infrastructure.
* `shared/` is a shared Clean Architecture feature.
* `features/` contains normal product features such as weather, settings, and splash.

## Shared Folder - Shared Feature for Cross-Feature Reusables

The project must include a `shared/` folder, but it must be treated as a **shared feature**, not as a random utility folder.

The `shared/` feature must follow the same Clean Architecture structure:

```text
shared/
├── data/
├── domain/
└── presentation/
```

Use `shared/` only for logic, entities, repositories, use cases, data sources, and widgets that are reused across multiple features.

Allowed examples inside `shared/`:

* Shared authentication flow
* Current user entity/model
* Get current user use case
* Logout use case
* Shared local data source
* Shared remote data source
* Shared repository contracts and implementations
* Shared presentation widgets such as loading, error, empty state, and app bar widgets

Not allowed inside `shared/`:

* Feature-specific weather Cubits
* Feature-specific weather use cases
* Feature-specific weather repositories
* Feature-specific weather data sources
* Feature-specific weather models or entities
* Any business logic that belongs only to one feature

Feature-specific code must stay inside its own feature folder.

## Main Architecture Rules

* The app must be organized by feature first, then by layer.
* Do not create global `data`, `domain`, or `presentation` folders that contain all app features.
* `core/` is allowed only for app-wide infrastructure such as routing, theme, localization helpers, errors, network, dependency injection, constants, and utilities.
* `shared/` must be treated as a Clean Architecture feature for cross-feature reusable flows and components.
* Domain layer must be pure Dart.
* Repository contracts must be inside the domain layer.
* Use cases must be inside the domain layer.
* Dio calls must exist only inside remote data sources.
* JSON parsing must exist only inside models.
* Cubits must call use cases only.
* Dependency registration must use `injectable` annotations and generated GetIt configuration.
* UI must not call repositories, data sources, use cases, or Dio directly.
* API models must not be used directly in presentation.
* Repository methods must return `Either<Failure, Entity>` using FPDart.
* Cubit states must be created using Freezed.

## Dependency Injection Rules

The app must use `GetIt` with `injectable`.

Required rules:

* Register repositories, data sources, use cases, Cubits, Dio client, network info, and shared services through Injectable.
* Use `@injectable`, `@lazySingleton`, `@LazySingleton(as: ContractName)`, or the appropriate Injectable annotation.
* Generated files must be created using `build_runner`.
* UI must receive Cubits through dependency injection.
* Do not manually instantiate repositories, use cases, or data sources inside the UI.

## Localization and Theme

The app must support:

* English
* Arabic
* Runtime language switching
* Runtime theme switching
* Persisted language after restart
* Persisted theme after restart

All visible text must come from localization files. No hardcoded UI strings.

Localization must use Flutter official `gen-l10n`.

The project should include:

```text
lib/l10n/
├── app_en.arb
└── app_ar.arb
```

Do not manually create or edit generated localization files.

## README Required

The project must include a README containing:

* App description
* Packages used
* API used
* Architecture explanation
* Folder structure
* Difference between `core/`, `shared/`, and `features/`
* How to run the app
* How to generate Freezed files
* How to generate Injectable dependency injection files
* How localization is implemented
* Screenshots in English and Arabic
* Screenshots in light and dark mode

## Rejection Checklist

The task should be rejected if:

* Feature-based structure is missing
* `core/` folder is missing for app-wide infrastructure
* `core/` contains feature-specific business logic
* `shared/` folder is missing for cross-feature reusable Clean Architecture code
* `shared/` is used as a random utilities folder instead of a shared Clean Architecture feature
* Domain layer is missing
* Cubit calls Dio directly
* Cubit calls data source directly
* UI calls repository or use case directly
* Use cases are skipped
* Repository contract is placed in data layer
* API models are used directly in UI
* `Either` is not used in repositories
* Freezed is not used for states
* GetIt with Injectable is not used for dependency injection
* Theme or language is not persisted
* Hardcoded visible strings exist in UI

## Final Acceptance

The task is accepted only when the app runs successfully, fetches real weather data, follows feature-based full Clean Architecture, supports English/Arabic, supports light/dark/system theme, persists language and theme, uses `core/` correctly for app-wide infrastructure, uses `shared/` correctly as a shared Clean Architecture feature, and follows this flow:

```text
Cubit → UseCase → Repository Contract → Repository Implementation → Data Source
```
