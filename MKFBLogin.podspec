Pod::Spec.new do |spec|

spec.name = "MKFBLogin"
spec.version = "0.0.1"
spec.summary = 'This is an iOS library that shows an image,Pdf,Audio,Video.'

spec.description = <<-DESC
TODO: This is an iOS library that shows an image,Pdf,Audio,Video with a page count. Users can scroll through local and remote         image,Pdf,Audio,Video.
DESC


spec.homepage         = 'https://gitlab.coruscate.in:8443/mobility-okr/manan-kakadiya.git'

# spec.screenshots = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

# ――― Spec License ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#

# Licensing your code is important. See https://choosealicense.com for more info.

# CocoaPods will detect a license file if there is a named LICENSE*

# Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
#

# spec.license = "MIT (example)"
spec.license = { :type => "MIT", :file => "LICENSE" }

# ――― Author Metadata ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

spec.author = { "@manan.kakadiya" => "manan.kakadiya@coruscate.work" }

# Or just: spec.author = "@manan.kakadiya"

# spec.authors = { "@manan.kakadiya" => "manan.kakadiya@coruscate.work" }

# spec.social_media_url = "@manan.kakadiya"' target='_blank' >https://twitter.com/@manan.kakadiya"

spec.ios.deployment_target = '10.0'
spec.pod_target_xcconfig = { "SWIFT_VERSION" => "5.0" }
spec.requires_arc = true
spec.source_files = 'MKFBLogin/Classes/**/*.{swift,h,m}'

spec.source = { :git => 'https://gitlab.coruscate.in:8443/mobility-okr/manan-kakadiya.git', :tag => spec.version.to_s }

spec.public_header_files = "Classes/*/.h"
spec.resource_bundles = {
    'MKFBLogin' => ['MKFBLogin/Classes/**/*.{storyboard,xib,xcassets,json,imageset,png}']
}

# ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#

# A list of resources included with the Pod. These are copied into the

# target bundle with a build phase script. Anything else will be cleaned.

# You can preserve files from being cleaned, please don't preserve

# non-essential files like tests, examples and documentation.
#

# spec.resource = "icon.png"

# spec.resources = "Resources/*.png"

# spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

# ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#

# Link your library with frameworks, or libraries. Libraries do not include

# the lib prefix of their name.
#

# spec.framework = "GoogleSignIn.framework"

# spec.frameworks = "SomeFramework", "AnotherFramework"

# spec.library = "iconv"

# spec.libraries = "iconv", "xml2"

# ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#

# If your library depends on compiler flags you can set them in the xcconfig hash

# where they will only apply to your library. If you depend on other Podspecs

# you can include multiple dependencies to ensure it works.

# spec.requires_arc = true

# spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

 spec.dependency "FBSDKLoginKit"
 spec.dependency "TwitterKit"
end
