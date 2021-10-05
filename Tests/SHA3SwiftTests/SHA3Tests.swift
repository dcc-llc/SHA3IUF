//
//  Copyright © Interactive Standard, LLC, 2021. All rights reserved.
//

import Foundation
import XCTest
import SHA3Swift
import CryptoSwift

final class SHA3Tests: XCTestCase {

	// This is a lazy way to check the implementation of the wrapper
	func test_Verify_against_CryptoSwift() {
		func test(_ cryptoSwiftSha: SHA3.Variant, _ sha: SHA3Type) {
			let testsCount = 1000

			for _ in 0..<testsCount {
				var data = Data()
				for _ in 0..<Int.random(in: 0...2048) {
					data.append(UInt8.random(in: UInt8.min...UInt8.max))
				}

				XCTAssertEqual(data.sha3(cryptoSwiftSha	), data.sha3(sha))
			}
		}

		let types: [(SHA3.Variant, SHA3Type)] = [
			(.sha256, .sha256),
			(.sha384, .sha384),
			(.sha512, .sha512),
		]

		for (cryptoSwiftSha, sha) in types {
			test(cryptoSwiftSha, sha)
		}
	}
}
