//
//
//  Created by Hetal Patel on 21/01/21.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import Foundation
import UIKit


var forecastData : [Response] = []
var baseURL : String {
    switch WRAppManager.shared.appStatus {
    case .production:
        return "https://api.openweathermap.org/data/2.5/"
    case .staging:
        return "https://api.openweathermap.org/data/2.5/"
    case .local:
        return "https://api.openweathermap.org/data/2.5/"
    }
}
struct Storyboard {
    static let main = "Main"
}
struct Controller {
    static var Map : WRMapController {
        (UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: "WRMapController") as? WRMapController)!
    }
    static var Detail : WRDetailController {
        (UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: "WRDetailController") as? WRDetailController)!
    }
    static var Help : WRHelpViewController {
        (UIStoryboard(name: Storyboard.main, bundle: nil).instantiateViewController(withIdentifier: "WRHelpViewController") as? WRHelpViewController)!
    }
    
    
}
struct CellNib {
    static let BookMarkCCell       = UINib(nibName: CellIdentifier.BookMarkCCell, bundle: nil)
    static let ForecastCell        = UINib(nibName: CellIdentifier.ForecastCell, bundle: nil)
}

struct CellIdentifier {
    static let BookMarkCCell       = "WRBookMarkTableViewCell"
    static let ForecastCell        = "WFForeCastCollectionCell"
}
struct Strings {
    static let AlertOk = "Ok"
    static let AlertTitle = "WeatherReport"
    static let FailureOperation = "Something went wrong. Please try again later"
    static let Done = "Done"
    static let AlerYES = "Yes"
    static let AlertCancel = "Cancel"
    static let Bookmark = "BookMark"
    static let WindUnit = "km/h"
    static let Humadity = "%"
    static let tempString = "Temperature"
    static let tempMin = "Minimum Temperature"
    static let tempMax = "Maximum Temperature"
    
    static let WindString = "Wind"
    static let HumadityString = "Humadity"
    static let Help = "Help"
    static let Metric = "Metric"
    static let Imperial = "Imperial"
    static let SettingsTitle = "Settings"
    static let BookmarkDeleteAlert = "Do you want to clear all the bookmarks?"
    static let DeleteMSG = "Your all bookmark locations are deleted successfully"
    static let MapTitle = "Map"
    static let HomeTitle = "Locations"
    
}
struct APIName {
    static var APIWeather = baseURL + "weather?"
    //    static var APIForeCast = NetworkManager.shared.baseURL + "forecast?"
    
    
}
struct Keys {
    static let APIKeys = "fae7190d7e6433ec3a45285ffcf55c86"
    static let UnitKey = "TempUnit"
}


