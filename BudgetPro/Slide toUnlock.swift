import UIKit

// MARK: - SlideToUnlockButton
class SlideToUnlockButton: UIView {

    private let slider = UIView()
    private let shimmerLabel = UILabel()
    private var gradientLayer: CAGradientLayer!
    private let lockIcon = UIImageView()
    
    var onUnlock: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // Background
        backgroundColor = .systemIndigo
        layer.cornerRadius = 30
        clipsToBounds = true
        
        // Shimmer Label
        shimmerLabel.text = "     Get Started     > > >"
        shimmerLabel.textAlignment = .center
        shimmerLabel.textColor = .white.withAlphaComponent(0.8)
        shimmerLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        addSubview(shimmerLabel)
        
        // Gradient mask for shimmer
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.withAlphaComponent(0.7).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        shimmerLabel.layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1, -0.5, 0]
        animation.toValue = [1, 1.5, 2]
        animation.duration = 2
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmer")
        
        // Slider handle
        slider.backgroundColor = .white
        slider.layer.cornerRadius = 25
        addSubview(slider)
        
        // Lock icon inside slider
        lockIcon.image = UIImage(systemName: "lock.fill")
        lockIcon.tintColor = .gray
        lockIcon.contentMode = .scaleAspectFit
        slider.addSubview(lockIcon)
        
        // Gesture
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        slider.addGestureRecognizer(pan)
        slider.isUserInteractionEnabled = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Shimmer label fills button
        shimmerLabel.frame = bounds
        gradientLayer.frame = shimmerLabel.bounds
        
        // Slider size adapts to height
        let sliderSize = bounds.height - 10
        slider.frame = CGRect(x: 5, y: 5, width: sliderSize, height: sliderSize)
        slider.layer.cornerRadius = sliderSize / 2
        
        lockIcon.frame = CGRect(x: 10, y: 10, width: sliderSize - 20, height: sliderSize - 20)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let sliderView = gesture.view else { return }
        let translation = gesture.translation(in: self)
        
        if gesture.state == .changed {
            let newX = min(max(sliderView.center.x + translation.x,
                               sliderView.frame.width / 2),
                           bounds.width - sliderView.frame.width / 2)
            sliderView.center.x = newX
            gesture.setTranslation(.zero, in: self)
        } else if gesture.state == .ended {
            if sliderView.center.x > bounds.width * 0.8 {
                // ✅ Unlocked
                shimmerLabel.text = "Cool!"
                shimmerLabel.textColor = .systemGreen
                lockIcon.image = UIImage(systemName: "lock.open.fill")
                onUnlock?()
            } else {
                // ❌ Reset with bounce-back animation
                UIView.animate(
                    withDuration: 0.4,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.7,
                    options: .curveEaseOut,
                    animations: {
                        sliderView.center.x = self.slider.frame.width / 2 + 5
                    },
                    completion: nil
                )
            }
        }
    }
}
