//
//  PsychologistViewController.swift
//  Psychologist
//
//  Created by Mads Bielefeldt on 23/05/15.
//  Copyright (c) 2015 GN ReSound. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController
{
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        var destinationVC = segue.destinationViewController as? UIViewController
        
        if let navigationVC = destinationVC as? UINavigationController {
            destinationVC = navigationVC.visibleViewController
        }
        
        if let happinessVC = destinationVC as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "sad"  : happinessVC.happiness = 0
                    case "happy": happinessVC.happiness = 100
                    default     : happinessVC.happiness = 50
                }
            }
        }
    }
}

