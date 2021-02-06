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
#### Bash
```bash
./idk.sh -d 2 -f file.idk
```

```bash
./idk.sh --debug 2 --file file.idk
```
### Or both
#### Bash
```bash
./idk.sh -d 3 -f file.idk
```

```bash
./idk.sh --debug 3 --file file.idk
```
## Usage
### stdin
#### Bash
```bash
./idk.sh -s
```
### file
#### Bash
```bash
./idk.sh -f file.idk
```

or

#### Bash
```bash
./idk.sh -f file.idk -f file1.idk -f file2.idk -f file3.idk ........
```
