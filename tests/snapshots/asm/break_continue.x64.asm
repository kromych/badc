
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
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rdx
               	addq	$0x1, %rdx
               	movl	%edx, (%rax)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	movl	$0x2, %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	addb	%al, (%rax)
