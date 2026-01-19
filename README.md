# One Year - iOS Progress Tracker

A beautiful iOS app and widget that visualizes your progress through the year using dots. Each day is represented by a dot, and as the year progresses, the dots light up to show how far you've come.

## Features

- **Beautiful Dot Grid Visualization**: 365 (or 366 in leap years) dots arranged in a grid
- **Real-time Progress**: Automatically updates each day to show your progress
- **iOS Widget Support**: Add the widget to your home screen for at-a-glance progress
- **Multiple Widget Sizes**: Supports small and medium widget sizes
- **Elegant Design**: Dark theme with gradient background matching your reference image

## Project Structure

```
OneYear/
├── OneYear/
│   ├── App/
│   │   ├── OneYearApp.swift          # Main app entry point
│   │   ├── ContentView.swift         # Main app UI
│   │   └── Info.plist               # App configuration
│   ├── Shared/
│   │   ├── YearProgressCalculator.swift  # Progress calculation logic
│   │   └── YearProgressView.swift        # Dot grid visualization
│   └── Widget/
│       ├── OneYearWidget.swift      # Widget implementation
│       └── Info.plist               # Widget configuration
└── OneYear.xcodeproj/               # Xcode project file
```

## Requirements

- iOS 14.0 or later
- Xcode 14.0 or later
- Swift 5.0 or later

## Setup Instructions

### 1. Open the Project

1. Open `OneYear.xcodeproj` in Xcode
2. Wait for Xcode to index the project

### 2. Configure Code Signing

1. Select the `OneYear` target in the project navigator
2. Go to the "Signing & Capabilities" tab
3. Select your development team
4. Repeat for the `OneYearWidget` target

### 3. Update Bundle Identifier (Optional)

If needed, update the bundle identifiers:
- Main app: `com.yourcompany.OneYear`
- Widget: `com.yourcompany.OneYear.OneYearWidget`

### 4. Build and Run

1. Select a simulator or your iPhone as the target device
2. Press `Cmd + R` to build and run
3. The app will launch showing the year progress visualization

### 5. Add the Widget to Your Home Screen

1. Long-press on your home screen to enter edit mode
2. Tap the "+" button in the top-left corner
3. Search for "One Year"
4. Select either the small or medium widget size
5. Tap "Add Widget"
6. Position the widget and exit edit mode

## How It Works

### Year Progress Calculation

The `YearProgressCalculator` class:
- Determines the current day of the year (1-365 or 1-366)
- Calculates total days in the current year (handles leap years)
- Computes percentage complete and days remaining
- Updates automatically at midnight each day

### Dot Grid Visualization

The `YearProgressView`:
- Displays 19 columns of dots
- Rows adjust automatically based on total days (365/366)
- Lit dots (white) represent completed days
- Dimmed dots (gray) represent upcoming days
- Each dot is spaced evenly with a clean, minimal design

### Widget Updates

The widget:
- Updates automatically at midnight each day
- Uses WidgetKit's timeline system for efficient battery usage
- Shares code with the main app for consistency
- Supports small and medium sizes

## Customization

### Changing Colors

Edit the gradient colors in `ContentView.swift` and `OneYearWidget.swift`:

```swift
LinearGradient(
    gradient: Gradient(colors: [
        Color(red: 0.4, green: 0.3, blue: 0.3),
        Color(red: 0.2, green: 0.15, blue: 0.15)
    ]),
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)
```

### Adjusting Dot Appearance

Modify `YearProgressView.swift`:

```swift
private let columns = 19        // Number of columns
private let dotSize: CGFloat = 5  // Dot diameter
private let spacing: CGFloat = 8  // Space between dots
```

### Changing Lit/Unlit Colors

Edit the `DotView` in `YearProgressView.swift`:

```swift
Circle()
    .fill(isLit ? Color.white : Color.white.opacity(0.15))
```

## Testing

### Test Different Days

Temporarily modify the date in `YearProgressCalculator.swift`:

```swift
// For testing: simulate a specific day
let now = Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 19))!
```

### Test Leap Years

Create a date in a leap year (2024, 2028, etc.) to verify 366 dots appear.

## Troubleshooting

### Widget Not Appearing

1. Ensure both the app and widget targets build successfully
2. Run the app at least once on your device
3. Restart your device if the widget doesn't appear in the widget gallery

### Incorrect Day Count

Verify your device's date and time settings are correct. The app uses the system calendar.

### Build Errors

1. Clean the build folder: `Cmd + Shift + K`
2. Delete derived data: `Cmd + Shift + Option + K`
3. Restart Xcode
4. Ensure you're using Xcode 14.0 or later

## Technologies Used

- **SwiftUI**: Modern declarative UI framework
- **WidgetKit**: iOS widget framework
- **Combine**: Reactive programming for state management
- **Foundation**: Date and calendar calculations

## License

This project is open source and available under the MIT License.

## Credits

Inspired by year progress tracking apps that help visualize the passage of time.

## Future Enhancements

Potential features to add:
- Dark/light mode toggle
- Custom color themes
- Year selection to view past years
- Month view option
- Milestones and important dates
- Haptic feedback
- Interactive widget (iOS 17+)

## Support

If you encounter any issues or have questions, please open an issue on GitHub.

---

**Note**: Make sure to test the widget on an actual device for the best experience, as widgets have limited functionality in the simulator
