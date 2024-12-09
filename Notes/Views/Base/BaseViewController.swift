import UIKit

class BaseViewController: UIViewController {
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
        setupObservers([:])
    }
    
    func setupData() {
        
    }
    
    func setupView() {
        view.backgroundColor = .black
    }
    
    func setupObservers(_ names: [Notification.Name: Selector]) {
        names.forEach { key, value in
            NotificationCenter.default
                .addObserver(self, selector: value,
                             name: key, object: nil)
        }
    }
}
