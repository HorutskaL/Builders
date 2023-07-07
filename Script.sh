#!/bin/bash

# Checkout stage
echo "This stage reads the repository"
git clone https://github.com/HorutskaL/Builders.git

# Build stage
buildTool="$1"
buildCommand=""

if [ "$buildTool" = "maven" ]; then
    buildCommand="mvn clean install"
elif [ "$buildTool" = "gradle" ]; then
    buildCommand="gradle clean build"
else
    echo "Invalid build tool: $buildTool"
    exit 1
fi

echo "Executing build command: $buildCommand"
$buildCommand

# Post-build stages
if [ "$BUILD_STATUS" = "SUCCESS" ]; then
    # Automatically apply first promotion (QA) on successful build
    read -p "Please approve the deployment to QA. [Y/n]: " -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Deployment to QA approved."
        # Add your commands for the QA promotion here
    else
        echo "Deployment to QA not approved."
        # Add your commands for the case when QA promotion is not approved here
    fi
else
    # Require manual input to proceed with the second promotion (Prod)
    read -p "Please approve the deployment to Prod. [Y/n]: " -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Deployment to Prod approved."
        # Add your commands for the Prod promotion here
    else
        echo "Deployment to Prod not approved."
        # Add your commands for the case when Prod promotion is not approved here
    fi
fi
