/*import UIKit

class SecondViewController: UIViewController {
    private let messageLabel: UILabel = {
        let label = UILabel()
      
        label.textColor = .white
        label.text = "You can find me on social media"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
       
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let socialLinks = [
        ("GitHub", "github.com/michae1miroshnikov"),
        ("Instagram", "instagram.com/michael_miroshnikov_/profilecard/?igsh=MTZmMjJoanFtNWVqbg%3D%3D"),
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(messageLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        setupButtons()
    }
    
    private func setupButtons() {
        socialLinks.forEach { (title, url) in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
            button.setTitleColor(.purple, for: .normal)
            button.layer.cornerRadius = 10
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let index = stackView.arrangedSubviews.firstIndex(of: sender),
              let url = URL(string: "https://" + socialLinks[index].1) else { return }
        UIApplication.shared.open(url)
    }
}
*/
import UIKit

class SecondViewController: UIViewController {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "You can find me on social media"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let socialLinks = [
        ("GitHub", "github.com/michae1miroshnikov"),
        ("Instagram", "instagram.com/michael_miroshnikov_/profilecard/?igsh=MTZmMjJoanFtNWVqbg%3D%3D")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(messageLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        setupButtons()
    }
    
    private func setupButtons() {
        socialLinks.forEach { (title, url) in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.backgroundColor = .purple  // Changed to purple background
            button.setTitleColor(.white, for: .normal)  // Changed text color to white
            button.layer.cornerRadius = 10
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let index = stackView.arrangedSubviews.firstIndex(of: sender),
              let url = URL(string: "https://" + socialLinks[index].1) else { return }
        UIApplication.shared.open(url)
    }
}
