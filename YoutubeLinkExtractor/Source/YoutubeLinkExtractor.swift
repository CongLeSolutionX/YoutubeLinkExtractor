//
//  YoutubeLinkExtractor.swift
//  YoutubeLinkExtractor
//
//  Created by Cong Le on 12/24/20.
//

import Foundation

public class YoutubeLinkExtractor {
  
  private let infoBasePrefix = "https://www.youtube.com/get_video_info?video_id="
  private let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/604.5.6 (KHTML, like Gecko) Version/11.0.3 Safari/604.5.6"
  
  private var session: URLSession
  
  // MARK: - Public
  
  public init(session: URLSession) {
    self.session = session
  }
  
  public convenience init() {
    self.init(session: URLSession.shared)
  }
  
  public func extractInfo(for source: ExtractionSource,
                          success: @escaping (VideoInfo) -> Void,
                          failure: @escaping (Swift.Error) -> Void) {
    
    extractRawInfo(for: source) { info, error in
      
      if let error = error {
        failure(error)
        return
      }
      
      guard info.count > 0 else {
        failure(Error.unkown)
        return
      }
      
      success(VideoInfo(rawInfo: info))
    }
  }
}
// MARK: - Internal methods and logic
extension YoutubeLinkExtractor {
  private func extractRawInfo(for source: ExtractionSource,
                              completion: @escaping ([[String: String]], Swift.Error?) -> Void) {
    
    guard let id = source.videoId else {
      completion([], Error.cantExtractVideoId)
      return
    }
    
    guard let infoUrl = URL(string: "\(infoBasePrefix)\(id)") else {
      completion([], Error.cantConstructRequestUrl)
      return
    }
    
    let request = NSMutableURLRequest(url: infoUrl)
    request.httpMethod = "GET"
    request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
    
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
      
      guard let data = data else {
        completion([], error ?? Error.noDataInResponse)
        return
      }
      
      guard let dataString = String(data: data, encoding: .utf8) else {
        completion([], Error.cantConvertDataToString)
        return
      }
      
      let extractionResult = self.extractInfo(from: dataString)
      completion(extractionResult.0, extractionResult.1)
      
    }
    task.resume()
  }
  
  private func extractInfo(from string: String) -> ([[String: String]], Swift.Error?) {
    let pairs = string.queryComponents()
    
    guard let playerResponse = pairs["player_response"], !playerResponse.isEmpty else {
      let error = YoutubeError(errorDescription: pairs["reason"])
      return ([], error ?? Error.cantExtractURLFromYoutubeResponse)
    }
    
    guard let playerResponseData = playerResponse.data(using: .utf8),
          let playerResponseJSON = (try? JSONSerialization.jsonObject(with: playerResponseData, options: [])) as? [String: Any],
          let streamingData = playerResponseJSON["streamingData"] as? [String: Any],
          let formats = streamingData["formats"] as? [[String: Any]] else {
      return ([], Error.cantExtractURLFromYoutubeResponse)
    }
    
    let arrayUrls: [[String: String]] = formats
      .compactMap { $0["url"] as? String }
      .map { ["url": $0] }
    
    return (arrayUrls, nil)
  }
}
