# win32-asm-example

this is an example assembly project utilizing Windows API written in GNU AT&T syntax and inteded to be built with GNU binutils.

the project contains two assembly files, `hello.s` for the 32-bit example and `hello64.s` for the 64-bit example.

## building

### prequisites
- MinGW
- Microsoft Windows or Wine

```
make hello.exe
```

```
make hello64.exe
```

## running
```
./hello.exe
```

```
./hello64.exe
```
