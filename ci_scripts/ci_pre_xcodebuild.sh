#!/bin/sh

#  ci_pre_xcodebuild.sh
#  Manlingua2
#
#  Created by Paulus Michael on 09/10/24.
#  

bash
#!/bin/bash
# Change to the project directory
cd ..
# Resolve Swift package dependencies
echo "Resolving Swift package dependencies..."
if [ -f "Manlingua2.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
    echo "Package.resolved already exists."
else
    echo "Resolving packages..."
    xcodebuild -resolvePackageDependencies -project Manlingua2.xcodeproj
fi
