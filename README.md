# WMStore
Product catalog with basic cart

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

## Stack

- MVVM
- SwiftUI
- SwiftData
- Async/Await


## Usage

1. Home view (Products)
- Tap on each product to show detail
- Tap on plus button to add one product into cart
- Tap on tree dots button to show categories
- Tap on cart to shor cart view

2. Categories view
- Tap on each category to search products
- Tap in selected category to deselect, and load all product
- Tap on close button to close modal

3. Detail view
- Tap on plus button to add one product into cart
- Tap on close button to close modal
- Rating will be calculated automatically and rounded up (3.5+ will be 4 stars)

4. Cart view
- Tap on delete will remove item from cart
- Tap on stepper will increment or decrement item quantity (1-10 allowed)
- Total will be calculated automatically
- No action for purchase button

## Requirements

- iOS 17
- Xcode 15.0
- (no extra dependencies required)

## Installation

1. Open WMStore.xcodeproj in Xcode:

2. Run on simulator or device


## Meta

Diego Sepúlveda – [disepulv](https://github.com/disepulv/)

Distributed under the GPL3 license. See ``LICENSE`` for more information.

[https://github.com/disepulv/WMStore](https://github.com/disepulv/WMStore)

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-GPL3-blue.svg
[license-url]: LICENSE
