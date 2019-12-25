# SimpleKeyboard

The idea of this package came from a keyboard-extension and the fact that - AFAIK - one can't open another keyboard within a keyboard-extension. So the goal was to have a ViewController, that simply displays the keyboard and changes a `text` variable. 

## Components
This  project includes a `SimpleKeyboard` that takes a custom 2D-list of Strings which will be rendered as the keys.
The `SimpleStandardKeyboard` provides a default implementation for some languages and a few more default settings.

## Usage
To eventually get a `UIViewController` it's super easy to use `UIHostingController`. Depending on the needs one can use the keyboards in a larger SwiftUI enviroment with a `Text` that will act as the TextField. 
Or one can choose to only display the keyboard with a the text input coming from a UIKit enviroment. To manage the transition with all the Bindings, there is the `KeyboardSettings: Observable`. 

Here is an example implementation from one of my projects:
```swift
struct MyKeyboardMaker{
    
    @ObservedObject var settings: KeyboardSettings
    
    func makeViewController()-> UIHostingController<SimpleStandardKeyboard>{
        UIHostingController(rootView: SimpleStandardKeyboard(language: settings.language, text: $settings.text, action: settings.action))
    }
}
```

When initializing a new object of that struct, one has to pass the language and textField. Now `makeViewController()` can be called e.g. pushed onto a NavigationController.  

