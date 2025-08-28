switch ($args[0]) {
    'build' {
        $IdfImageTag = $args[1]

        &docker buildx build --build-arg IDF_IMAGE_TAG=$IdfImageTag --tag esp32-docker-sonar:$IdfImageTag --no-cache ./src
    }
    'test-docker' {
        $IdfImageTag = $args[1]
        $SonarScannerOrganization = $args[2]
        $SonarScannerToken = $args[3]
        $ProjectPath = $args[4]

        &docker run --rm `
            --env SONARCLOUD_ORGANIZATION=$SonarScannerOrganization `
            --env SONARCLOUD_TOKEN=$SonarScannerToken `
            -v $ProjectPath\:/project `
            -w /project `
            esp32-docker-sonar:$IdfImageTag `
            idf.py build
    }
    'test-docker-no-sonar' {
        $IdfImageTag = $args[1]
        $ProjectPath = $args[2]

        &docker run --rm `
            --env SONARCLOUD_ORGANIZATION= `
            --env SONARCLOUD_TOKEN= `
            -v $ProjectPath\:/project `
            -w /project `
            esp32-docker-sonar:$IdfImageTag `
            idf.py build
    }
    'test-script' {
        &docker run --rm `
            -v "$PSScriptRoot\:/code" `
            bats/bats:latest `
            /code/test --print-output-on-failure --show-output-of-passing-tests
    }
    Default {
        Write-Host "Command not recognized. Valid commands:"
        Write-Host "`t* build {imageTag}: build the image"
        Write-Host "`t* test-docker {imageTag} {sonarScannerOrganization} {sonarScannerToken} {projectPath}: test the image with Sonar Cloud"
        Write-Host "`t* test-docker-no-sonar {imageTag} {projectPath}: test the image without Sonar Cloud"
        Write-Host "`t* test-script: test the bash scripts used by the image"
    }
}
