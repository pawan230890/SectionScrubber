import UIKit

class RemoteCollectionController: UICollectionViewController, DateScrubberDelegate {
    var sections = Photo.constructRemoteElements()
    var numberOfItems = 0

    let dateScrubber = DateScrubber()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.registerClass(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.Identifier)

        var count = 0
        for i in 0..<self.sections.count {
            let photos = self.sections[i]
            count += photos.count
        }
        self.numberOfItems = count

        self.dateScrubber.delegate = self
        self.view.addSubview(dateScrubber.view)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let columns = CGFloat(4)
        let bounds = UIScreen.mainScreen().bounds
        let size = (bounds.width - columns) / columns
        layout.itemSize = CGSize(width: size, height: size)

        self.dateScrubber.containingViewFrame = CGRectMake(0,64,self.view.bounds.width, self.view.bounds.height-64)
        self.dateScrubber.containingViewContentSize = self.collectionView!.contentSize
        self.dateScrubber.updateFrame(scrollView: self.collectionView!)
    }

    func alertControllerWithTitle(title: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        return alertController
    }
}

extension RemoteCollectionController {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.sections.count
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let photos = self.sections[section]
        return photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoCell.Identifier, forIndexPath: indexPath) as! PhotoCell
        let photos = self.sections[indexPath.section]
        let photo = photos[indexPath.row]
        cell.display(photo)

        return cell
    }
}

extension RemoteCollectionController{
    override func scrollViewDidScroll(scrollView: UIScrollView){
        dateScrubber.updateFrame(scrollView: scrollView)
    }
}