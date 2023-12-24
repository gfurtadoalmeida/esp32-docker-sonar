# ESP-IDF Docker Image with Sonar Cloud

![GitHub Build Status](https://github.com/gfurtadoalmeida/esp32-docker-sonar/actions/workflows/release.yml/badge.svg) [![Bugs](https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=bugs)](https://sonarcloud.io/summary/new_code?id=esp32_docker_sonar) [![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=code_smells)](https://sonarcloud.io/summary/new_code?id=esp32_docker_sonar) [![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=sqale_rating)](https://sonarcloud.io/summary/new_code?id=esp32_docker_sonar) [![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=security_rating)](https://sonarcloud.io/summary/new_code?id=esp32_docker_sonar) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=esp32_docker_sonar)  
Docker image for the [Espressif IoT Development Framework (ESP-IDF)](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/index.html), with [Sonar Cloud](https://www.sonarsource.com/products/sonarcloud/) **C/C++ code analysis support**. It is intended for building applications and libraries with specific versions of ESP-IDF, when doing automated builds.

This image contains a copy of ESP-IDF and all the tools necessary to build **and analyse** ESP-IDF projects.

## Characteristics

* Inherits from the [official ESP-IDF Docker image](https://hub.docker.com/r/espressif/idf).
* Has the same usage as the official image.
* Added software:
  * [Sonar Cloud Scanner CLI](https://docs.sonarcloud.io/advanced-setup/ci-based-analysis/sonarscanner-cli/)
  * [Sonar Cloud C/C++ Build Wrapper](https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/languages/c-family/#using-build-wrapper)

## Tags

ESP-IDF release:

* [v5.1](https://hub.docker.com/r/gfurtadoalmeida/esp32-docker-sonar/tags?page=1&name=v5.1) ([official](https://hub.docker.com/r/espressif/idf/tags?page=1&name=v5.1))
* [v4.4.5](https://hub.docker.com/r/gfurtadoalmeida/esp32-docker-sonar/tags?page=1&name=v4.4.5) ([official](https://hub.docker.com/r/espressif/idf/tags?page=1&name=v4.4.5))

## Basic Usage

Build a project located in the current directory using `idf.py build` command.  
Code will be analyzed, and results will be sent to Sonar Cloud, automatically.  
Omitting the environment variables will disable code analysis.

```bash
docker run --rm \
           --env SONARCLOUD_ORGANIZATION=yourSonarCloudOrganizationName \
           --env SONARCLOUD_TOKEN=yourSonarCloudOrganizationToken \
           -v $PWD:/project \
           -w /project \
           gfurtadoalmeida/esp32-docker-sonar:v5.1 \
           idf.py build
```

## Documentation

For more information about this image and the detailed usage instructions, please refer to the ESP-IDF Programming Guide page: [IDF Docker Image](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-guides/tools/idf-docker-image.html).

:warning: Your project must have a [sonar-project.properties](https://docs.sonarcloud.io/advanced-setup/analysis-parameters/) file when running code analysis.

### Environment Variables

* `SONARCLOUD_ORGANIZATION`: a Sonar Cloud organization name.
* `SONARCLOUD_TOKEN`: a Sonar Cloud organization token. If empty code analysis will not be run.
* `BUILD_WRAPPER_OUTPUT_DIR`: output path for the [Sonar Cloud Build Wrapper](https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/languages/c-family/#using-build-wrapper) (defaults to `build_wrapper_output` if not passed).
