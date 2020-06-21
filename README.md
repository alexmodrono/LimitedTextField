# LimitedTextField

A simple TextField with a maximum lenght, for SwiftUI.

![Demo](./LimitedTextField.gif)

## Installation
Installing LimitedTextField is a really straight-forward process. All you need to do is:

1. Go to `File -> Swift Packages -> Add Package Dependency`.

2. Paste this project's url `https://github.com/iAlex11/LimitedTextField`.

3. Enjoy!

## Usage example
Implementing LimitedTextField in your project is as simple as adding 1 line of code (yes, just **one** line of code) to your SwiftUI view.

```swift
LimitedTextField()
```

### Adjusting the maximum length
You can easily adjust the maximum length allowed thanks to the `.count()` function.

```swift
LimitedTextField()
  .count(/* The max length */)
```

### Word count
There might be ocassions where you may want to have a limit for the amount of words, and not be conditioned by the amount of characters. You can achieve this easily by using `.byWord()`.

```swift
LimitedTextField()
  .counter(.byWord(5))
```

### Styling
LimitedTextField is just a simple TextField without styling, so you can style it easily.

```swift
LimitedTextField()
  .padding()
  .background(
    Color(.systemGray5)
      .cornerRadius(5.0)
    )
```

## Contributing
In the nature of open-source, any pull-request is welcome. Simply open a pull-request and I'll be happy to merge it.

## Disclaimer

Distributed under the GPLv3 license. See LICENSE for more information.

## About

Coded with ❤️ by Alejandro Modroño 🇪🇸 – hello@amodrono.com
