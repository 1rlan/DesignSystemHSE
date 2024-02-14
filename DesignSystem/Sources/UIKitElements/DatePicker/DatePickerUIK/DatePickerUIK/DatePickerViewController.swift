import UIKit

protocol DatePickerDelegate: AnyObject {
    func datePickerDidSelect(date: Date)
    func datePickerDidCancel()
}

class DatePickerViewController: UIViewController {
    weak var delegate: DatePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 200))
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        view.addSubview(datePicker)
        
        let okButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 105, y: 260, width: 100, height: 40))
        okButton.setTitle("OK", for: .normal)
        okButton.setTitleColor(.blue, for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        view.addSubview(okButton)
        
        let cancelButton = UIButton(frame: CGRect(x: view.frame.width / 2 + 5, y: 260, width: 100, height: 40))
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        view.addSubview(cancelButton)
    }
    
    @objc func okButtonTapped() {
        delegate?.datePickerDidSelect(date: Date())
        dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        delegate?.datePickerDidCancel()
        dismiss(animated: true)
    }
}
