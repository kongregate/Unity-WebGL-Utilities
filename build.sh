#!/bin/bash

if [ -z "$UNITY_DIR" ]; then
  UNITY=/Applications/Unity/Unity.app/Contents/MacOS/Unity
else
  UNITY="$UNITY_DIR/Unity.app/Contents/MacOS/Unity"
fi

PROJECT_DIR=`pwd`
echo "Using Unity Executable: $UNITY"

"$UNITY" -batchmode -projectPath "$PROJECT_DIR" -exportPackage Assets/Plugins \
         "$PROJECT_DIR/KongregateWebGLUtilities.unitypackage" -quit \
         -logFile "$PROJECT_DIR/build.log"
