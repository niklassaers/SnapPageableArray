import UIKit
import SnapPageableArray

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    var array = PageableArray<LocalData>(capacity: 960, pageSize: 40)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        array.delegate = self
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

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let fullWidth = self.view.bounds.size.width
        let width: CGFloat
        if fullWidth >= 1024 {
            width = (fullWidth - 15) / 8
        } else if fullWidth >= 768 {
            width = (fullWidth - 15) / 6
        } else if fullWidth >= 414 {
            width = (fullWidth - 15) / 3
        } else {
            width = (fullWidth - 15) / 2
        }
        
        return CGSizeMake(width, width)
    }
}