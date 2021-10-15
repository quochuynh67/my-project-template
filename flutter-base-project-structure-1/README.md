- support multiple language using flutter intl
- support change Dark/Light mode, by running:
In the widget which extend from BaseStateBloc :
```dart
  setTheme(ThemeData.light());
  setTheme(ThemeData.dark());
```