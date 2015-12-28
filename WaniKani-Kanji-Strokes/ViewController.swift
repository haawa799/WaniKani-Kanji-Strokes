//
//  ViewController.swift
//  WaniKani-Kanji-Strokes
//
//  Created by Andriy K. on 12/27/15.
//  Copyright © 2015 Andriy K. All rights reserved.
//

import UIKit
import StrokeDrawingView
import WaniKit

class ViewController: UIViewController {
  
  var kanjiViewController: KanjiViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let manager = WaniApiManager()
    manager.setApiKey("")
    
    manager.fetchKanjiList(11) { (result) -> Void in
      switch result {
      case .Error(let error) : print(error())
      case .Response(let response) :
        let resp = response()
        
        self.kanjiArray = resp.kanji
      }
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    if let kanjiVC = segue.destinationViewController as? KanjiViewController {
      kanjiViewController = kanjiVC
    }
  }
  
  var kanjiArray: [KanjiInfo]?
  
  @IBOutlet weak var levelButton: UIBarButtonItem!
  
  var kanji: Kanji?
  
  @IBAction func levelPickerButtonPressed(sender: AnyObject) {
    
    guard let title = (sender as? UIBarButtonItem)?.title, let index = Int(title) else { return }
    
    guard (index < kanjiArray?.count), let kanjiName = kanjiArray?[index].character else { return }
    
    kanji = Kanji(kanji: kanjiName)
    kanjiViewController?.kanji = kanji
  }
  
}


