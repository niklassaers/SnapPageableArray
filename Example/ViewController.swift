import UIKit
import SnapPageableArray

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    var array = PageableArray<LocalData>(capacity: 960, pageSize: 40)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        array.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: PageableArrayDelegate {
    func loadContentForRange(range: Range<UInt>, pageSize: UInt) {
        var data = [LocalData]()
        for _ in 0..<pageSize {
            
            var rnd : UInt64 = 0
            arc4random_buf(&rnd, sizeofValue(rnd))
            
            let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: CGFloat(drand48()))
            
            data.append(LocalData(id: rnd, color: color))
        }
        
        let pageNumber = range.startIndex / pageSize
        let page = Pageable(page: pageNumber, pageSize: pageSize)
        array.updatePage(page, withElements: data)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(array.count)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("identifier", forIndexPath: indexPath) as! Cell
        let data = array[UInt(indexPath.item)]
        cell.backgroundColor = data?.color ?? UIColor.clearColor()
        cell.setText(data?.cacheId ?? "N/A")
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
}