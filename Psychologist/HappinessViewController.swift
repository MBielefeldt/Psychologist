//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Mads Bielefeldt on 17/05/15.
//  Copyright (c) 2015 GN ReSound. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4.0
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    @IBAction func pan(gesture: UIPanGestureRecognizer)
    {
        switch gesture.state {
            case .Ended: fallthrough
            case .Changed:
                let translation = gesture.translationInView(faceView)
                let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
                if happinessChange != 0 {
                    happiness += happinessChange
                    gesture.setTranslation(CGPointZero, inView: faceView)
                }
            default: break
        }
    }
    
    var happiness: Int = 88 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }

    func updateUI()
    {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double?
    {
        return Double(happiness - 50) / 50
    }
}
