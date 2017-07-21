# PickerView

## Requirements

It requires `iOS 8.0+`  and `Swift 3.0+` .


## Installation

### Manually

You can install it manually just draging [PickerView](https://github.com/Memory2014/PickerView/tree/master/ZYPickerView/PickerView) to your project. 

## Usage

### From Code

Create a new `PickerView`.

**TextPicker**:
```swift
        let view = ZYPickerView.init(title: "select something")
        view.pickerStyle = .Text
        view.titlesForComponents = [["1","2","3"],["one","two","three","four","five"],["😀","😃","🙂","😜","😊"]]
        view.doneAction = { item in
            print(item)
        }
        view.show()
```

or
**DatePicker**:
```swift
       let view = ZYPickerView.init(title: "select date")
        view.pickerStyle = .Date
        view.doneAction = { date in
            print(date)
        }
        view.show()
```
And this is all.


## Custom Appearance

you can customize the PickerView appearance .
```swift
//        view.toobarTitleTextColor = .red
//        view.toobarTitleFont = UIFont.systemFont(ofSize: 20)
//        view.toobarTintColor = UIColor.orange
//        view.toobarTextColor = .white
//        view.pickerStyle = .Text
//        view.textColor = .green
//        view.font = UIFont.systemFont(ofSize: 25)
//        view.widthsForComponents = [40,40,50]
```

## License

PickerView is available under the MIT license. See the LICENSE file for more info.
