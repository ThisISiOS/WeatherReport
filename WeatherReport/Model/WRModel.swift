//
//
//  Created by Hetal Patel on 21/01/21.
//

import ObjectMapper

class WRModel: Mappable {
    
    required init(){}
    
    required init?(map: Map){
        self.mapping(map: map)
    }
    
    func mapping(map: Map){
    }
}
