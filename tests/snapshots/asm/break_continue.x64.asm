
break_continue.x64:	file format elf64-x86-64

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
               	xorq	%r11, %r11
               	movl	%r11d, -0x10(%rbp)
               	movl	%r11d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0xa, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0x5, %r11
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r8
               	movl	$0x2, %r11d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r11
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x0, %r8
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r11
               	movslq	-0x8(%rbp), %r8
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x10(%rbp)
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
