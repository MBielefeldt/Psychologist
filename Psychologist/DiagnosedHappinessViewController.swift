//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Mads Bielefeldt on 24/05/15.
//  Copyright (c) 2015 GN ReSound. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate
{
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.diagnosticHistory"
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    private var diagnosticHistory: [Int] {
        get {
            return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? []
        }
        set {
            defaults.setObject(newValue, forKey: History.DefaultsKey)
        }
    }
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let identifier = segue.identifier {
            switch identifier {
                case History.SegueIdentifier:
                    if let textVC = segue.destinationViewController as? TextViewController {
                        if let popoverPresentationCtrl = textVC.popoverPresentationController {
                            popoverPresentationCtrl.delegate = self
                        }
                        textVC.text = "\(diagnosticHistory)"
                    }
                default: break
            }
        }
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None /* use popover layout even on iphone */
    }
}
