//
//
//  Created by Hetal Patel on 21/01/21.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import Foundation
import ObjectMapper
class WRAppManager : NSObject {
    enum AppStatusType : Int {
        case production
        case staging
        case local
    }
    
    static let shared = WRAppManager()
    var appStatus : AppStatusType = .local
    
    func setBookmarkUserDefault(bookmark:[Response])
    {
        let userDefaults = UserDefaults.standard
        let defaults = UserDefaults.standard
        defaults.set(bookmark.toJSON(), forKey: Strings.Bookmark)
        userDefaults.synchronize()
    }
    func getBookmarkUserDefault()
    {
        let locations = UserDefaults.standard.value(forKey: Strings.Bookmark) as? [[String : Any]] ?? []
        debugPrint(locations)
        forecastData = Mapper<Response>().mapArray(JSONArray: locations)        
    }
}
