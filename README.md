# DataSpace JSPUI Theme
[![CircleCI](https://circleci.com/gh/jrgriffiniii/dataspace-jspui.svg?style=svg)](https://circleci.com/gh/jrgriffiniii/dataspace-jspui)

DataSpace JSP-UI theme for DSpace 5.x installations.

## Building the theme

### Downloading the DSpace source
```
cd dspace-parent
wget "https://github.com/DSpace/DSpace/releases/download/dspace-5.5/dspace-5.5-src-release.zip"
unzip dspace-5.5-src-release.zip
cd -
```

### Installing the Maven dependencies
```
mvn dependency:go-offline
mvn package
```
