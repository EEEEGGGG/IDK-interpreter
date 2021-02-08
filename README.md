# IDK-interpreter
## Usage
| Short Option | Long Option |       Description      |                                                     Notes                                                    |
|:------------:|:-----------:|:----------------------:|:------------------------------------------------------------------------------------------------------------:|
|     `-h`     |    --help   |     Show help page     |                         Running help page first before other options will cancel it.                         |
|     `-s`     |   --stdin   | Run program from stdin |                                    You can set this option multiple times                                    |
|     `-f`     |    --file   |  Run program from file |                                    You can set this option multiple times                                    |
|     `-d`     |   --debug   |   Debug file or stdin  | Debug on a file or stdin. Running this option without any level will set the defualt to 1. Debugging levels: <table><thead><tr><th>Debug Level</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td>Enables debugging, outputs tokens, BOF, EOF, stack.</td></tr><tr><td>2</td><td>sets <code>set -xv</code> in bash</td></tr><tr><td>3</td><td>Both 1 and 2</td></tr></tbody></table>                                                                                  |
