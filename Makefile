LDFLAGS_32 ?= -L"C:\Windows\SysWOW64"
LDFLAGS_64 ?= 

run: hello.exe
	.\hello.exe

hello.exe: hello.o
	$(LD) -m i386pe hello.o -o hello.exe $(LDFLAGS_32) -luser32 -lkernel32

hello.o: hello.s
	$(AS) --32 hello.s -o hello.o


run64: hello64.exe
	.\hello64.exe

hello64.exe: hello64.o
	$(LD) --image-base 0x10000000 hello64.o -o hello64.exe $(LDFLAGS_64) -luser32 -lkernel32

hello64.o: hello64.s
	$(AS) --64 hello64.s -o hello64.o
