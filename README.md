# IDK-interpreter
## Debugging
### Debug IDK programs 
#### Bash
```bash
./idk.sh -d 1 file.idk
```

```bash
./idk.sh --debug 1 file.idk
```
### Debug the Interpreter
```bash
./idk.sh -d 2 file.idk
```

```bash
./idk.sh --debug 2 file.idk
```
### Or both
```bash
./idk.sh -d 3 file.idk
```

```bash
./idk.sh --debug 3 file.idk
```
## Usage
### stdin
```bash
./idk.sh -s
```
### file
```bash
./idk.sh -f file.idk
```

or

```bash
./idk.sh -f file.idk -f file1.idk -f file2.idk -f file3.idk ........
```
