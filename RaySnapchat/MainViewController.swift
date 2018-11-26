//
//  ViewController.swift
//  RaySnapchat
//
//  Created by Suraj Kodre on 23/11/18.
//  Copyright © 2018 Suraj Kodre. All rights reserved.
//

import UIKit

protocol ColoredView {
    var controllerColor: UIColor {get set}
}

class MainViewController: UIViewController {
    @IBOutlet weak var transparentColorView: UIView!
    
    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var chatAndDiscoverButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatAndDiscoverButtonHeightConstraint: NSLayoutConstraint!
   
    var scrollViewController : ScrollViewController!
    var cameraViewController : CameraViewController!
    
    var firstTimeCon : Bool = true
        
    lazy var chatViewController : UIViewController! = {
       return self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController")
    }()
    
    lazy var lenseViewController : UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "LenseViewController")
    }()
    
    lazy var discoverViewController : UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "DiscoverViewController")
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CameraViewController {
            cameraViewController = controller
        } else if let controller = segue.destination as? ScrollViewController {
            scrollViewController = controller
            scrollViewController.delegate = self as! ScrollViewControllerDelegate
        }
    }

    @IBAction func chatButtonPressed(_ sender: Any) {
        print("Chat")
        scrollViewController.setViewController(to: chatViewController, animated: true)
    }
    @IBAction func discoverButtonPressed(_ sender: Any) {
        print("Discover")
        scrollViewController.setViewController(to: discoverViewController, animated: true)
    }
    @IBAction func cameraButtonPressed(_ sender: Any) {
        print("lense")
        scrollViewController.setViewController(to: lenseViewController, animated: true)
    }
}

extension MainViewController : ScrollViewControllerDelegate {
    var viewControllers: [UIViewController?] {
        return [chatViewController,lenseViewController,discoverViewController]
    }
    
    var initialViewController: UIViewController {
        return lenseViewController
    }
    
    func scrollViewDidScroll() {
        let min : CGFloat = 0
        let max : CGFloat = scrollViewController.pageSize.width
        let x : CGFloat = scrollViewController.scrollView.contentOffset.x
        let result = ((x - min) / (max - min)) - 1
        print(result)
        
        if result < 0 {
            transparentColorView.backgroundColor = .blue
        } else if result > 0 {
            transparentColorView.backgroundColor = .purple
        } else if result == 0 {
            transparentColorView.backgroundColor = .white
        }
        animationView.animation(to: result)
    }
    
}
