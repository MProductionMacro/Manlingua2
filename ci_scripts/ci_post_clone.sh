bash
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
# BASED ON MY EXPERIENCE xcshareddata DIRECTORY IS NOT EXIST, YOU NEED TO CREATE THE DIRECTORY
mkdir Manlingua2.xcodeproj/project.xcworkspace/xcshareddata
# BASED ON MY EXPERIENCE swiftpm DIRECTORY IS NOT EXIST, YOU NEED TO CREATE THE DIRECTORY
mkdir Manlingua2.xcodeproj/project.xcworkspace/xcshareddata/swiftpm
# BASED ON MY EXPERIENCE Package.resolved DIRECTORY IS NOT EXIST, YOU NEED TO CREATE THE DIRECTORY
touch Manlingua2.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved
echo "Creating Package.resolved..."
cat <<EOL > Manlingua2.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved
# CREATE YOUR EXAMPLE DEPENDENCY HERE, ONLY FOR CREATING Package.resolved
{
  "version" : 3,
  "object" : {
    "pins" : [
      {
        "package" : "firebase-ios-sdk",
        "repositoryURL" : "https://github.com/firebase/firebase-ios-sdk.git",
        "state" : {
          "branch" : null,
          "revision" : "latest",
          "version" : "11.3.0"
        }
      }
    ]
  }
}
EOL
# Resolve package dependencies to generate Package.resolved
echo "Resolving package dependencies..."
xcodebuild -resolvePackageDependencies -project Manlingua2.xcodeproj -scheme Manlingua2
# Check if Package.resolved was created
if [ -f "Manlingua2.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
    echo "Package.resolved generated successfully."
else
    echo "Failed to generate Package.resolved."
    exit 1
fi
