# ESP-IDF Docker Image with Sonar Cloud

![GitHub Build Status](https://github.com/gfurtadoalmeida/esp32-docker-sonar/actions/workflows/build.yml/badge.svg) [![Bugs](https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=bugs)](https://sonarcloud.io/summary/new_code?id=esp32_docker_sonar) [![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=code_smells)](https://sonarcloud.io/summary/new_code?id=esp32_docker_sonar) [![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=sqale_rating)](https://sonarcloud.io/summary/new_code?id=esp32_docker_sonar) [![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=security_rating)](https://sonarcloud.io/summary/new_code?id=esp32_docker_sonar) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=esp32_docker_sonar&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=esp32_docker_sonar)  
Docker image for the [Espressif IoT Development Framework (ESP-IDF)](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/index.html), with [Sonar Cloud](https://www.sonarsource.com/products/sonarcloud/) C/C++ code analysis support.  
It is intended for building applications and libraries with specific versions of ESP-IDF, when doing automated builds.

This image contains a copy of ESP-IDF and all the tools necessary to build ESP-IDF projects, with code analysis support.

## Characteristics

* Inherits from the [official ESP-IDF Docker image](https://hub.docker.com/r/espressif/idf).
* Tags
  * [v4.4.5](https://hub.docker.com/r/espressif/idf/tags?page=1&name=v4.4.5)
  * [v5.1](https://hub.docker.com/r/espressif/idf/tags?page=1&name=v5.1)
* Added software:
  * [Java SE Platform 17](https://openjdk.org/projects/jdk/17/)
  * [Sonar Cloud Scanner CLI](https://docs.sonarcloud.io/advanced-setup/ci-based-analysis/sonarscanner-cli/)
  * [Sonar Cloud C/C++ Build Wrapper](https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/languages/c-family/#using-build-wrapper)

## Environment Variables

### Mandatory

* `SONAR_ORGANIZATION_NAME`: a Sonar Cloud organization name.
* `SONAR_ORGANIZATION_TOKEN`: a Sonar Cloud organization token.

### Optional

* `RUN_SONAR`: if it should run Sonar Cloud analysis.
  * `1`: run analysis (default).
  * `0`: skip analysis.
* `SONAR_WRAPPER_OUTPUT_DIR`: output path for the [Sonar Cloud Build Wrapper](https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/languages/c-family/#using-build-wrapper). Defaults to `build_wrapper_output`.

## Example

```bash
docker run --rm \
           --env SONAR_ORGANIZATION_NAME=yourSonarOrganizationName \
           --env SONAR_ORGANIZATION_TOKEN=yourSonarOrganizationToken \
           -v $PWD:/project \
           -w /project \
           gfurtadoalmeida/esp32-docker-sonar:v5.1
```
