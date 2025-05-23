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
    
    var pressingArr: DataArray = DataArray()
    var dryCleanArr: DataArray = DataArray()
    var washFoldArr: DataArray = DataArray()
    var totalCount: Int = 0
    var cartItems: [itemDataCart] = []
    
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
            return mainArr.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cell Registration
        let cell = cartTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        
        switch selectedBtn1 {
        case .pressing:
            let item = pressingArr[indexPath.item]
            
        case .dryClean:
            let item = dryCleanArr[indexPath.item]
            
        case .washPress:
            let item = washFoldArr[indexPath.item]
            
        }
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainArr.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = cartTableView.dequeueReusableCell(withIdentifier: cartSectionTableViewCell.identifier) as! cartSectionTableViewCell
        switch section {
        case 0:
            headerView.Category.text = "Pressing"
        
        case 1:
            headerView.Category.text = "Dry-Clean"
            
        case 2:
            headerView.Category.text = "Wash & Fold"
            
        default:
            headerView.Category.text = "Category"
            
        }
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

struct itemDataCart {
    let image:String
    let name:String
    var count:Int
    var category:selBtn2
}
