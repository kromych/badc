
pointers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x64, %r11d
               	movl	%r11d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movl	$0xc8, %r11d
               	movl	%r11d, (%r9)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
