# Styleguide

Launchpad widgets, modules, and containers have been documented in a format compatible with the
Launchpad Styleguide, which is powered by [SourceJs](http://sourcejs.com/).

## Prerequisites

* nodejs v4.0.x+
* npm

## Install

```
mvn clean install
```
What does this do?

1. Download Launchpad Styleguide to **target/launchpad-styleguide**
2. Extract Launchpad artifacts into **target/styleguide/user**

## Override user files
   
If you need to override the default configuration add files to `styleguide/user`.

## Run

On Linux/OS X:

```
sh run.sh
```

On Windows:
```
run
```

View the styleguide on ```http://127.0.0.1:8080/```
