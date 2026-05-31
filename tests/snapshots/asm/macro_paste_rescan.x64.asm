
macro_paste_rescan.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x3, %r11d
               	cmpq	$0x3, %r11
               	je	0x400250 <.text+0x30>
               	movl	$0xb, %eax
               	retq
               	movl	$0x3, %r11d
               	cmpq	$0x3, %r11
               	je	0x400269 <.text+0x49>
               	movl	$0xc, %eax
               	retq
               	movl	$0x32, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x32, %r11
               	je	0x400285 <.text+0x65>
               	movl	$0xd, %eax
               	retq
               	movl	$0x11, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x11, %r11
               	je	0x4002a1 <.text+0x81>
               	movl	$0xe, %eax
               	retq
               	movl	$0x3, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x3, %r11
               	je	0x4002bd <.text+0x9d>
               	movl	$0xf, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
