#!/bin/bash

sdk install java 17.0.9-tem
sdk install maven

java -version
mvn -version

mvn clean package -DskipTests
