//
//  WRBookMarkTableViewCell.swift
//  WeatherForeCastApp
//
//  Created by Hetal Patel on 21/01/21.
//  Copyright © 2020 Hetal Patel. All rights reserved.
//

import UIKit

class WRBookMarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    var location : Response? {
        didSet {
            self.setupCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupCell()
    {
        self.locationLabel.text = self.location?.name
        self.tempratureLabel.text = ("\(Strings.tempString): \(self.location?.main?.temp ?? 0.0) F")
        self.dateLabel.text = self.dateLabel.text?.getTime(self.location?.dt ?? 0.0)
    }
    
}
