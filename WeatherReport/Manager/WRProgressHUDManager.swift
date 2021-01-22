
import KRProgressHUD

@objcMembers class WRProgressHUDManager : NSObject {
    @objc static let shared = WRProgressHUDManager()
    
    enum KRProgressHUDType {
        case `normal`
        case success
        case error
        case info
        case warning
    }
    class func showKRProgressHUDObjC(_ showProgress: Bool = true, onController: UIViewController? = nil, _ completion: (() -> ())? = nil) {
        self.showKRProgressHUD(showProgress, onController: onController, completion)
    }
    
    class func showKRProgressHUD(_ showProgress: Bool = true, Message message: String? = nil, type: KRProgressHUDType = .normal, deadline: Double = 2.0, progressWithMessage withMessage: Bool = false, onController: UIViewController? = nil, _ completion: (() -> ())? = nil) {
        
        DispatchQueue.main.async {
            var progressHUD = KRProgressHUD.self
            if let vcCurrent = onController {
                progressHUD = KRProgressHUD.showOn(vcCurrent)
            }
            
            if showProgress == true {
                progressHUD.set(deadline: deadline)
                switch type {
                case .success:
                    progressHUD.showSuccess(withMessage: message)
                    break
                case .error:
                    progressHUD.showError(withMessage: message)
                    break
                case .info:
                    progressHUD.showInfo(withMessage: message)
                    break
                case .warning:
                    progressHUD.showWarning(withMessage: message)
                    break
                default:
                    if let message = message {
                        if withMessage {
                            progressHUD.show(withMessage: message, completion: completion)
                        } else {
                            progressHUD.showMessage(message)
                        }
                    } else {
                        progressHUD.show(completion: completion)
                    }
                }
            } else {
                progressHUD.dismiss(completion)
            }
        }
    }
    
}
