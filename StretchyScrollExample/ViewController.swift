//
//  ViewController.swift
//  StretchyScrollExample
//
//  Created by Sergey Petrachkov on 07/09/2018.
//  Copyright © 2018 Sergey Petrachkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
  
  let scrollContainer: UIScrollView = {
    let view = UIScrollView()
    view.frame = CGRect(x: 10, y: 70, width: 365, height: 60)
    view.backgroundColor = UIColor.clear
    return view
  }()
  
  let node: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 60))
    view.backgroundColor = .red
    return view
  }()
  
  let hintImageView: UIImageView = {
    let view = UIImageView()
    view.image = #imageLiteral(resourceName: "image")
    view.frame = CGRect(origin: CGPoint(x: 10, y: 70), size: SwipeToEditParameters.minImageSize)
    view.contentMode = .scaleAspectFill
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.hintImageView)
    self.view.addSubview(self.scrollContainer)
    self.scrollContainer.addSubview(self.node)
    
    self.scrollContainer.delegate = self
    self.scrollContainer.alwaysBounceHorizontal = true
    self.hintImageView.frame = CGRect(origin: CGPoint(x: 10, y: 70 + (self.scrollContainer.frame.size.height - SwipeToEditParameters.minImageSize.height)/2), size: SwipeToEditParameters.minImageSize)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  var shouldInvokeEdit: Bool = false
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    self.shouldInvokeEdit = false
  }
  
  
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
    
    
    if scrollView.contentOffset.x < -SwipeToEditParameters.swipeThreshhold, !self.shouldInvokeEdit {
      if #available(iOS 10.0, *) {
        let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        lightImpactFeedbackGenerator.impactOccurred()
      }
      self.shouldInvokeEdit = true
    }
  }
}

enum SwipeToEditParameters {
  static let initialScalingFactor: CGFloat = 0.6
  static let maxScalingFactor: CGFloat = 1.0
  
  static let maxImageSize = SwipeToEditParameters.editImageSize.applying(CGAffineTransform(scaleX: SwipeToEditParameters.maxScalingFactor, y: SwipeToEditParameters.maxScalingFactor))
  static let minImageSize = SwipeToEditParameters.editImageSize.applying(CGAffineTransform(scaleX: SwipeToEditParameters.initialScalingFactor, y: SwipeToEditParameters.initialScalingFactor))
  
  static let swipeThreshhold: CGFloat = 40
  
  
  static let editImageSize: CGSize = CGSize(width: 40, height: 40)
}
