var ENV = require("system").env,
    FILE = require("file"),
    JAKE = require("jake"),
    task = JAKE.task,
    FileList = JAKE.FileList,
    app = require("cappuccino/jake").app,
    configuration = ENV["CONFIG"] || ENV["CONFIGURATION"] || ENV["c"] || "Debug",
    OS = require("os");

app ("githubfollowers", function(task)
{
    task.setBuildIntermediatesPath(FILE.join("Build", "githubfollowers.build", configuration));
    task.setBuildPath(FILE.join("Build", configuration));

    task.setProductName("githubfollowers");
    task.setIdentifier("com.yourcompany.githubfollowers");
    task.setVersion("1.0");
    task.setAuthor("Your Company");
    task.setEmail("feedback @nospam@ yourcompany.com");
    task.setSummary("githubfollowers");
    task.setSources(new FileList("app/**/*.j", "AppController.j", "main.j"));
    task.setResources(new FileList("Resources/**/**"));
    task.setIndexFilePath("index.html");
    task.setInfoPlistPath("Info.plist");
    task.setNib2CibFlags("-R Resources/");

    if (configuration === "Debug")
        task.setCompilerFlags("-DDEBUG -g");
    else
        task.setCompilerFlags("-O");
});

task ("default", ["githubfollowers"], function()
{
    printResults(configuration);
});

task ("build", ["default"]);

task ("debug", function()
{
    ENV["CONFIGURATION"] = "Debug";
    JAKE.subjake(["."], "build", ENV);
});

task ("release", function()
{
    ENV["CONFIGURATION"] = "Release";
    JAKE.subjake(["."], "build", ENV);
});

task ("run", ["debug"], function()
{
    OS.system(["open", FILE.join("Build", "Debug", "githubfollowers", "index.html")]);
});

task ("run-release", ["release"], function()
{
    OS.system(["open", FILE.join("Build", "Release", "githubfollowers", "index.html")]);
});

task ("deploy", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Deployment", "githubfollowers"));
    OS.system(["press", "-f", FILE.join("Build", "Release", "githubfollowers"), FILE.join("Build", "Deployment", "githubfollowers")]);
    printResults("Deployment")
});

task ("press", ["release"], function()
{
  FILE.mkdirs(FILE.join("Build", "Press", "githubfollowers"));
  OS.system(["press", "-f", FILE.join("Build", "Release", "githubfollowers"), 
             FILE.join("Build", "Press", "githubfollowers")]);
});

task( "clean-all", function()
{
    OS.system(["rm", "-fr", "Build"]);
});

task ("flatten", ["press"], function()
{
  var xibsToConvert = obtainXibs();
  FILE.mkdirs(FILE.join("Build", "Flatten", "githubfollowers"));
  var args = ["flatten", "-f", "--verbose", "--split", "4", 
              "-c", "closure-compiler"];
  for ( var idx = 0; idx < xibsToConvert.length; idx++ ) {
    args.push("-P");
    args.push(FILE.join("Resources", xibsToConvert[idx] + ".cib"));
  }
  args.push(FILE.join("Build", "Press", "githubfollowers"));
  args.push(FILE.join("Build", "Flatten", "githubfollowers"));
  OS.system(args);
});

task ("desktop", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Desktop", "githubfollowers"));
    require("cappuccino/nativehost").buildNativeHost(FILE.join("Build", "Release", "githubfollowers"), FILE.join("Build", "Desktop", "githubfollowers", "githubfollowers.app"));
    printResults("Desktop")
});

task ("run-desktop", ["desktop"], function()
{
    OS.system([FILE.join("Build", "Desktop", "githubfollowers", "githubfollowers.app", "Contents", "MacOS", "NativeHost"), "-i"]);
});

function printResults(configuration)
{
    print("----------------------------");
    print(configuration+" app built at path: "+FILE.join("Build", configuration, "githubfollowers"));
    print("----------------------------");
}

function obtainXibs()
{
  var xibs = FILE.glob("Xibs/*.xib");
  for ( var idx = 0 ; idx < xibs.length; idx++ ) {
    xibs[idx] = xibs[idx].substring(0, xibs[idx].length - 4).substring(5);
  }
  return xibs;
}

task( "nibs", function()
{
  // Tried using JAKE.file but that didn't not want to work with subdirectories, 
  // i.e. Resources/
  var xibsToConvert = obtainXibs();
  for ( var idx = 0; idx < xibsToConvert.length; idx++ ) {
    var filenameXib = "Resources/../Xibs/" + xibsToConvert[idx] + ".xib";
    var filenameCib = "Resources/" + xibsToConvert[idx] + ".cib";
    if ( !FILE.exists(filenameCib) || FILE.mtime(filenameXib) > FILE.mtime(filenameCib) ) {
      print("Converting to cib: " + filenameXib);
      OS.system(["nib2cib", filenameXib, filenameCib]);
    } else {
      print("Ignoring " + filenameXib + " -> has been converted");
    }
  }
});
