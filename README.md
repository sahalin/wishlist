# WishList App
Test assignment for Senior iOS Developer role @ Tiqets.

## Considerations

### UIKit app with composable collection views, backed by diffable data source

### Created a UIViewController subclass `WLViewController`

I'm usually wary of subclassing and prefer composition, but for simple cases... 

### Put all components in target folder

To comply with "don't over-engineer!" part of the assignment 😅 In a real project I'd split into separate folders and targets or packages for better separation of concerns and testing.

### Model layer

All data is fetched with the `NetworkManager`, and wish list entries are persisted locally in the `Store`. 

### Known issues

* UILayer's `adjustsFontForContentSizeCategory` is bugged
