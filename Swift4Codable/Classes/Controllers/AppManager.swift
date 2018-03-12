//
//  AppManager.swift
//  RepliconTest
//
//  Created by Sayan Chatterjee on 12/03/18.
//  Copyright © 2018 Vaoprware Solutions. All rights reserved.
//

import Foundation

class AppManager: NSObject {

    private var photos : Array<Photo>!

    public static let sharedInstance = AppManager()

    private override init() {
//        self.photos = Array<Ph>;
    }

    public func getAllPhotosFromRemote(completion : @escaping (_ status : Dictionary<String , Any>) -> Void) {
        NetworkManager.sharedInstance.getDataFromURL(
            urlString: ConstantHelper.API_BASE_URL, params: nil,
            sucess: { (response : Data!, msg : String) in
                do{
                    let jsonDecoder = JSONDecoder()
                    self.photos = try jsonDecoder.decode([Photo].self, from: response!)
                    completion(["status" : CompletionStatus.Success.rawValue, "msg" : msg]);
                }
                catch {
                    completion(["status" : CompletionStatus.Success.rawValue, "msg" : "Parsing Error"]);
                }
        } , failure: { (error : Error, msg : String) in
            completion(["status" : CompletionStatus.Failure.rawValue, "msg" : error.localizedDescription]);
        })
    }

    public func getNumberOfPhotosDownloaded () -> Int{
        var count = 0;
        if self.photos != nil {
            count = (self.photos.count);
        }
        return count;
    }

    private func getPhotoById(id : Int) -> Photo {
        return self.photos.filter{$0.id == id}.first!
    }

    private func getPhotoIdForIndex(index : Int) -> Photo{
        let photo = self.photos?[index];
        return photo!;
    }

    public func getPhotoTitleForId(id : Int) -> String {
        let photo = getPhotoById(id: id) as Photo
        if (photo.title) != nil {
            return (photo.title)!
        } else {
            return "";
        }
    }

    public func getPhotoIdForIndex(index : Int) -> Int {
        let photo = getPhotoIdForIndex(index: index) as Photo
        if (photo.id) != nil {
            return (photo.id)!
        } else {
            return -1;
        }
    }

    public func getPhotoThumbnailForId(id : Int) -> String {
        let photo = getPhotoById(id: id) as Photo
        if (photo.thumbnailUrl) != nil {
            return (photo.thumbnailUrl)!
        } else {
            return "";
        }
    }
}
