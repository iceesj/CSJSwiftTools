Pod::Spec.new do |s|

  s.name          = "CSJSwiftTools"
  s.version       = "0.0.8"
  s.license       = "MIT"
  s.summary       = "曹盛杰Swift工具包"
  s.homepage     = 'https://github.com/iceesj/CSJSwiftTools'
  s.author        = { "iceesj" => "iceesj@gmail.com" }
  s.source       = { :git => 'https://github.com/iceesj/CSJSwiftTools.git', :tag => '0.0.8' }
  s.source_files  = "CSJSwiftTools/*.{swift}"
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '$(inherited) -ObjC'
  }
  s.frameworks    = "CoreLocation", "CoreData"
  s.dependency 'MBProgressHUD'
  s.dependency 'SVProgressHUD'
  s.dependency 'SwiftyJSON'
  s.dependency 'MagicalRecord'
  s.dependency 'Reachability'
  s.dependency 'Alamofire'
  s.dependency 'ObjectMapper'
  
  s.requires_arc = true
  
end