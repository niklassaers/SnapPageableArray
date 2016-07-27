import UIKit
import SnapPageableArray

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    static let kPageSize: UInt = 40
    var array = PageableArray<LocalData>(capacity: 960, pageSize: ViewController.kPageSize)
    var genDataQueue: dispatch_queue_t = dispatch_queue_create("genDataQueue", DISPATCH_QUEUE_CONCURRENT)

    override func viewDidLoad() {
        super.viewDidLoad()

        array.delegate = self

        delay(3.0) {
            self.reloadRandomRange()
        }

        delay(5.0) {
            self.topUp()
        }
    }

    func topUp() {

        dispatch_async(genDataQueue) {
            
            var data = [LocalData]()
            for _ in 0..<ViewController.kPageSize {
                data.append(self.genDataElement())
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.array.topUpWithElements(data)
                self.collectionView?.reloadData()
                
                self.delay(5.0) {
                    self.topUp()
                }
            }
        }
    }

    func reloadRandomRange() {

        var start: UInt = UInt(Double(array.count) * drand48())
        if start > array.count - ViewController.kPageSize {
            start = array.count - ViewController.kPageSize
        }
        
        let end = start + ViewController.kPageSize
        let range: Range<UInt> = start..<end
        
        loadContentForRange(range, pageSize: ViewController.kPageSize)
        collectionView?.reloadData()
        
        delay(3.0) {
            self.reloadRandomRange()
        }
    }

    func delay(secs: Double, f: () -> ()) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(secs * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            f()
        }
    }

    func genDataElement() -> LocalData {

        var rnd: UInt64 = 0
        arc4random_buf(&rnd, sizeofValue(rnd))

        let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: CGFloat(drand48()))

        return LocalData(id: rnd, color: color)
    }
}

extension ViewController: PageableArrayDelegate {
    func loadContentForRange(range: Range<UInt>, pageSize: UInt) {
        
        dispatch_async(genDataQueue) {
            
            var data = [LocalData]()
            for _ in 0..<pageSize {
                data.append(self.genDataElement())
            }
            
            let pageNumber = range.startIndex / pageSize
            let page = Pageable(page: pageNumber, pageSize: pageSize)
            dispatch_async(dispatch_get_main_queue()) {
                
                self.array.updatePage(page, withElements: data)
            }
        }
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
            width = (fullWidth - 45) / 8.0
        } else if fullWidth >= 768 {
            width = (fullWidth - 35) / 6.0
        } else if fullWidth >= 414 {
            width = (fullWidth - 20) / 3.0
        } else {
            width = (fullWidth - 15) / 2.0
        }

        return CGSizeMake(floor(width), floor(width))
    }
}
