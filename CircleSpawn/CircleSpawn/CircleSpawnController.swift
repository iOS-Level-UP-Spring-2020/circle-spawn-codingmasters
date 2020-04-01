import UIKit

class CircleSpawnController: UIViewController {

	// TODO: Assignment 1

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
	}
    
    override func viewDidLoad() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        print("double tap")
        let newCircle = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        newCircle.center = location
        newCircle.layer.cornerRadius = 50
        newCircle.backgroundColor = UIColor.randomBrightColor()
        newCircle.alpha = 0
        view.addSubview(newCircle)
        UIView.animate(withDuration: 0.3, animations: {
            newCircle.alpha = 1
        })
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
