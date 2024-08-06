run: hello.exe
	.\hello.exe
	
hello.exe: hello.o
	ld -m i386pe hello.o -o hello.exe -L"C:\Windows\SysWOW64" -luser32 -lkernel32

hello.o: hello.s
	as --32 .\hello.s -o hello.o


run64: hello64.exe
	.\hello64.exe

hello64.exe: hello64.o
	ld --image-base 0x10000000 hello64.o -o hello64.exe -luser32 -lkernel32

hello64.o: hello64.s
	as --64 .\hello64.s -o hello64.o
