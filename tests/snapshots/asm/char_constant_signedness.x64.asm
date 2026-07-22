
char_constant_signedness.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	movabsq	$-0x80, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	jl	<addr>
               	cmpq	$0x28, %rax
               	jl	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movabsq	$-0x1, %rcx
               	movb	%cl, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	jl	<addr>
               	cmpq	$0x28, %rax
               	jl	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	cmpq	$-0x80, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	cmpq	$-0x80, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
