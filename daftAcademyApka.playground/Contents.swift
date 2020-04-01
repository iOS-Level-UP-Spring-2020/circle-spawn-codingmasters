//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

extension CGFloat {
  static func random() -> CGFloat {
    return random(min: 0.0, max: 1.0)
  }

  static func random(min: CGFloat, max: CGFloat) -> CGFloat {
    assert(max > min)
    return min + ((max - min) * CGFloat(arc4random()) / CGFloat(UInt32.max))
  }
}

extension UIColor {
  static func randomBrightColor() -> UIColor {
    return UIColor(hue: .random(),
             saturation: .random(min: 0.5, max: 1.0),
             brightness: .random(min: 0.7, max: 1.0),
             alpha: 1.0)
  }
}


class MyViewController : UIViewController {

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.white
    }

    private let startSize: CGSize = .init(width: 30, height: 30)
    private var spawnedView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        //let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        //view.addGestureRecognizer(panGesture)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleTap2(_:)))
        tap2.numberOfTapsRequired = 3
        view.addGestureRecognizer(tap2)
    }

    /*@objc func handlePan(_ pan: UIPanGestureRecognizer) {

        let location = pan.location(in: view)
        switch pan.state {
        case .began:arc4random()
            guard spawnedView == nil else { return }
        let circle = spawnCircle(at: location)
            view.addSubview(circle)
            spawnedView = circle
        case .changed:
            spawnedView?.center = location
        case .ended, .cancelled:
            spawnedView?.removeFromSuperview()
            spawnedView = nil
        default:
            return
        }
    }

    private func spawnCircle(at point: CGPoint) -> UIView {
        let circle = UIView()
        circle.center = point
        circle.bounds.size = startSize
        circle.backgroundColor = .red
        circle.layer.cornerRadius = startSize.width * 0.5

        return circle
    }*/


    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        let size: CGFloat = 50
        let spawnedView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        spawnedView.center = tap.location(in: view)
        spawnedView.backgroundColor = .randomBrightColor()
        spawnedView.layer.cornerRadius = size * 0.5
        view.addSubview(spawnedView)

        spawnedView.alpha = 0
        spawnedView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.2, animations: {
            spawnedView.alpha = 1
            spawnedView.transform = .identity
        }/*, completion: { completed in
            UIView.animate(withDuration: 0.2, animations: {
                spawnedView.alpha = 0
                spawnedView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: { completed in
                spawnedView.removeFromSuperview()
            })
        }*/)
    }
    
    @objc func handleTap2(_ tap2: UITapGestureRecognizer) {
        
    }
}

PlaygroundPage.current.liveView = MyViewController()
