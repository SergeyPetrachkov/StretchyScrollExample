# StretchyScrollExample

Here is an example of how to implement scroll to reply with feedback (telegram like) and add stretchy hint button to it.

To invoke vibration feedback use: 

```Swift4
if #available(iOS 10.0, *) {
        let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        lightImpactFeedbackGenerator.impactOccurred()
      }
```

