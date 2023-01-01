//
//  FeedDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import Alamofire


class FeedDataManager {
    var feedList : [Feed] = []
    func getFeedList(delegate: FeedViewController) {
        [
            Feed(profileImageName: "고양이1", id: "cat1", feedImageName: "고양이1", feedText: "날씨가 너무 좋다"),
            Feed(profileImageName: "고양이2", id: "cat2", feedImageName: "고양이2", feedText: "날씨가 너무 좋다"),
            Feed(profileImageName: "고양이3", id: "cat1", feedImageName: "고양이3", feedText: "날씨가 너무 좋다"),
            Feed(profileImageName: "고양이4", id: "cat1", feedImageName: "고양이4", feedText: "날씨가 너무 좋다"),
            Feed(profileImageName: "고양이5", id: "cat1", feedImageName: "고양이5", feedText: "날씨가 너무 좋다"),
            Feed(profileImageName: "고양이7", id: "cat1", feedImageName: "고양이6", feedText: "날씨가 너무 좋다"),
            Feed(profileImageName: "고양이8", id: "cat1", feedImageName: "고양이7", feedText: "날씨가 너무 좋다"),
            Feed(profileImageName: "고양이9", id: "cat1", feedImageName: "고양이8", feedText: "날씨가 너무 좋다"),
            Feed(profileImageName: "고양이10", id: "cat1", feedImageName: "고양이10", feedText: "날씨가 너무 좋다"),
        ].forEach { feed in
            self.feedList.append(feed)
        }
        var response : FeedResponse = FeedResponse(feedList: [])
        response.feedList = feedList
        delegate.didSetFeed(result: response)
        //let url =
        /*
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: StoryResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didSetStory(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
         */
    }
}
