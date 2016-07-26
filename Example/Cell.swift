import UIKit

class Cell: UICollectionViewCell {
    
    
    @IBOutlet weak var theTextLabel: UILabel?
    
    func setText(text: String) {
        theTextLabel?.text = text
    }
}