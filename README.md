# ESP-IDF Docker Image with Sonar Cloud

[![GitHub Release Status][git-bagdge-release]][git-release] [![Bugs][sonar-badge-bugs]][sonar-home] [![Code Smells][sonar-badge-smells]][sonar-home] [![Security Rating][sonar-badge-security]][sonar-home] [![Quality Gate Status][sonar-badge-quality]][sonar-home]  

Docker image for the [Espressif IoT Development Framework (ESP-IDF)][esp-idf-site], with [Sonar Cloud][sonar-site] **C/C++ code analysis support**. It is intended for building applications and libraries with specific versions of ESP-IDF, when doing automated builds.

This image contains a copy of ESP-IDF and all the tools necessary to build **and analyze** ESP-IDF projects.

## Characteristics

* Inherits from the [official ESP-IDF Docker image][esp-docker].
* Has the same usage as the official image.
* Adds only two Sonar softwares:
  * [Sonar Cloud Scanner CLI][sonar-doc-cli]
  * [Sonar Cloud C/C++ Build Wrapper][sonar-doc-wrapper]

## Tags

ESP-IDF release:

* [v5.3](https://hub.docker.com/r/gfurtadoalmeida/esp32-docker-sonar/tags?page=1&name=v5.3)
* [v4.4.8](https://hub.docker.com/r/gfurtadoalmeida/esp32-docker-sonar/tags?page=1&name=v4.4.8)

## Basic Usage

Build a project located in the current directory using `idf.py build` command.  
Code will be analyzed, and results will be sent to Sonar Cloud, automatically.  
Omitting the environment variables will disable code analysis.

```bash
docker run --rm \
           --env SONARCLOUD_ORGANIZATION=yourSonarCloudOrganizationName \
           --env SONARCLOUD_TOKEN=yourSonarCloudOrganizationToken \
           --env SONARCLOUD_BRANCH=master \
           -v $PWD:/project \
           -w /project \
           gfurtadoalmeida/esp32-docker-sonar:v5.1 \
           idf.py build
```

## Documentation

For more information about this image and the detailed usage instructions, please refer to the ESP-IDF Programming Guide page: [IDF Docker Image][esp-doc-docker].

:warning: Your project must have a [sonar-project.properties][sonar-doc-analysis] file when running code analysis.

### Environment Variables

* **SONARCLOUD_BRANCH**: the branch name to set on `sonar.branch.name`.
* **SONARCLOUD_ORGANIZATION**: the organization name to set on `sonar.organization`.
* **SONARCLOUD_TOKEN**: the token to set on `sonar.token`. If empty code analysis will not be run.
* **BUILD_WRAPPER_OUTPUT_DIR**: output path for the [Sonar Cloud Build Wrapper][sonar-doc-wrapper] (defaults to `build_wrapper_output` if not passed).

## Contributing

To contribute to this project make sure to read our [CONTRIBUTING.md](/docs/CONTRIBUTING.md) file.

[esp-doc-docker]: https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-guides/tools/idf-docker-image.htm
[esp-docker]: https://hub.docker.com/r/espressif/idf
[esp-idf-site]: https://docs.espressif.com/projects/esp-idf/en/latest/esp32/index.html
[git-bagdge-release]: https://github.com/gfurtadoalmeida/esp32-docker-sonar/actions/workflows/release.yml/badge.svg
[git-release]: https://github.com/gfurtadoalmeida/esp32-docker-sonar/releases
[sonar-badge-bugs]: https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=bugs
[sonar-badge-quality]: https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=alert_status
[sonar-badge-security]: https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=security_rating
[sonar-badge-smells]: https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=code_smells
[sonar-doc-cli]: https://docs.sonarcloud.io/advanced-setup/ci-based-analysis/sonarscanner-cli/
[sonar-doc-wrapper]: https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/languages/c-family/#using-build-wrapper
[sonar-doc-analysis]: https://docs.sonarcloud.io/advanced-setup/analysis-parameters/
[sonar-home]: https://sonarcloud.io/project/overview?id=esp32_docker_sonar
[sonar-site]: https://www.sonarsource.com/products/sonarcloud/