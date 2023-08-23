switch ($args[0]) {
    'build' {
        $IdfImageTag = $args[1]
        $SonarScannerVersion = $args[2]

        &docker buildx build --build-arg IDF_IMAGE_TAG=$IdfImageTag --build-arg SONAR_SCANNER_VERSION=$SonarScannerVersion --tag esp32-docker-sonar:$IdfImageTag --no-cache ./src
    }
    'test' {
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
    'test-without-sonar' {
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
    Default {
        Write-Host 'Script arguments:'
        Write-Host "`tbuild {imageTag} {sonarScannerVersion}"
        Write-Host "`ttest {imageTag} {sonarScannerOrganization} {sonarScannerToken} {projectPath}"
        Write-Host "`ttest-without-sonar {imageTag} {projectPath}"
    }
}
