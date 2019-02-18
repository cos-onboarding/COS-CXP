## Prerequisites

 * Setup your SSH key in bitbucket or stash

### Initial/clean build

To create the database:
```
mvn clean install -Pclean-database
```

> Hint: If you want to modify the data provided in demo, you can modify the files under the path:
> 
> ```
> [project-folder]/webapps/portalserver/src/main/resources/mock-data/
> ```
> 
> And recreate the database with the command: `mvn clean install -Pclean-database`

## Running the webapps

### Running all 5 webapps at once:

 - On Linux/OS X: `bash run.sh`
 - On Windows: `run.bat`

* To run webapps in the background add `-b` flag  (Linux/OS x only)
* To run with demo services add `-d` flag

### Running webapps individually

Web applications are inside `webapps` directory

* portalserver
* contentservices
* orchestrator
* search
* solr

Each webapp has a `run` script.
To run portal with demo services use `run_with_demo` script.


## Import the CXP Manager, Universal Catalog, Dasboard, Retail Collection, and Demo Portal

Wait until portal has started.

Change your working directory to `statics/collection`:

```
cd statics/collection
mvn clean install -Psetup-collections
```

### (Optional) Select another Launchpad version

To change the version of Launchpad to install modify the tag in the root pom.xml:
```  
  <launchpad.version>[version]</launchpad.version>
```

---

### (Optional) Customizing i18n

The mechanism of i18n is based on a chain that will evaluate in the next order:

> look for *user* defined locale (lpLocale), if not present
> look for *page* defined locale (locale), if not present
> look for *portal* defined locale (locale), if not present
> look for *property* defined locale, if not present will throw an exception.

The evaluation order can be changed at code level, modifying the value in the `getOrder` method per handler:

```
@Override
public int getOrder() {
    return 1; // The higher the value the lower the precedence.
}
```

The property should be defined in the `backbase.properties` file as for example: `launchpad.defaultLocale=en-US`
