Pod::Spec.new do |s|

  s.name          = "CSJSwiftTools"
  s.version       = "0.0.2"
  s.license       = "MIT"
  s.summary       = "曹盛杰Swift工具包"
  s.homepage     = 'https://github.com/iceesj/CSJSwiftTools'
  s.author        = { "iceesj" => "iceesj@gmail.com" }
  s.source       = { :git => 'https://github.com/iceesj/CSJSwiftTools.git', :tag => '0.0.2' }
  s.source_files  = "CSJSwiftTools/*.{swift}"
  s.platform      = :ios, '8.0'
  s.frameworks    = "Foundation", CoreLocation", "CoreData", "UIKit", "CoreGraphics"
  s.dependency 'MagicalRecord', 'Alamofire', 'SwiftyJSON'
  
  s.requires_arc = true
  
end