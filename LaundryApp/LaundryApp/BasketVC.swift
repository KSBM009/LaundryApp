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
    var sectionCount: [Int] = [0,0,0]
    
    // Add this for section titles
    let mainArr = ["Pressing", "Dry-Clean", "Wash & Fold"]
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        updateSectionCounts()
        
        cartTableView.register(CartTableViewCell.nib(), forCellReuseIdentifier: CartTableViewCell.identifier)
        cartTableView.register(cartSectionTableViewCell.nib(), forCellReuseIdentifier: cartSectionTableViewCell.identifier)
        
        cartTableView.dataSource = self
        cartTableView.delegate = self
        cartTableView.showsVerticalScrollIndicator = false
        cartTableView.showsHorizontalScrollIndicator = false
        
    }
    
    // MARK: Button Actions
    
    @IBAction func BackBtnAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func AddMoreClothes(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: Helper Functions
    
    func updateSectionCounts() {
        sectionCount[0] = pressingArr.men.reduce(0) { $0 + $1.counts }
                      + pressingArr.women.reduce(0) { $0 + $1.counts }
                      + pressingArr.household.reduce(0) { $0 + $1.counts }
        sectionCount[1] = dryCleanArr.men.reduce(0) { $0 + $1.counts }
                      + dryCleanArr.women.reduce(0) { $0 + $1.counts }
                      + dryCleanArr.household.reduce(0) { $0 + $1.counts }
        sectionCount[2] = washFoldArr.men.reduce(0) { $0 + $1.counts }
                      + washFoldArr.women.reduce(0) { $0 + $1.counts }
                      + washFoldArr.household.reduce(0) { $0 + $1.counts }
        totalCount = sectionCount[0] + sectionCount[1] + sectionCount[2]
        totalItemsLabel.text = String("   Total Items: \(totalCount)")
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
            if isOpen[0] {
                return pressingArr.men.count + pressingArr.women.count + pressingArr.household.count
            } else {
                return 0
            }
        case 1:
            if isOpen[1] {
                return dryCleanArr.men.count + dryCleanArr.women.count + dryCleanArr.household.count
            } else {
                return 0
            }
        case 2:
            if isOpen[2] {
                return washFoldArr.men.count + washFoldArr.women.count + washFoldArr.household.count
            } else {
                return 0
            }
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
            
            // Setting Tag for Increment and Decrement Buttons
            cell.decrementBtn.tag = indexPath.row
            cell.incrementBtn.tag = indexPath.row
            
            cell.decrementBtn.addTarget(self, action: #selector(decrementCount), for: .touchUpInside)
            cell.incrementBtn.addTarget(self, action: #selector(incrementCount), for: .touchUpInside)
        }
        return cell
    }
    
    @objc func decrementCount(sender: UIButton) {
        guard let cell = sender.superview?.superview as? UITableViewCell,
              let indexPath = cartTableView.indexPath(for: cell) else { return }
        switch indexPath.section {
        case 0:
            let menCount = pressingArr.men.count
            let womenCount = pressingArr.women.count
            let householdCount = pressingArr.household.count
            if indexPath.row < menCount {
                pressingArr.men[indexPath.row].counts -= 1
            } else if indexPath.row < menCount + womenCount {
                pressingArr.women[indexPath.row - menCount].counts -= 1
            } else if indexPath.row < menCount + womenCount + householdCount {
                pressingArr.household[indexPath.row - menCount - womenCount].counts -= 1
            }
        case 1:
            let menCount = dryCleanArr.men.count
            let womenCount = dryCleanArr.women.count
            let householdCount = dryCleanArr.household.count
            if indexPath.row < menCount {
                dryCleanArr.men[indexPath.row].counts -= 1
            } else if indexPath.row < menCount + womenCount {
                dryCleanArr.women[indexPath.row - menCount].counts -= 1
            } else if indexPath.row < menCount + womenCount + householdCount {
                dryCleanArr.household[indexPath.row - menCount - womenCount].counts -= 1
            }
        case 2:
            let menCount = washFoldArr.men.count
            let womenCount = washFoldArr.women.count
            let householdCount = washFoldArr.household.count
            if indexPath.row < menCount {
                washFoldArr.men[indexPath.row].counts -= 1
            } else if indexPath.row < menCount + womenCount {
                washFoldArr.women[indexPath.row - menCount].counts -= 1
            } else if indexPath.row < menCount + womenCount + householdCount {
                washFoldArr.household[indexPath.row - menCount - womenCount].counts -= 1
            }
        default: break
        }
        cartTableView.reloadData()
        updateSectionCounts()
    }
    
    @objc func incrementCount(sender: UIButton) {
        guard let cell = sender.superview?.superview as? UITableViewCell,
              let indexPath = cartTableView.indexPath(for: cell) else { return }
//        var name: String = ""
        switch indexPath.section {
        case 0:
            let menCount = pressingArr.men.count
            let womenCount = pressingArr.women.count
            let householdCount = pressingArr.household.count
            if indexPath.row < menCount {
                pressingArr.men[indexPath.row].counts += 1
//                name = pressingArr.men[indexPath.row].name
//                Int(Pressing.men[name].counts ?? "0") ?? 0 += 1
            } else if indexPath.row < menCount + womenCount {
                pressingArr.women[indexPath.row - menCount].counts += 1
            } else if indexPath.row < menCount + womenCount + householdCount {
                pressingArr.household[indexPath.row - menCount - womenCount].counts += 1
            }
        case 1:
            let menCount = dryCleanArr.men.count
            let womenCount = dryCleanArr.women.count
            let householdCount = dryCleanArr.household.count
            if indexPath.row < menCount {
                dryCleanArr.men[indexPath.row].counts += 1
            } else if indexPath.row < menCount + womenCount {
                dryCleanArr.women[indexPath.row - menCount].counts += 1
            } else if indexPath.row < menCount + womenCount + householdCount {
                dryCleanArr.household[indexPath.row - menCount - womenCount].counts += 1
            }
        case 2:
            let menCount = washFoldArr.men.count
            let womenCount = washFoldArr.women.count
            let householdCount = washFoldArr.household.count
            if indexPath.row < menCount {
                washFoldArr.men[indexPath.row].counts += 1
            } else if indexPath.row < menCount + womenCount {
                washFoldArr.women[indexPath.row - menCount].counts += 1
            } else if indexPath.row < menCount + womenCount + householdCount {
                washFoldArr.household[indexPath.row - menCount - womenCount].counts += 1
            }
        default: break
        }
        cartTableView.reloadData()
        updateSectionCounts()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = cartTableView.dequeueReusableCell(withIdentifier: cartSectionTableViewCell.identifier) as! cartSectionTableViewCell
        
        // Set the section title
        headerView.Category.text = mainArr[section]
        
        headerView.count.text = String(sectionCount[section])
        
        headerView.showBtn.tag = section
        headerView.showBtn.addTarget(self, action: #selector(toggleSection), for: .touchUpInside)
        
        if isOpen[section] {
            headerView.showBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            headerView.showBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        }
            
        return headerView
    }
    
    @objc func toggleSection(sender: UIButton) {
        if isOpen[sender.tag] {
            isOpen[sender.tag] = false
            cartTableView.reloadData()
        } else {
            isOpen[sender.tag] = true
            cartTableView.reloadData()
        }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// Initial state for each section
var isOpen: [Bool] = [true, false, false]
