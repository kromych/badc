
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
               	movl	$0x3, %r9d
               	cmpq	$0x3, %r9
               	je	0x40026d <.text+0x4d>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	retq
               	movl	$0x32, %eax
               	movslq	%eax, %rax
               	cmpq	$0x32, %rax
               	je	0x400288 <.text+0x68>
               	movl	$0xd, %eax
               	retq
               	movl	$0x11, %r9d
               	movslq	%r9d, %r9
               	cmpq	$0x11, %r9
               	je	0x4002a8 <.text+0x88>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	retq
               	movl	$0x3, %eax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	0x4002c3 <.text+0xa3>
               	movl	$0xf, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
               	addb	%al, 0x41(%rdx)
