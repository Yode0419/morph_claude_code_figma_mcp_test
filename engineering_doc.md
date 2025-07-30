# Daily Schedule Page - Engineering Documentation

## Overview
This document outlines the implementation plan for the Daily Schedule Page based on the Figma design analysis. The page displays a calendar view with daily task scheduling functionality for the Morph inspection management application.

## Technology Stack
- **Framework**: Flutter 3.4.0+
- **Language**: Dart
- **UI Library**: Material Design 3
- **State Management**: Provider (recommended) or Riverpod
- **Date/Time**: Built-in DateTime + intl package
- **HTTP Client**: http package
- **Local Storage**: shared_preferences or hive

## Design Requirements Analysis

### Page Layout Structure
1. **App Header**
   - App title "Morph"
   - User avatar/profile icon
   - Settings/menu icon

2. **Smart Template Banner**
   - Purple gradient background
   - "Smart Template" title
   - "Enhance inspection report with AI" subtitle
   - Dismissible or actionable

3. **Calendar Navigation**
   - Month/year display with navigation arrows
   - Week view showing 7 days
   - Date selection highlighting
   - Visual indicators for days with tasks

4. **Daily Task List**
   - Selected date display
   - Scrollable task cards
   - Status-based styling and actions

5. **Floating Action Button**
   - "+" Job creation button
   - Fixed positioning

6. **Usage Tracking Footer**
   - Reports usage counter
   - Upgrade prompt
   - Reset timer

## Component Architecture

### 1. Main Page Component
```dart
class DailySchedulePage extends StatefulWidget
```
**Responsibilities:**
- Overall page layout and navigation
- Date selection state management
- Task filtering by selected date

### 2. Calendar Header Component
```dart
class CalendarHeader extends StatelessWidget
```
**Responsibilities:**
- Month navigation
- Week view display
- Date selection handling
- Task count indicators

### 3. Task Card Component
```dart
class TaskCard extends StatefulWidget
```
**Responsibilities:**
- Display task information
- Status-based styling
- Action button rendering
- Navigation and communication actions

### 4. Smart Template Banner
```dart
class SmartTemplateBanner extends StatelessWidget
```
**Responsibilities:**
- AI feature promotion
- Banner display and dismissal

### 5. Usage Footer Component
```dart
class UsageFooter extends StatelessWidget
```
**Responsibilities:**
- Usage tracking display
- Upgrade call-to-action

## Data Models

### Task Model
```dart
class Task {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String assignedTo;
  final TaskStatus status;
  final String? phoneNumber;
  final double? latitude;
  final double? longitude;
}
```

### Task Status Enum
```dart
enum TaskStatus {
  booked,
  preInspection,
  underInspection,
  completed
}
```

### Calendar Day Model
```dart
class CalendarDay {
  final DateTime date;
  final List<Task> tasks;
  final bool isSelected;
  final bool isToday;
}
```

## State Management Architecture

### 1. Task Provider
```dart
class TaskProvider extends ChangeNotifier
```
**Responsibilities:**
- Task CRUD operations
- Task filtering by date
- Status updates
- API integration

### 2. Calendar Provider
```dart
class CalendarProvider extends ChangeNotifier
```
**Responsibilities:**
- Date selection
- Month navigation
- Calendar view state

### 3. User Provider
```dart
class UserProvider extends ChangeNotifier
```
**Responsibilities:**
- User profile data
- Usage tracking
- Subscription status

## API Requirements

### Endpoints Needed

1. **GET /api/tasks**
   - Query parameters: date_from, date_to
   - Returns: Task list for date range

2. **GET /api/tasks/{task_id}**
   - Returns: Single task details

3. **POST /api/tasks**
   - Body: Task creation data
   - Returns: Created task

4. **PUT /api/tasks/{task_id}**
   - Body: Task update data
   - Returns: Updated task

5. **PATCH /api/tasks/{task_id}/status**
   - Body: { status: TaskStatus }
   - Returns: Updated task

6. **GET /api/user/usage**
   - Returns: Usage statistics and limits

