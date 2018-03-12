//
//  PhotosViewController.swift
//  RepliconTest
//
//  Created by Sayan Chatterjee on 12/03/18.
//  Copyright © 2018 Vaoprware Solutions. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var photoTableView: UITableView!

    @IBOutlet weak var loadingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Photos"

        AppManager.sharedInstance.getAllPhotosFromRemote { (status :Dictionary<String, Any>) in
            DispatchQueue.main.async {
                let downloadStatus = status["status"] as! String
                if downloadStatus == CompletionStatus.Success.rawValue {
                    self.photoTableView.reloadData()
                    self.photoTableView.backgroundColor = UIColor.clear
                    self.photoTableView.isHidden = false
                    self.loadingView.isHidden = true
                }
                else {
                    //Show alert
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PhotosViewController : UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let rows = AppManager.sharedInstance.getNumberOfPhotosDownloaded();
        return rows
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "PhotoCell";
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PhotoTableViewCell
        (cell ).setupCell(id: AppManager.sharedInstance.getPhotoIdForIndex(index: indexPath.row))
        return cell;
    }
}

extension PhotosViewController : UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 50.0
        if indexPath.row < AppManager.sharedInstance.getNumberOfPhotosDownloaded() {
            height = 200.0;
        }
        return CGFloat(height);
    }
}
