import UIKit

class CircleSpawnController: UIViewController, UIGestureRecognizerDelegate {

	// TODO: Assignment 1

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
	}
    
    override func viewDidLoad() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap(sender:)))
        tripleTap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tripleTap)
        
        doubleTap.require(toFail: tripleTap)
    }
    
    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        let newCircle = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        newCircle.center = location
        newCircle.layer.cornerRadius = 50
        newCircle.backgroundColor = UIColor.randomBrightColor()
        newCircle.alpha = 0
        newCircle.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        newCircle.isUserInteractionEnabled = true
        view.addSubview(newCircle)
        
        UIView.animate(withDuration: 0.3, animations: {
            newCircle.alpha = 1
            newCircle.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        let press = UILongPressGestureRecognizer(target: self, action: #selector(handlePress(sender:)))
        press.minimumPressDuration = 0.15
        press.delegate = self
        newCircle.addGestureRecognizer(press)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        pan.delegate = self
        newCircle.addGestureRecognizer(pan)
    }
    
    @objc func handleTripleTap(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: {
            sender.view?.alpha = 0
            sender.view?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: {_ in
            sender.view?.removeFromSuperview()
        })

    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {

        if sender.state == .began {
            UIView.animate(withDuration: 0.3, animations: {
                sender.view?.alpha = 0.5
                sender.view?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            })
            view.bringSubviewToFront(sender.view!) // tak jak niżej
        } else if sender.state == .changed {
            let translation = sender.translation(in: view)
                sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)//te wykrzykniki są tymczasowe
                sender.setTranslation(.zero, in: view)
        } else if sender.state == .ended || sender.state == .cancelled {
            UIView.animate(withDuration: 0.3, animations: {
                sender.view?.alpha = 1
                sender.view?.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
    
    @objc func handlePress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            UIView.animate(withDuration: 0.3, animations: {
                sender.view?.alpha = 0.5
                sender.view?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            })
            view.bringSubviewToFront(sender.view!)
        } else if sender.state == .ended || sender.state == .cancelled {
            UIView.animate(withDuration: 0.3, animations: {
                sender.view?.alpha = 1
                sender.view?.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

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
