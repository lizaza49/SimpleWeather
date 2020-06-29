//
//  CustomTransitionNavigationController.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation
import UIKit

enum TransitionDirection {
    case forward, backwards
}

protocol CustomTransitioningProtocol {
    var transitionManager: TransitionManager? { get set }
    func transitionManager(for direction: TransitionDirection, interactive: Bool) -> TransitionManager?
}

extension CustomTransitioningProtocol {
    func transitionManager(for direction: TransitionDirection, interactive: Bool = false) -> TransitionManager? {
        return transitionManager
    }
}

class CustomTransitioningNavigationController : UINavigationController, CustomTransitioningProtocol {

    var interactive: Bool = false

    private var _transitionManager: TransitionManager? = nil
    var transitionManager: TransitionManager? {
        get {
            return _transitionManager
        }
        set {
            self._transitionManager = newValue
        }
    }

    private var interactiveTransitionManager: TransitionManager? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        transitionManager = nil
        self.transitioningDelegate = transitionManager
    }

    @discardableResult
    override func popViewController(animated: Bool) -> UIViewController? {
        let transitionManager = (self.viewControllers.last as? CustomTransitioningProtocol)?.transitionManager(for: .backwards) ?? self.transitionManager
        guard !(transitionManager?.isAnimating ?? false) else { return nil }

        let vcCount = self.viewControllers.count
        guard vcCount > 0 else { return super.popViewController(animated: animated) }
        transitionManager?.forward = false
        self.transitioningDelegate = transitionManager
        return super.popViewController(animated: animated)
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vcCount = self.viewControllers.count
        guard vcCount > 0 else { return super.popToRootViewController(animated: animated) }
        let transitionManager = (self.viewControllers.last as? CustomTransitioningProtocol)?.transitionManager ?? self.transitionManager
        transitionManager?.forward = false
        self.transitioningDelegate = transitionManager
        return super.popToRootViewController(animated: animated)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        push(viewController: viewController, animated: animated, transitionManager: nil)
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool, sender: Any?) {
        push(viewController: viewController, animated: animated, transitionManager: nil)
    }

    private func push(viewController: UIViewController, animated: Bool, transitionManager: TransitionManager?) {
        guard !viewControllers.contains(viewController) else {
            fatalError("Attempt to push a \(viewController.classForCoder) to a navigation stack which already contains it")
        }
        let customTransitioningVC = viewController as? CustomTransitioningProtocol
        let transitionManager = transitionManager ??
            customTransitioningVC?.transitionManager(for: .forward) ??
            self.transitionManager
        transitionManager?.forward = true
        self.transitioningDelegate = transitionManager
        super.pushViewController(viewController, animated: animated)
    }

    @discardableResult
    private func plainPop(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
}

extension CustomTransitioningNavigationController : UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let transitionManager = self.transitioningDelegate as? TransitionManager else {
            return nil
        }
        transitionManager.forward = operation == .push
        return transitionManager
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? interactiveTransitionManager : nil
    }
}

