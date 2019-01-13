import UIKit

class FrontController: UIViewController {
    
    private var rearViewController: RearViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let storyboard = self.storyboard, let rearViewController = storyboard.instantiateViewController(withIdentifier: "Rear") as? RearViewController else {
            return
        }
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapRecognized(_:)))
        doubleTapGesture.numberOfTapsRequired  = 2
        self.view.addGestureRecognizer(doubleTapGesture)
        
        rearViewController.view.isHidden = true
        
        self.view.addSubview(rearViewController.view)
        self.addChild(rearViewController)
        
        rearViewController.view.translatesAutoresizingMaskIntoConstraints = false
        rearViewController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        rearViewController.view.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        self.rearViewController = rearViewController
    }
    
    @objc private func doubleTapRecognized(_ sender: UITapGestureRecognizer) {
        guard  let rear = self.rearViewController else {
            return
        }
        
        let duration : TimeInterval = 2.0
        let flipDirection : UIView.AnimationOptions = rear.view.isHidden ? .transitionFlipFromRight : .transitionFlipFromLeft
        let options : UIView.AnimationOptions = [flipDirection]
        let animations = {
            rear.view.isHidden = rear.view.isHidden ? false : true
        }
        
        UIView.transition(with: self.view, duration: duration, options: options, animations: animations, completion: nil)
    }

}

