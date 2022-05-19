# WishList App
Test assignment for Senior iOS Developer role @ Tiqets.

## Approach

A "vanilla" UIKit app with composable collection view backed by diffable data source.

All data is fetched by the `NetworkManager`, and wish list entries are persisted locally in the `Store`.

The app does not use interface builder, so `UIViewController` and `UIView` are subclassed and `required init?(coder: NSCoder)` is made unavailable.

Tried really hard to comply with the "don't over-engineer!" part of the assignment 😅, so some parts of the app are more fleshed out than others. Spent a large chunk of time on the UI work, so things like Dark Mode, Dynamic Type and layouts are solid, and network management, caching and persistence are simple as they depend on the full scope of the app.

Things I'd do differently in a real-life project:
* Work with the backend team to make sure all of the connectivity edge cases are covered, as well as things like caching and offline use cases
* Work with the design team on integrating a design system / theme into the app (depending on our process – whether designers test out and tweak new features while they are being developed, etc.)
* Move key logic components into separate framework targets or packages for better separation of concerns, access control and testing
* Add testing. This usually depends on the time budget, but for complex modules with a lot of state I usually add testing from the get-go
* Add view models for key view controllers, usually in a separate file (e.g. `OfferingVC+ViewModel`)
* Add more extensions to deal with repetitive boilerplate (hello `stackView.addArrangedSubview`). But not so much as to confuse future team members and have them learn a new UI framwork 😀
* Add more documentation, especially in team context

## Known issues

* UILayer's `adjustsFontForContentSizeCategory` is bugged (works correctly for visible cells, but has old sizes for reused cells)
* "Position and size are ambiguous" issues when debugging view hierarchy (maybe an Apple bug as there are no complaints in debugger and all views behave as expected)
* When using `UIRefreshControl` for pull to refresh, navigation bar's title sometimes goes over content

## Demo

https://user-images.githubusercontent.com/3962114/169287845-c3c06df0-082c-4c5c-bbd3-da18807fff89.mp4
