//
//  Copyright © Interactive Standard, LLC, 2021. All rights reserved.
//

import Foundation
import SHA3IUF


public enum SHA3Type {
	case sha256, sha384, sha512

	public var bitsCount: Int {
		switch self {
			case .sha256:
				return 256
			case .sha384:
				return 384
			case .sha512:
				return 512
		}
	}

	public var bytesCount: Int {
		bitsCount / 8
	}
}

public extension Data {
	func sha3(_ variant: SHA3Type) -> Data {
		let ctx = UnsafeMutablePointer<sha3_context>.allocate(capacity: 1)
		defer { ctx.deallocate() }

		sha3_Init(&ctx.pointee, UInt32(variant.bitsCount))

		withUnsafeBytes { pointer in
			sha3_Update(&ctx.pointee, pointer.baseAddress, pointer.count)
		}

		let result =  sha3_Finalize(&ctx.pointee)!
		return Data(bytes: result, count: variant.bytesCount)
	}
}
