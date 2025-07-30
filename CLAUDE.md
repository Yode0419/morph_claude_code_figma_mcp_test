# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application for an inspection management system called "Morph" that implements a daily schedule page with calendar functionality and task management. The app is built with a Figma design-to-code approach, currently using dummy data with a planned transition to API integration.

## Development Commands

### Essential Commands
```bash
# Install dependencies
flutter pub get

# Run the application
flutter run

# Build for different platforms
flutter build apk                    # Android APK
flutter build ios                    # iOS
flutter build web                    # Web

# Clean build artifacts
flutter clean

# Check for dependency updates
flutter pub outdated

# Analyze code for issues
flutter analyze
```

### Testing Commands
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

## Architecture Overview

### State Management Pattern
The app uses **Provider pattern** for state management with three main providers:
- `CalendarProvider` - Manages date selection and calendar navigation
- `TaskProvider` - Handles task CRUD operations and filtering
- `UserProvider` - Manages user data and premium status

All providers are initialized in `main.dart` using `MultiProvider`.

### Data Flow Architecture
1. **Models** (`lib/models/`) define data structures (Task, User, CalendarDay)
2. **Providers** (`lib/providers/`) manage state and business logic
3. **Widgets** (`lib/widgets/`) are pure UI components that consume provider data
4. **Screens** (`lib/screens/`) orchestrate widgets and handle user interactions

### Key Design Patterns
- **Consumer Pattern**: Widgets use `Consumer<T>` to listen to provider changes
- **Composition over Inheritance**: UI built from small, reusable widgets
- **Separation of Concerns**: UI, business logic, and data models are clearly separated

## Current Implementation Status

### Dummy Data Implementation
The app currently uses hardcoded dummy data:
- **Tasks**: 5 sample tasks on July 1st and 4th, 2025
- **User**: Sample user with 3/5 reports used
- **Calendar**: Defaults to July 2025 to show dummy tasks

### Task Status Workflow
Tasks follow a specific status progression:
```
Booked → Pre-Inspection → Under Inspection → Completed
```
Each status has:
- Unique color coding (Yellow → Light Blue → Blue → Gray)
- Specific action button text (Setup → Start → Continue → Report)

### Key Components Architecture

#### CalendarHeader Widget
- Manages month navigation and week view
- Shows task indicators (blue dots) on dates with tasks
- Handles date selection with visual feedback

#### TaskCard Widget
- Displays task information with status-based styling
- Integrates with `url_launcher` for navigation and phone calls
- Dynamic action buttons based on task status

#### Provider Integration
- `TaskProvider.getTasksForDate()` filters tasks by selected date
- `CalendarProvider.selectDate()` triggers UI updates across components
- `UserProvider` manages usage limits and premium status

## Development Workflow

### Adding New Features
1. Define data models in `lib/models/` if needed
2. Update relevant provider with new state/methods
3. Create/modify widgets in `lib/widgets/`
4. Update screen components in `lib/screens/`
5. Test provider logic and widget interactions

### Working with Tasks
- Task creation flows through `TaskProvider.addTask()`
- Status updates use `TaskProvider.updateTaskStatus()`
- Date filtering happens automatically when calendar date changes

### Theme and Styling
- Global theme defined in `lib/theme/app_theme.dart`
- Color constants in `lib/utils/colors.dart`
- Status-based colors managed by `AppColors.getStatusColor()`

### Date Handling
- Uses `intl` package for formatting
- Custom utilities in `lib/utils/date_utils.dart`
- Calendar logic handles week views and date comparisons

## Production Transition Notes

When moving from dummy data to API integration:
1. Replace provider initialization methods (`_initializeDummyData()`) with API calls
2. Add error handling and loading states to providers
3. Implement proper data persistence
4. Add authentication and user management
5. Convert hardcoded dates to dynamic current date logic

The current architecture is designed to make this transition seamless - providers abstract data sources from UI components.