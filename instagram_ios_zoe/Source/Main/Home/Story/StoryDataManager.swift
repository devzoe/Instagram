//
//  StoryDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import Alamofire


class StoryDataManager {
    var storyList : [Story] = []
    func getStoryList(delegate: StoryViewController) {
        [
            Story(profileImageName: "고양이1", id: "cat1"),
            Story(profileImageName: "고양이2", id: "cat2"),
            Story(profileImageName: "고양이3", id: "cat3"),
            Story(profileImageName: "고양이4", id: "cat4"),
            Story(profileImageName: "고양이5", id: "cat5"),
            Story(profileImageName: "고양이6", id: "cat6"),
            Story(profileImageName: "고양이7", id: "cat7"),
            Story(profileImageName: "고양이8", id: "cat8"),
            Story(profileImageName: "고양이9", id: "cat9"),
            Story(profileImageName: "고양이10", id: "cat10"),
        ].forEach { story in
            self.storyList.append(story)
        }
        var response : StoryResponse = StoryResponse(storyList: [])
        response.storyList = storyList
        delegate.didSetStory(result: response)
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
