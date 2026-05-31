
macro_argument_rescan.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x7, %r11d
               	movslq	%r11d, %r11
               	cmpq	$0x7, %r11
               	je	0x400253 <.text+0x33>
               	movl	$0x1, %eax
               	retq
               	movl	$0x4, %r9d
               	movslq	%r9d, %r9
               	cmpq	$0x4, %r9
               	je	0x400273 <.text+0x53>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	retq
               	movl	$0x7b, %eax
               	movslq	%eax, %rax
               	cmpq	$0x7b, %rax
               	je	0x40028e <.text+0x6e>
               	movl	$0x3, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
               	addb	%al, (%rax)
