//
//
//  Created by Hetal Patel on 21/01/21.
//

import UIKit

typealias ActionHandlerButton = ((UIButton) -> ())

//MARK:- Declare Extension
extension UIViewController
{
    
    @objc  func showAlert(title : String , message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.AlertOk, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension String {
    //MARK:-
    
    var trim : String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var IsEmpty : Bool {
        return (self.count <= 0)
    }
    
    
    
    //MARK:-
    func getTime(_ timestemp : Double) -> String
    {   
        let date = Date(timeIntervalSince1970: timestemp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    func lengthMax(Length length:Int) -> Bool {
        return (self.count >= length)
    }
    
    func lengthMin(Length length:Int) -> Bool {
        return (self.count >= length)
    }
    
    func lengthEqual(Length length:Int) -> Bool {
        let isValid = (self.count == length)
        return isValid
    }
    
}