### Response Models

```json
{
  "task": {
    "id": "string",
    "start_time": "2025-07-04T13:00:00Z",
    "end_time": "2025-07-04T15:00:00Z",
    "address": "789 Mission Street",
    "city": "San Francisco",
    "state": "CA",
    "zip_code": "94103",
    "assigned_to": "Jessica Miller",
    "status": "under_inspection",
    "phone_number": "+1234567890",
    "latitude": 37.7749,
    "longitude": -122.4194
  }
}
```

## UI Styling Specifications

### Color Scheme
- **Primary Blue**: #4A90E2 (action buttons, selected states)
- **Success Green**: #5CB85C (completed status)
- **Warning Yellow**: #F0AD4E (booked status)
- **Info Blue**: #5BC0DE (pre-inspection status)
- **Purple Gradient**: #8B5CF6 to #3B82F6 (smart template banner)

### Typography
- **Heading**: 18px, Semi-bold
- **Body Text**: 16px, Regular
- **Caption**: 14px, Regular
- **Button Text**: 16px, Medium

### Card Styling
- **Border Radius**: 12px
- **Shadow**: elevation 2
- **Padding**: 16px
- **Margin**: 8px horizontal, 4px vertical

## File Structure

```
lib/
├── main.dart
├── models/
│   ├── task.dart
│   ├── calendar_day.dart
│   └── user.dart
├── providers/
│   ├── task_provider.dart
│   ├── calendar_provider.dart
│   └── user_provider.dart
├── services/
│   ├── api_service.dart
│   └── storage_service.dart
├── screens/
│   └── daily_schedule_page.dart
├── widgets/
│   ├── calendar_header.dart
│   ├── task_card.dart
│   ├── smart_template_banner.dart
│   └── usage_footer.dart
├── utils/
│   ├── constants.dart
│   ├── colors.dart
│   └── date_utils.dart
└── theme/
    └── app_theme.dart
```

## Implementation Phases

### Phase 1: Core Structure (Week 1)
- Set up project dependencies
- Create data models
- Implement basic UI layout
- Add mock data

### Phase 2: Calendar Integration (Week 2)
- Implement calendar header component
- Add date selection functionality
- Create task filtering logic
- Add navigation between months

### Phase 3: Task Management (Week 3)
- Implement task card components
- Add status-based styling
- Create action buttons functionality
- Add task creation flow

### Phase 4: API Integration (Week 4)
- Implement API service layer
- Connect providers to API
- Add error handling
- Implement offline capabilities

### Phase 5: Polish & Testing (Week 5)
- Add animations and transitions
- Implement usage tracking
- Add comprehensive testing
- Performance optimization

## Dependencies Required

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  http: ^1.1.0
  intl: ^0.18.1
  shared_preferences: ^2.2.2
  cached_network_image: ^3.3.0
  url_launcher: ^6.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.2
  build_runner: ^2.4.7
```

## Testing Strategy

### Unit Tests
- Model validation
- Provider state management
- Utility functions
- Date calculations

### Widget Tests
- Component rendering
- User interactions
- State changes
- Navigation flows

### Integration Tests
- API integration
- End-to-end workflows
- Performance testing
- Accessibility testing

## Performance Considerations

1. **List Optimization**: Use ListView.builder for task lists
2. **Image Caching**: Cache user avatars and icons
3. **State Management**: Minimize provider rebuilds
4. **API Calls**: Cache and batch requests
5. **Memory Management**: Dispose controllers properly

## Accessibility Requirements

1. **Screen Reader Support**: Semantic labels for all interactive elements
2. **High Contrast**: Support system dark/light themes
3. **Touch Targets**: Minimum 44px touch targets
4. **Focus Management**: Proper tab order and focus indication
5. **Text Scaling**: Support dynamic text sizing

## Security Considerations

1. **Data Validation**: Validate all user inputs
2. **API Security**: Implement proper authentication
3. **Local Storage**: Encrypt sensitive data
4. **Network**: Use HTTPS for all API calls
5. **Permissions**: Request minimal required permissions