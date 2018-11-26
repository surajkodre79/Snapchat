//
//  ScrollViewController.swift
//  RaySnapchat
//
//  Created by Suraj Kodre on 23/11/18.
//  Copyright © 2018 Suraj Kodre. All rights reserved.
//

import UIKit

protocol ScrollViewControllerDelegate {
    var viewControllers : [UIViewController?] {get}
    var initialViewController : UIViewController {get}
    
    func scrollViewDidScroll()
}

class ScrollViewController: UIViewController {

    var scrollView : UIScrollView {
        return view as! UIScrollView
    }
    
    var pageSize : CGSize {
        return scrollView.frame.size
    }
    
    var viewControllers : [UIViewController?]!
    
    var delegate : ScrollViewControllerDelegate?
    
    override func loadView() {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self as UIScrollViewDelegate
        
        view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewControllers = delegate?.viewControllers
        
        for (index,controller) in viewControllers.enumerated() {
            if let controller = controller {
                controller.view.frame = self.frame(for: index)
                addChild(controller)
                scrollView.addSubview(controller.view)
                controller.didMove(toParent: self)
            }
        }
        
        scrollView.contentSize = CGSize(width: pageSize.width * CGFloat(viewControllers.count), height: pageSize.height)
        
        if let controller = delegate?.initialViewController {
            setViewController(to: controller, animated: true)
        }
    }
    
}

fileprivate extension ScrollViewController {
    func frame(for index: Int) -> CGRect {
        return CGRect(x: CGFloat(index) * pageSize.width, y: 0, width: pageSize.width, height: pageSize.height)
    }
    
    func indexfor(controller : UIViewController?) -> Int? {
        return viewControllers.index(where : {$0 == controller})
    }
}

extension ScrollViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll()
    }
}

extension ScrollViewController {
    func setViewController(to controller: UIViewController, animated: Bool) {
        guard let index = indexfor(controller: controller) else {return}
        let contentOffset = CGPoint(x: pageSize.width * CGFloat(index), y: 0)
        scrollView.setContentOffset(contentOffset, animated: animated)
    }
}
