
#!/bin/bash
# Install XcodeGen if it's not already installed
if ! command -v xcodegen &> /dev/null; then
   echo "XcodeGen not found. Installing..."
   brew install xcodegen
fi
ls .
# Change to the project directory
cd ..
# ALL STEPS AFTER CLONE PROJECT
# Generate the Xcode project using XcodeGen
echo "Generating Xcode project..."
xcodegen
echo "Check file on .xcodeproj"
ls Manlingua2.xcodeproj
echo "Check file on project.xcworkspace"
echo "Check file on xcshareddata"
ls Manlingua2.xcodeproj/project.xcworkspace/xcshareddata
# Ensure necessary directories exist
mkdir -p Manlingua2.xcodeproj/project.xcworkspace/xcshareddata/swiftpm

# Remove any pre-existing Package.resolved file to avoid conflicts
rm -f Manlingua2.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved

# Resolve package dependencies to generate a new Package.resolved file
echo "Resolving package dependencies..."
xcodebuild -resolvePackageDependencies -project Manlingua2.xcodeproj -scheme Manlingua2

# Check if Package.resolved was created
if [ -f "Manlingua2.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
   echo "Package.resolved generated successfully."
else
   echo "Failed to generate Package.resolved."
   exit 1
fi
