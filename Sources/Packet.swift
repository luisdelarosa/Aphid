/**
 Copyright IBM Corporation 2016

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import Socket


protocol ControlPacket {
    var description: String { get }
    mutating func write(writer: SocketWriter) throws
    mutating func unpack(reader: SocketReader)
    func validate() -> ErrorCodes
}

public enum ControlCode: Byte {
    case connect    = 0x10
    case connack    = 0x20
    case publish    = 0x30
    case puback     = 0x40
    case pubrec     = 0x50
    case pubrel     = 0x62
    case pubcomp    = 0x70
    case subscribe  = 0x82
    case suback     = 0x90
    case unsubscribe = 0xa2
    case unsuback   = 0xb0
    case pingreq    = 0xc0
    case pingresp   = 0xd0
    case disconnect = 0xe0
    case reserved   = 0xf0
}

public enum ErrorCodes: Byte, ErrorProtocol {
    case accepted                       = 0x00
    case errRefusedBadProtocolVersion   = 0x01
    case errRefusedIDRejected           = 0x02
    case errServerUnavailable           = 0x03
    case errBadUsernameOrPassword       = 0x04
    case errNotAuthorize                = 0x05
    case errUnknown                     = 0x06
    
    case errConnectionNotMade           = 0x07
    case errAlreadyDisconnected         = 0x08
}

public enum connectionStatus: Int {
    case connected = 1
    case disconnected = -1
    case connecting = 0
}

public struct LastWill {
    let topic: String
    let message: String?
    let qos: qosType
    let retain: Bool
}

public enum qosType: Byte {
    case atMostOnce = 0x00  // At Most One Delivery
    case atLeastOnce = 0x01 // At Least Deliver Once
    case exactlyOnce = 0x02 // Deliver Exactly Once
}
