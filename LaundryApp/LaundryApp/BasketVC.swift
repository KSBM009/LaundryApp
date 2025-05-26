//
//  BasketVC.swift
//  LaundryApp
//
//  Created by macbook on 21/05/2025.
//

import UIKit

class BasketVC: UIViewController {
    
    // MARK: Variable Declarations
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalItemsLabel: UILabel!
    
    var pressingArr: DataArray = DataArray(men: [], women: [], household: [])
    var dryCleanArr: DataArray = DataArray(men: [], women: [], household: [])
    var washFoldArr: DataArray = DataArray(men: [], women: [], household: [])
    var totalCount: Int = 0
    var selectedBtn1: selBtn1 = .pressing
    
    // Add this for section titles
    let mainArr = ["Pressing", "Dry-Clean", "Wash & Fold"]

//    var cartItems: [itemDataCart] = []
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        cartTableView.register(CartTableViewCell.nib(), forCellReuseIdentifier: CartTableViewCell.identifier)
        cartTableView.register(cartSectionTableViewCell.nib(), forCellReuseIdentifier: cartSectionTableViewCell.identifier)
        
        cartTableView.dataSource = self
        cartTableView.delegate = self
        cartTableView.showsVerticalScrollIndicator = false
        cartTableView.showsHorizontalScrollIndicator = false
        
        totalItemsLabel.text = String("   Total Items: \(totalCount)")
        
    }
    
    // MARK: Button Actions
    
    @IBAction func BackBtnAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func AddMoreClothes(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BasketVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return pressingArr.men.count + pressingArr.women.count + pressingArr.household.count
        case 1:
            return dryCleanArr.men.count + dryCleanArr.women.count + dryCleanArr.household.count
        case 2:
            return washFoldArr.men.count + washFoldArr.women.count + washFoldArr.household.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        var item: itemsDataArray?
        var category: String = ""

        switch indexPath.section {
        case 0:
            let menCount = pressingArr.men.count
            let womenCount = pressingArr.women.count
            let householdCount = pressingArr.household.count
            if indexPath.row < menCount {
                item = pressingArr.men[indexPath.row]
                category = "Men"
            } else if indexPath.row < menCount + womenCount {
                item = pressingArr.women[indexPath.row - menCount]
                category = "Women"
            } else if indexPath.row < menCount + womenCount + householdCount {
                item = pressingArr.household[indexPath.row - menCount - womenCount]
                category = "Household"
            }
        case 1:
            let menCount = dryCleanArr.men.count
            let womenCount = dryCleanArr.women.count
            let householdCount = dryCleanArr.household.count
            if indexPath.row < menCount {
                item = dryCleanArr.men[indexPath.row]
                category = "Men"
            } else if indexPath.row < menCount + womenCount {
                item = dryCleanArr.women[indexPath.row - menCount]
                category = "Women"
            } else if indexPath.row < menCount + womenCount + householdCount {
                item = dryCleanArr.household[indexPath.row - menCount - womenCount]
                category = "Household"
            }
        case 2:
            let menCount = washFoldArr.men.count
            let womenCount = washFoldArr.women.count
            let householdCount = washFoldArr.household.count
            if indexPath.row < menCount {
                item = washFoldArr.men[indexPath.row]
                category = "Men"
            } else if indexPath.row < menCount + womenCount {
                item = washFoldArr.women[indexPath.row - menCount]
                category = "Women"
            } else if indexPath.row < menCount + womenCount + householdCount {
                item = washFoldArr.household[indexPath.row - menCount - womenCount]
                category = "Household"
            }
        default: break
        }
        
        // Configure cell with item
        if let item = item {
            cell.name.text = item.name
            cell.No.text = "\(item.counts)"
            cell.clothImg.image = UIImage(named: item.image)
            // Display category in the name label or add a new label for category
            cell.subCategory.text = "\(category)"
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = cartTableView.dequeueReusableCell(withIdentifier: cartSectionTableViewCell.identifier) as! cartSectionTableViewCell
        
        // Set the section title
        headerView.Category.text = mainArr[section]
            
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

struct openClose {
    var pressing: Bool = false
    var dryClean: Bool = false
    var washFold: Bool = false
}

var isOpen: openClose = openClose()

//struct itemDataCart {
//    let image:String
//    let name:String
//    var count:Int
//    var category:selBtn2
//}
