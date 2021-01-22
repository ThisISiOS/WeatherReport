//
//  WRHomeController.swift
//  WeatherReport
//
//  Created by Hetal Patel on 21/01/21.
//

import UIKit
import ObjectMapper
import Alamofire
import UIViewController_Popup
protocol HomeViewDelegate {
    func didUpdate()
}
class WRHomeController: UIViewController {
    @IBOutlet weak var forecastListingTable: UITableView!
    @IBOutlet weak var viewMAp: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTable()
        let updates = Controller.Map
        updates.homedelegate = self
    }
    
    func setTable()
    {
        self.forecastListingTable.register(CellNib.BookMarkCCell, forCellReuseIdentifier: CellIdentifier.BookMarkCCell)
        self.forecastListingTable.delegate = self
        self.forecastListingTable.dataSource = self
        self.forecastListingTable.estimatedRowHeight = 44.0
        self.forecastListingTable.rowHeight = UITableView.automaticDimension
        self.forecastListingTable.reloadData()
        self.setInfoLabel()
        
    }
    func setInfoLabel()
    {
        if forecastData.count == 0
        {
            self.forecastListingTable.isHidden = true
        }
        else
        {
            self.forecastListingTable.isHidden = false
        }
    }
    
    func showMap()
    {
        viewMAp.isHidden = false
        let pv          = Controller.Map
        pv.view.frame   = CGRect(x: 0, y: 0, width: viewMAp.frame.size.width, height: viewMAp.frame.size.height)
        popUpEffectType = .flipDown
        pv.homedelegate = self
        presentPopUpViewController(pv)
    }
    // MARK: - function to go to city selection screen
    private func detailScreen(_ foreCastInfo: Response) {
        let controller = Controller.Detail
        controller.foreCastData = foreCastInfo
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: Actions
    @IBAction func HelpAction(_ sender: Any)
    {
        self.navigationController?.pushViewController(Controller.Help, animated: true)
    }
    @IBAction func AddClick(_ sender: Any)
    {
        self.showMap()
    }
    
}


extension WRHomeController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.BookMarkCCell, for: indexPath) as? WRBookMarkTableViewCell
        {
            cell.location = forecastData[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            forecastData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            WRAppManager.shared.setBookmarkUserDefault(bookmark: forecastData)
            self.setInfoLabel()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.detailScreen(forecastData[indexPath.row])
    }
}
extension WRHomeController: HomeViewDelegate
{
    func didUpdate() {
        self.forecastListingTable.reloadData()
        self.setInfoLabel()
        viewMAp.isHidden = true
    }
}
