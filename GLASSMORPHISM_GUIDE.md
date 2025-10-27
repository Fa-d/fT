# Glassmorphism Design Guide

## What is Glassmorphism?

Glassmorphism is a modern UI design trend that creates a frosted glass effect. It's characterized by:
- **Blur effects** (using BackdropFilter)
- **Semi-transparent backgrounds**
- **Subtle borders**
- **Layered depth**
- **Popular in iOS and macOS** design

## What's Been Added

### 1. Glassmorphic Widgets (`lib/core/utils/glassmorphic_container.dart`)

**GlassmorphicContainer**
- Base widget for creating frosted glass effects
- Customizable blur, colors, borders
- Works in light and dark modes

**GlassmorphicCard**
- Pre-configured card with glass effect
- Automatic theme adaptation
- Optional onTap for interactivity

**GlassmorphicAppBar**
- Frosted glass app bar
- Blurred background
- Transparent with gradient overlay

**GlassmorphicBottomSheet**
- Modal bottom sheet with glass effect
- Static show() method for easy use

### 2. User Detail Page with Glassmorphism (`user_detail_page_glass.dart`)

Features:
- Beautiful gradient background
- Animated blur circles for depth
- Glass cards for all information
- Hero animation for avatar
- Glowing avatar effect
- Interactive glass buttons
- Smooth iOS/macOS feel

## How to Use Glassmorphic Widgets

### Basic Container

```dart
GlassmorphicContainer(
  width: 200,
  height: 100,
  blur: 15,
  borderRadius: 20,
  color: Colors.white,
  child: Text('Hello Glass!'),
)
```

### Glass Card

```dart
GlassmorphicCard(
  padding: EdgeInsets.all(16),
  onTap: () => print('Tapped!'),
  child: Column(
    children: [
      Text('Title'),
      Text('Content'),
    ],
  ),
)
```

### Glass AppBar

```dart
Scaffold(
  extendBodyBehindAppBar: true,  // Important!
  appBar: GlassmorphicAppBar(
    title: Text('My App'),
    blur: 20,
  ),
  body: YourContent(),
)
```

### Glass Bottom Sheet

```dart
GlassmorphicBottomSheet.show(
  context: context,
  height: 300,
  child: YourContent(),
);
```

## The Effect in Action

When you tap on a user card now, you'll see:

### Background
- Gradient with primary/secondary colors
- Animated blur circles in corners
- Creates depth and visual interest

### Cards
- Frosted glass effect
- Content visible through blur
- Subtle border glow
- Semi-transparent background

### Buttons
- Primary buttons: colored glass
- Secondary buttons: white glass
- Interactive ripple effects
- Modern iOS feel

## Technical Details

### BackdropFilter

The key to glassmorphism is `BackdropFilter`:

```dart
ClipRRect(
  child: BackdropFilter(
    filter: ImageFilter.blur(
      sigmaX: 10,
      sigmaY: 10,
    ),
    child: Container(
      // Your content with semi-transparent background
    ),
  ),
)
```

### Color Opacity

For the glass effect:
- Background: 5-15% opacity
- Borders: 10-30% opacity
- Gradients: Multiple opacity layers

### Best Practices

1. **Use with backgrounds**: Glassmorphism needs something to blur
2. **Don't overdo it**: Too much blur is distracting
3. **Accessibility**: Ensure text remains readable
4. **Performance**: Limit backdrop filters (they're expensive)

## Platform Differences

### iOS/macOS
- Native-feeling design
- Works perfectly with system themes
- Smooth animations

### Android
- Works great but less "native"
- May feel more premium
- Good for differentiation

### Web/Desktop
- Full support
- Great for modern web apps
- Professional look

## Examples in the App

### User List → User Detail

1. Tap any user in the list
2. Detail page opens with glassmorphism
3. Notice:
   - Blurred gradient background
   - Glass cards for contact info
   - Smooth hero animation
   - Interactive glass buttons
   - Glowing avatar effect

### Compare Styles

We kept both versions:
- `/users/detail` → **Glassmorphic** (default, iOS/macOS style)
- `/users/detail-classic` → Classic Material Design

You can switch between them in the router!

## Customization

### Change Blur Intensity

```dart
GlassmorphicContainer(
  blur: 5.0,   // Light blur
  blur: 15.0,  // Medium blur (default)
  blur: 30.0,  // Heavy blur
)
```

### Change Colors

```dart
GlassmorphicContainer(
  color: Colors.blue,       // Blue-tinted glass
  borderColor: Colors.cyan, // Cyan border
)
```

### Custom Gradients

```dart
GlassmorphicContainer(
  gradient: LinearGradient(
    colors: [
      Colors.purple.withOpacity(0.2),
      Colors.pink.withOpacity(0.1),
    ],
  ),
)
```

## Performance Tips

1. **Limit nested blurs**: Each BackdropFilter is expensive
2. **Use sparingly**: Don't blur everything
3. **Test on devices**: Emulators may lag
4. **Consider alternatives**: Regular transparency for less critical areas

## When to Use Glassmorphism

### ✅ Good Use Cases
- Premium apps
- iOS/macOS apps
- Modal dialogs
- Cards with rich backgrounds
- Headers/navigation
- Overlays

### ❌ Avoid For
- Text-heavy content
- Performance-critical views
- Simple list items
- When accessibility is crucial
- Low-end devices

## Deprecation Warnings

You may see warnings about `withOpacity`. These are just info-level warnings for newer Flutter versions. The code works perfectly!

To future-proof, you can replace:
```dart
// Old (works but deprecated)
Colors.white.withOpacity(0.1)

// New (recommended)
Colors.white.withAlpha((0.1 * 255).toInt())
```

But this is optional for now!

## Resources

- [Glassmorphism.com](https://glassmorphism.com/) - Design generator
- [UI Glass Generator](https://ui.glass/generator/) - CSS/Flutter
- Apple Human Interface Guidelines - See system materials

## Next Steps

Try creating your own glassmorphic widgets:
1. Glassmorphic dialog
2. Glassmorphic navigation bar
3. Glassmorphic settings panel
4. Glassmorphic cards with images

The widgets are reusable - use them anywhere!

---

**Enjoy your modern iOS/macOS-style glassmorphism!** ✨

