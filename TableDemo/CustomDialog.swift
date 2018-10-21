//
//  CustomDialogPresenter.swift
//  TableDemo
//
//  Created by Lingfeng Liu on 2018/10/20.
//  Copyright © 2018年 UTEAMTEC. All rights reserved.
//

import UIKit



protocol CustomDialogProtocol {
    var dialogHeight:CGFloat{get}
    var dialogWidth:CGFloat{get}
}

public class CustomDialog:UIViewController, CustomDialogProtocol {
    var transitionDelegate: CustomDialogTransitionDelegate?
    
    public var dialogWidth: CGFloat {
        return 0
    }
    public var dialogHeight: CGFloat {
        return 0
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(presentDialogShouldHide), name: NSNotification.Name(CustomDialogHideKey), object: nil)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(CustomDialogHideKey), object: nil)
    }
    
    @objc func presentDialogShouldHide() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showDialog(from:UIViewController, mode:CustomDialogPresenter.Mode) {
        transitionDelegate = CustomDialogTransitionDelegate(mode:mode)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = transitionDelegate
        from.present(self, animated: true, completion: nil)
    }
    
    public func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

public let CustomDialogHideKey = "ShouldHideCustomDialog"
class CustomDialogPresenter: UIPresentationController {

    var bgView:UIVisualEffectView?
    
    public enum Mode {
        case center
        case bottom
    }
    
    var mode:Mode = .center
    var dialogWidth:CGFloat
    var dialogHeight:CGFloat
    
    override var frameOfPresentedViewInContainerView: CGRect {
        switch mode {
        case .center:
            return CGRect(x: (UIScreen.main.bounds.width-dialogWidth)/2, y: (UIScreen.main.bounds.height-dialogHeight)/2, width: dialogWidth, height: dialogHeight)
        case .bottom:
            return CGRect(x: (UIScreen.main.bounds.width-dialogWidth)/2, y: UIScreen.main.bounds.height-dialogHeight, width: dialogWidth, height: dialogHeight)
        }
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        if case let vc as CustomDialog = presentedViewController {
            dialogWidth = vc.dialogWidth
            dialogHeight = vc.dialogHeight
        }
        else {
            dialogHeight = UIScreen.main.bounds.height-40
            dialogWidth = UIScreen.main.bounds.width-40
        }
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    
    
    override func presentationTransitionWillBegin() {
        //add blurred background
        let blurEffect = UIBlurEffect(style: .dark)
        bgView = UIVisualEffectView(effect: blurEffect)
        bgView?.frame = (containerView?.bounds)!
        containerView?.addSubview(bgView!)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sendHideNotification))
        bgView?.addGestureRecognizer(gesture)

        bgView?.addGestureRecognizer(gesture)
    }
    
    @objc func cancel() {
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            bgView?.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        bgView?.alpha = 0
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            bgView?.removeFromSuperview()
        }
    }
    
    @objc func sendHideNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: CustomDialogHideKey), object: nil)
    }
}


public class FadeOutAnimationrTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var viewFrame:CGRect
    public init(viewFrame:CGRect) {
        self.viewFrame = viewFrame
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        UIView.animate(withDuration: 0.3, animations: {
            fromView?.alpha = 0
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
}

public class FadeInAnimationrTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var viewFrame:CGRect
    public init(viewFrame:CGRect) {
        self.viewFrame = viewFrame
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let contaienr = transitionContext.containerView
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        contaienr.addSubview(toView!)
        toView?.frame = viewFrame
        toView?.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            toView?.alpha = 1
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
}

public class CustomDialogTransitionDelegate:NSObject, UIViewControllerTransitioningDelegate {
    var mode:CustomDialogPresenter.Mode?
    var transitionIn:FadeInAnimationrTransition?
    var transitionOut:FadeOutAnimationrTransition?
    
    init(mode:CustomDialogPresenter.Mode) {
        self.mode = mode
    }
    // function refers to UIViewControllerTransitioningDelegate
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let present = CustomDialogPresenter(presentedViewController: presented, presenting: presenting)
        transitionIn = FadeInAnimationrTransition(viewFrame: present.frameOfPresentedViewInContainerView)
        transitionOut = FadeOutAnimationrTransition(viewFrame: present.frameOfPresentedViewInContainerView)
        present.mode = mode!
        return present
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch mode! {
        case.bottom:
            return nil
        case.center:
            return transitionIn
        }

    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch mode! {
        case.bottom:
            return nil
        case.center:
            return transitionOut
        }
    }
}
