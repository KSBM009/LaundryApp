//
//  HomeVC.swift
//  LaundryApp
//
//  Created by macbook on 16/05/2025.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: Variable Declarations
    
    @IBOutlet var itemCollectionView: UICollectionView!
    @IBOutlet var totalCount: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var PressingBtn: UIButton!
    @IBOutlet weak var DryCleanBtn: UIButton!
    @IBOutlet weak var WashPressBtn: UIButton!
    @IBOutlet weak var MenBtn: UIButton!
    @IBOutlet weak var WomenBtn: UIButton!
    @IBOutlet weak var HouseholdBtn: UIButton!
    
    static let identifier = "itemCollectionView"
    
    var selectedBtn1: selBtn1 = .pressing
    var selectedBtn2: selBtn2 = .men
    
    var stack1: Int = 0
    var stack2: Int = 0
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        itemCollectionView.register(clothsCollectionViewCell.nib(), forCellWithReuseIdentifier: clothsCollectionViewCell.identifier)
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        // Corner Radius applied to the top side only.
        mainView.roundCorners(cornerRadius: 55, topLeft: true, topRight: true, bottomLeft: false, bottomRight: false)
        
        // Function to set default values
        selectedBtn1 = .pressing
        selectedBtn2 = .men
        selected()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Button Actions
    
    @IBAction func PressingBtnAction(_ sender: Any) {
        
        selectedBtn1 = .pressing
        selectedBtn2 = .men
        selected()
        
    }
    
    @IBAction func DryCleanBtnAction(_ sender: Any) {
        
        selectedBtn1 = .dryClean
        selectedBtn2 = .men
        selected()
        
    }
    
    @IBAction func WashPressBtnAction(_ sender: Any) {
        
        selectedBtn1 = .washPress
        selectedBtn2 = .men
        selected()
        
    }
    
    @IBAction func MenBtnAction(_ sender: Any) {
        
        selectedBtn2 = .men
        selected()
        
    }
    
    @IBAction func WomenBtnAction(_ sender: Any) {
        
        selectedBtn2 = .women
        selected()
        
    }
    
    @IBAction func HouseholdBtnAction(_ sender: Any) {
        
        selectedBtn2 = .household
        selected()
        
    }
    
    @IBAction func BasketView(_ sender: Any) {
            
        saveArray()
        let NextVC: BasketVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BasketVC") as! BasketVC
        nonZeroItems()
        NextVC.pressingArr = mainArr[0]
        NextVC.dryCleanArr = mainArr[1]
        NextVC.washFoldArr = mainArr[2]
        NextVC.totalCount = Int(totalCount.text ?? "0") ?? 0
        self.navigationController?.pushViewController(NextVC, animated: true)
        
    }
    
    
    // MARK: Custom Functions
    
    func saveArray() {
        
        switch selectedBtn2 {
        case .men:
            MenBtn.backgroundColor = .customYellow
            MenBtn.tintColor = .black
            arr[stack1].men = reqArray
        case .women:
            WomenBtn.backgroundColor = .customYellow
            WomenBtn.tintColor = .black
            arr[stack1].women = reqArray
        case .household:
            HouseholdBtn.backgroundColor = .customYellow
            HouseholdBtn.tintColor = .black
            arr[stack1].household = reqArray
        }
        totalCountUpdate()
        
    }
    
    func nonZeroItems() {
        // Track index
        for (index, dataArray) in arr.enumerated() {
            for item in dataArray.men where item.count > 0 {
                // Use the index
                mainArr[index].men.append(item)
            }
            for item in dataArray.women where item.count > 0 {
                mainArr[index].women.append(item)
            }
            for item in dataArray.household where item.count > 0 {
                mainArr[index].household.append(item)
            }
//            print(mainArr[index].men)
//            print(mainArr[index].women)
//            print(mainArr[index].household)
        }
//        print(mainArr)
    }
    
    func selected() {
        
        // Reloading the Collection view cells
        itemCollectionView.reloadData()
        
        // Default states for all buttons
        PressingBtn.backgroundColor = .white
        PressingBtn.tintColor = .lightGray
        DryCleanBtn.backgroundColor = .white
        DryCleanBtn.tintColor = .lightGray
        WashPressBtn.backgroundColor = .white
        WashPressBtn.tintColor = .lightGray
        MenBtn.backgroundColor = .white
        MenBtn.tintColor = .lightGray
        WomenBtn.backgroundColor = .white
        WomenBtn.tintColor = .lightGray
        HouseholdBtn.backgroundColor = .white
        HouseholdBtn.tintColor = .lightGray
        
        switch selectedBtn1 {
        case .pressing:
            PressingBtn.backgroundColor = .black
            PressingBtn.tintColor = .white
            stack1 = 0
        case .dryClean:
            DryCleanBtn.backgroundColor = .black
            DryCleanBtn.tintColor = .white
            stack1 = 1
        case .washPress:
            WashPressBtn.backgroundColor = .black
            WashPressBtn.tintColor = .white
            stack1 = 2
        }
        
        switch selectedBtn2 {
        case .men:
            MenBtn.backgroundColor = .customYellow
            MenBtn.tintColor = .black
            reqArray = arr[stack1].men
        case .women:
            WomenBtn.backgroundColor = .customYellow
            WomenBtn.tintColor = .black
            reqArray = arr[stack1].women
        case .household:
            HouseholdBtn.backgroundColor = .customYellow
            HouseholdBtn.tintColor = .black
            reqArray = arr[stack1].household
        }
    }
    
    func totalCountUpdate(){
        
        var n: Int = 0
        for i in arr {
            for j in  i.men {
                n += j.count
            }
            for j in  i.women {
                n += j.count
            }
            for j in  i.household {
                n += j.count
            }
        }
        totalCount.text = String(n)
        
    }
    
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemData.count
//        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: clothsCollectionViewCell.identifier, for: indexPath) as! clothsCollectionViewCell
        
        if (0..<itemData.count).contains(indexPath.row) {
            
            // Get the items at the current index
            let item = reqArray[indexPath.item]
            
            // Set the image, name and code for each item in the cell from the Array
            cell.itemImg.image = UIImage(named: item.image)
            cell.itemName.text = item.name
            cell.itemCount.text = "\(item.count)"
            
            // Setting Tag for Increment and Decrement Buttons
            cell.DecrementBtn.tag = indexPath.row
            cell.IncrementBtn.tag = indexPath.row
            
            // Adding Target Actions for both the buttons
            cell.DecrementBtn.addTarget(self, action: #selector(decrementCount), for: .touchUpInside)
            cell.IncrementBtn.addTarget(self, action: #selector(incrementCount), for: .touchUpInside)
            
            return cell
            
        } else {
            cell.itemName.text = "Clothes"
            cell.itemCount.text = "\(0)"
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 40 )/2, height: (UIScreen.main.bounds.width - 40 )/2)
    }
    
    @objc func decrementCount(sender: UIButton) {
        reqArray[sender.tag].count-=1
        itemCollectionView.reloadData()
        saveArray()
    }
    
    @objc func incrementCount(sender: UIButton) {
        reqArray[sender.tag].count+=1
        itemCollectionView.reloadData()
        saveArray()
    }
    
}

