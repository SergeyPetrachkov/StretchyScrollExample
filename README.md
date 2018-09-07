# StretchyScrollExample

Here is an example of how to implement scroll to reply with feedback (telegram like) and add stretchy hint button to it.

To invoke vibration feedback use: 

```Swift4
if #available(iOS 10.0, *) {
        let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        lightImpactFeedbackGenerator.impactOccurred()
      }
```

Stretchy button:

```Swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let scrollScaling = scrollView.contentOffset.x / SwipeToEditParameters.maxImageSize.height
    var newSize = CGSize(width: SwipeToEditParameters.maxImageSize.width*abs(scrollScaling), height: SwipeToEditParameters.maxImageSize.height*abs(scrollScaling))
    if newSize.height > SwipeToEditParameters.maxImageSize.height {
      newSize = SwipeToEditParameters.maxImageSize
    }
    if newSize.height < SwipeToEditParameters.minImageSize.height {
      newSize = SwipeToEditParameters.minImageSize
    }
    UIView.animate(withDuration: 0.1, animations: {
      self.hintImageView.frame = CGRect(origin: CGPoint(x: 10, y: 70 + (self.scrollContainer.frame.size.height - newSize.height)/2), size: newSize)
    })
```

We define min and max size of image view.
We change current size according to scroll view x offset divided by max size dimension
