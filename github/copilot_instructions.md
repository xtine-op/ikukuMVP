# i-Kuku Mobile App Development Guidelines

This document outlines best practices and a scalable project structure for developing 
**i-Kuku**, a mobile app for poultry farm management built using **Flutter** and **Supabase**. 
---

## Tech Stack

- **Flutter** for cross-platform mobile development 
- **Supabase** as backend (database, authentication, and storage) 
- **Riverpod** for state management (or Bloc, depending on preference)
- **Firebase Messaging** (optional for push notifications)
- **GetIt** for lightweight dependency injection (optional)

---

## Project Structure (Feature-First)

```
lib/
│
├── shared/                     # Shared resources and logic
│   ├── constants/            # App-wide constants (colors, keys, etc.)
│   ├── services/             # API, Supabase, and utility services
│   ├── widgets/              # Reusable UI widgets
│   └── utils/                # Helpers, formatters, validators

├── features/                 # Feature-first structure
│   ├── auth/                 # Login, signup, session handling
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── batches/              # Batch creation, viewing, editing
│   ├── records/              # Daily records entry and viewing
│   ├── inventory/            # Feeds, vaccines, and medicine tracking
│   ├── dashboard/            # Home page, stats, summaries
│   └── info/                 # Blog, tips, educational content

├── routing/                  # App routing logic (e.g., GoRouter or auto_route)
├── theme/                    # App theme setup
├── main.dart                 # Entry point
└── app.dart                  # Main app widget
```

---

## Best Practices

### Supabase Integration

- Use **Supabase client** as a singleton service inside `shared/services/supabase_service.dart`.
- Secure all database operations with **Row Level Security (RLS)** policies.
- Store `user.uid` securely and pass it as part of DB queries.

### State Management

- Use **Riverpod** or **Bloc** for scalable and testable state flows.
- Separate business logic (use cases) from UI.
- Keep UI reactive to changes in state only.

### UI & Navigation

- Use `GoRouter` or `auto_route` for clean navigation.
- Maintain design consistency by using custom components inside `shared/widgets/`.
- Prefer `LayoutBuilder` and responsive design patterns to support all screen sizes.

### Testing

- Add unit tests for each feature module inside `test/features/`.
- Use mock Supabase or local data to test DB interactions.

### Clean Architecture Tips

- **Presentation layer**: Widgets, pages, view models
- **Domain layer**: Use cases and business logic
- **Data layer**: Supabase queries, model conversions, DTOs

### Localization

- Use Flutter’s localization to support Swahili and English.
- Keep all strings in `shared/constants/app_strings.dart`.

### Date Handling

- Use `intl` package to format dates consistently.
- Store dates in UTC in the backend and format on frontend.

---

## Authentication Practices

- Persist login state using Supabase's session handling.
- Create a `SessionManager` in `auth` to handle token refresh and auto-login.

---

##  Deployment & Git

- Use **.env** or Flutter `.dart-define` for storing Supabase keys securely.
- Commit code to GitHub with proper versioning.
- Create PRs and document major changes via README updates.

---

## Future Considerations

- Add offline support using `hive` or `isar`.
- Use `flutter_native_splash` for branded launch screens.
- Add app monitoring tools (e.g., Sentry or Firebase Crashlytics).

---

##  Final Tips

- Build in **small vertical slices** (feature-by-feature).
- Keep code **modular and testable**.
- Always **document feature logic** for future contributors.
