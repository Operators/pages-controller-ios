Pod::Spec.new do |spec|

spec.name             = "UIPages"
spec.version          = "0.1.0"
spec.summary          = "Enhanced wrapper framework around UIPageViewController"

spec.description      = "Wrapper framework around UIPageViewController that requires a storyboard and string references to the Controllers of the storyboard"

spec.homepage         = "https://github.com/Operators/pages-controller-ios"
spec.license          = "MIT"
spec.authors           = { "Christopher Miller" => "christopher.d.miller.1@gmail.com" }
spec.source           = { :git => "https://github.com/Operators/pages-controller-ios.git", :tag => spec.version.to_s }

spec.ios.deployment_target = "8.0"
spec.source_files     = 'UIPages/**/*'
spec.frameworks = 'UIKit'

end