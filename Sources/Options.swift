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

var config = Config.sharedInstance

public struct Config {
    
    static var sharedInstance = Config()
    
    var host = "localhost"
    var port: Int32 = 1883
    
    var protocolName: String
    var protocolVersion: UInt8
    
    var clientId: String
    var username: String?
    var password: String?
    var dup: Bool
    var qos: qosType
    var retain: Bool

    var cleanSession: Bool
    var secureMQTT: Bool = false
    var willTopic: String?
	var willPayload: [Byte]
	var willQos: qosType
	var willRetain: Bool
	var keepAlive: UInt16
	var pingTimeout: UInt16
	var connectTimeout: UInt16
	var maxReconnectInterval: UInt16
	var autoReconnect: Bool
	var writeTimeout: UInt16?
    var status: connectionStatus
    var will: LastWill? = nil
    
    var flags: UInt8 {
        get {
            return (cleanSession.toByte << 1 | (will != nil).toByte << 2 | willQos.rawValue << 3  |
                willRetain.toByte << 5 | (password != nil).toByte << 6 | (username != nil).toByte << 7)
        }
    }

    private init() {
        protocolName = "MQTT"
        protocolVersion = 4
        
        host = "localhost"
        port = 1883
        
        clientId = ""
        username = nil
        password = nil
        
        dup = true
        qos = qosType.atMostOnce
        retain = true
        
        cleanSession = true
        willTopic = nil
        willPayload = [Byte]()
        willQos = .atMostOnce
        willRetain = false
        
        
        keepAlive = 10
        pingTimeout = 10
        connectTimeout = 30
        maxReconnectInterval = 10
        autoReconnect = true
        writeTimeout = nil
        status = .disconnected

    }

    mutating func addBroker(host: String, port: Int32) {
        self.host = host
        self.port = port
    }
    mutating func setUser(clientId: String, username: String? = nil, password: String? = nil){
        self.clientId = clientId
        self.username = username
        self.password = password
    }
}
