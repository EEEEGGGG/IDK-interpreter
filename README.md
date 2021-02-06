# IDK-interpreter
## Debugging
### Debug IDK programs 
#### Bash
```bash
./idk.sh -d 1 -f file.idk
```

```bash
./idk.sh --debug 1 --file file.idk
```
### Debug the Interpreter
```bash
./idk.sh -d 2 -f file.idk
```

```bash
./idk.sh --debug 2 --file file.idk
```
### Or both
```bash
./idk.sh -d 3 -f file.idk
```

```bash
./idk.sh --debug 3 --file file.idk
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
