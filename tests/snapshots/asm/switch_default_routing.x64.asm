
switch_default_routing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x63, %r11d
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	movslq	%r11d, %r11
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r8d
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movl	$0x14, %r8d
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movl	$0x64, %r8d
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	cmpq	$0x1, %r11
               	je	<addr>
               	cmpq	$0x2, %r11
               	je	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
