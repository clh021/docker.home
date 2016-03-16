var childProcess;
try {
    childProcess = require("child_process");
} catch (e) {
    this.log(e, "error");
}
if (childProcess) {
    childProcess.execFile("/bin/bash", ["mycommand.sh", args1, args2, args3], null, function (err, stdout, stderr) {
        this.log("execFileSTDOUT:", JSON.stringify(stdout), 'debug');
        this.log("execFileSTDERR:", JSON.stringify(stderr), 'debug');
    });
    this.log("Done", "debug");
} else {
    this.log("Unable to require child process", "warning");
}