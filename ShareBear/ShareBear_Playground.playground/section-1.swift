import UIKit

var optionalString: String? = "Hello"
optionalString == nil

var optionalName: String? = nil //"John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}
