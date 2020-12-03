Pod::Spec.new do |s|

  s.name             = "Obvs"
  s.version          = "0.0.1"
  s.summary          = "A simple implementation of an observable sequence that you can subscribe to"
  s.description      = "A simple implementation of an observable sequence that you can subscribe to."
  s.homepage         = "https://github.com/hkellaway/Obvs"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Harlan Kellaway" => "hkellaway@users.noreply.github.com" }
  s.source           = { :git => "https://github.com/hkellaway/Obvs.git", :tag => s.version.to_s }

  s.platforms        = { :ios => "14.0" }
  s.requires_arc     = true
  s.source_files     = "Sources/Obvs/*.swift"

end