extension UIView {
    func roundCorners(cornerRadius: CGFloat,
                      topLeft: Bool,
                      topRight: Bool,
                      bottomLeft: Bool,
                      bottomRight: Bool) {
        
        var maskedCorners: CACornerMask = []
 
        if topLeft { maskedCorners.insert(.layerMinXMinYCorner) }
        if topRight { maskedCorners.insert(.layerMaxXMinYCorner) }
        if bottomLeft { maskedCorners.insert(.layerMinXMaxYCorner) }
        if bottomRight { maskedCorners.insert(.layerMaxXMaxYCorner) }
 
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = maskedCorners
        self.layer.masksToBounds = true
    }
}

// MARK: Data Storing & Required Structs Created

// Required Array
var reqArray: [itemsDataArray] = []

// Item Data
var itemData: [itemsDataArray] = [itemsDataArray(image: "shirt", name: "Shirt"),
                                itemsDataArray(image: "trousers", name: "Trousers"),
                                itemsDataArray(name: "Jeans"),
                                itemsDataArray(name: "Shorts")]

// Pressing Data
var Pressing: DataArray = DataArray(men: itemData, women: itemData, household: itemData)
var Pressing1: DataArray = DataArray(men: [], women: [], household: [])

// DryClean Data
var DryClean: DataArray = DataArray(men: itemData, women: itemData, household: itemData)
var DryClean1: DataArray = DataArray(men: [], women: [], household: [])

// Wash&Press Data
var WashPress: DataArray = DataArray(men: itemData, women: itemData, household: itemData)
var WashPress1: DataArray = DataArray(men: [], women: [], household: [])

// Complete Array Data
var arr: [DataArray] = [Pressing, DryClean, WashPress]

// Non Empty Array
var mainArr: [DataArray] = [Pressing1, DryClean1, WashPress1]

// To avoid Negative Numbers
@propertyWrapper
struct NonNegative {
    private var value: Int = 0
    
    var wrappedValue: Int {
        get { value }
        set { value = max(newValue, 0) }
    }
    
    init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
    }
}

struct itemsDataArray {
    var image:String = ""
    let name:String
    @NonNegative var count:Int = 0
}

struct DataArray {
    var men:[itemsDataArray] = itemData
    var women:[itemsDataArray] = itemData
    var household:[itemsDataArray] = itemData
}

enum selBtn1 {
    case pressing
    case dryClean
    case washPress
}

enum selBtn2 {
    case men
    case women
    case household
}
