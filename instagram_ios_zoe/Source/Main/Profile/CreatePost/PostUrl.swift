//
//  PostUrl.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/09.
//
import UIKit

class PostUrl {
    static let shared = PostUrl()
    var thumnail : UIImage?
    var postUrl : [String] = []
    var data : [Data] = []
    // Create
    public func addData(_ data: Data) {
        self.data.append(data)
    }
    public func add(_ postUrl: String) {
        self.postUrl.append(postUrl)
    }
    public func removeAll() {
        data = []
    }
    public func read(at : Int) -> String{
        return self.postUrl[at]
    }
    public func readData(at : Int) -> Data{
        return self.data[at]
    }
    public func dataCount() -> Int {
        return self.data.count
    }
}
