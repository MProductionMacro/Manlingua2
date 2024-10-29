bash
#!/bin/bash
# Install XcodeGen if it's not already installed
if ! command -v xcodegen &> /dev/null; then
    echo "XcodeGen not found. Installing..."
    brew install xcodegen
fi

# List current directory contents
ls .

# Change to the project directory
cd ..

# Generate the Xcode project using XcodeGen
echo "Generating Xcode project..."
xcodegen

# Resolve package dependencies to ensure Firebase is properly added
echo "Resolving package dependencies..."
xcodebuild -resolvePackageDependencies -project Manlingua2.xcodeproj -scheme Manlingua2

# Check if Package.resolved was created
if [ -f "Manlingua2.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
    echo "Package.resolved generated successfully."
else
    echo "Failed to generate Package.resolved."
    exit 1
fi
