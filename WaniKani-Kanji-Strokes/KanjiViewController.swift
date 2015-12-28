//
//  KanjiViewController.swift
//  WaniKani-Kanji-Strokes
//
//  Created by Andriy K. on 12/28/15.
//  Copyright © 2015 Andriy K. All rights reserved.
//

import UIKit
import StrokeDrawingView

class KanjiViewController: UIViewController {
  
  @IBOutlet weak var strokeDrawingView: StrokeDrawingView! {
    didSet {
      strokeDrawingView?.delegate = self
      if let kanji = kanji {
        strokeDrawingView?.dataSource = kanji
      }
    }
  }
  
  var kanji: Kanji? {
    didSet {
      guard let kanji = kanji else { return }
      strokeDrawingView?.stopForeverAnimation()
      strokeDrawingView?.clean()
      strokeDrawingView?.dataSource = kanji
    }
  }
  
}

extension KanjiViewController: StrokeDrawingViewDataDelegate {
  
  func layersAreNowReadyForAnimation() {
    self.strokeDrawingView.playForever(1.5)
  }
}

func delay(delay: Double, closure: () -> Void) {
  dispatch_after(
    dispatch_time(
      DISPATCH_TIME_NOW,
      Int64(delay * Double(NSEC_PER_SEC))
    ),
    dispatch_get_main_queue(), closure)
}


extension Kanji: StrokeDrawingViewDataSource {
  func sizeOfDrawing() -> CGSize {
    return CGSize(width: 109, height: 109)
  }
  
  func numberOfStrokes() -> Int {
    return bezierPathes.count
  }
  
  func pathForIndex(index: Int) -> UIBezierPath {
    let path = bezierPathes[index]
    path.lineWidth = 3
    return path
  }
  
  func animationDurationForStroke(index: Int) -> CFTimeInterval {
    return 0.6
  }
  
  func colorForStrokeAtIndex(index: Int) -> UIColor {
    return color0
  }
  
  func colorForUnderlineStrokes() -> UIColor? {
    return UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 0.5)
  }
}