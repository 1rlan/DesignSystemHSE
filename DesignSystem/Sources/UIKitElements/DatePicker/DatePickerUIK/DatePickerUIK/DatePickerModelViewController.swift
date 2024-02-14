import UIKit

class DatePickerModalViewController: UIViewController {
    var datePicker: UIDatePicker!
    var confirmButton: UIButton!
    var cancelButton: UIButton!
    
    var onConfirm: ((Date) -> Void)?
    var onCancel: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        view.addSubview(datePicker)
        
        confirmButton = UIButton(type: .system)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTitle("OK", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        view.addSubview(confirmButton)
        
        cancelButton = UIButton(type: .system)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            confirmButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            confirmButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            
            cancelButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            cancelButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 10)
        ])
    }
    
    @objc private func confirmAction() {
        onConfirm?(datePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelAction() {
        onCancel?()
        dismiss(animated: true, completion: nil)
    }
}
