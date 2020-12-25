//
//  YoutubeLinkExtractorTests.swift
//  YoutubeLinkExtractorTests
//
//  Created by Cong Le on 12/24/20.
//

import Foundation
import XCTest
@testable import YoutubeLinkExtractor

class YoutubeLinkExtractorTests: XCTestCase {

  let stubAllQualities = String(contentsOfBundleFile: "ResponseAllQualities", type: "txt")
  let stubUpToMediumQualities = String(contentsOfBundleFile: "ResponseUpToMediumQualities", type: "txt")
  
  func testExtractsInfoForAllQualities() {
    // when
    let result = YoutubeLinkExtractor().extractInfo(from: stubAllQualities ?? "ResponseAllQualities file is empty")
    
    // then
    XCTAssertEqual(result.0.count, 2)
  }
  
  func testExtractsInfoForUpToMediumQualities() {
    // when
    let result = YoutubeLinkExtractor().extractInfo(from: stubUpToMediumQualities ?? "ResponseUpToMediumQualities file is empty")
    
    // then
    XCTAssertEqual(result.0.count, 1)
  }
  
  // MARK: - Real-world testing
  
  let testRealApi = false
  
  func testRealExtractInfo() {
    guard testRealApi else { return }
    
    // given
    let videoId = "Jvph0r09nDU"
    let expectation = XCTestExpectation(description: "Get callback fired")
    
    // then
    YoutubeLinkExtractor().extractInfo(for: .id(videoId), success: { info in
      expectation.fulfill()
    }) { error in
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 10)
  }
  
  func testRealExtractRawInfo() {
    guard testRealApi else { return }
    
    // given
    let videoId = "hMloyp6NI4E"
    let expectation = XCTestExpectation(description: "Get callback fired")
    
    // then
    YoutubeLinkExtractor().extractRawInfo(for: .id(videoId)) { info, error in
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 10)
  }
  
  func testRealExtractInfoSuccess() {
    guard testRealApi else { return }
    
    // given
    let videoId = "kOZ3YsdfdSg"
    let expectation = XCTestExpectation(description: "Get callback fired")
    
    // then
    YoutubeLinkExtractor().extractInfo(for: .id(videoId), success: { info in
      expectation.fulfill()
    }) { error in
      XCTFail("Error: \(error)")
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 10)
  }
}
