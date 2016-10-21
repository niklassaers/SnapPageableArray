import UIKit

class Cell: UICollectionViewCell {


    @IBOutlet weak var theTextLabel: UILabel?

    func setText(_ text: String) {
        theTextLabel?.text = text
    }
}
