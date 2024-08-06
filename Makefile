run: link
	.\hello.exe
	
link: assemble
	ld -m i386pe hello.o -o hello.exe -L"C:\Windows\SysWOW64" -luser32 -lkernel32

assemble:
	as --32 .\hello.s -o hello.o
