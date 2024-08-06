run: hello.exe
	.\hello.exe
	
hello.exe: hello.o
	ld -m i386pe hello.o -o hello.exe -L"C:\Windows\SysWOW64" -luser32 -lkernel32

hello.o: hello.s
	as --32 .\hello.s -o hello.o
