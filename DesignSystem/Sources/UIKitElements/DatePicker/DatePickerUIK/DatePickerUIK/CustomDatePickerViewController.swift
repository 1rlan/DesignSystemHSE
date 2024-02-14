import UIKit

class CustomDatePickerViewController: UIViewController {
    var datePicker = UIDatePicker()
    var onConfirm: ((Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 12
        
        datePicker.datePickerMode = .date
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)
        
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(okButton)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, okButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -10),
            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func okAction() {
        onConfirm?(datePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
    private func setupConstraints() {
    }
}
