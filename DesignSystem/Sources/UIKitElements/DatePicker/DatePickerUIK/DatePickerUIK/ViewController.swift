import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let showDatePickerButton = UIButton(type: .system)
        showDatePickerButton.setTitle("Show Date Picker", for: .normal)
        showDatePickerButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        showDatePickerButton.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        view.addSubview(showDatePickerButton)
    }
    
    @objc func showDatePicker() {
        let datePickerVC = CustomDatePickerViewController()
        datePickerVC.modalPresentationStyle = .overFullScreen
        datePickerVC.onConfirm = { selectedDate in
            print("Selected date: \(selectedDate)")
        }
        present(datePickerVC, animated: true)
    }
}
