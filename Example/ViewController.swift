import UIKit
import SnapPageableArray

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    static let kPageSize: UInt = 40
    var array = PageableArray<LocalData>(capacity: 960, pageSize: ViewController.kPageSize)
    var genDataQueue: DispatchQueue = DispatchQueue(label: "genDataQueue", attributes: DispatchQueue.Attributes.concurrent)

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

        genDataQueue.async {
            
            var data = [LocalData]()
            for _ in 0..<ViewController.kPageSize {
                data.append(self.genDataElement())
            }
            
            DispatchQueue.main.async {
                
                let _ = self.array.topUpWithElements(data)
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
        let range: CountableRange<UInt> = start..<end
        
        loadContentForRange(range, pageSize: ViewController.kPageSize)
        collectionView?.reloadData()
        
        delay(3.0) {
            self.reloadRandomRange()
        }
    }

    func delay(_ secs: Double, f: @escaping () -> ()) {
        let delayTime = DispatchTime.now() + Double(Int64(secs * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            f()
        }
    }

    func genDataElement() -> LocalData {

        var rnd: UInt64 = 0
        arc4random_buf(&rnd, MemoryLayout.size(ofValue: rnd))

        let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: CGFloat(drand48()))

        return LocalData(id: rnd, color: color)
    }
}

extension ViewController: PageableArrayDelegate {
    func loadContentForRange(_ range: CountableRange<UInt>, pageSize: UInt) {
        
        genDataQueue.async {
            
            var data = [LocalData]()
            for _ in 0..<pageSize {
                data.append(self.genDataElement())
            }
            
            let pageNumber = range.lowerBound / pageSize
            let page = Pageable(page: pageNumber, pageSize: pageSize)
            DispatchQueue.main.async {
                
                self.array.updatePage(page, withElements: data)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(array.count)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! Cell
        let data = array[UInt((indexPath as NSIndexPath).item)]
        cell.backgroundColor = data?.color ?? UIColor.clear
        cell.setText(data?.cacheId ?? "N/A")
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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

        return CGSize(width: floor(width), height: floor(width))
    }
}
