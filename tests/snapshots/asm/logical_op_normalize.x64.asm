
logical_op_normalize.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	xorq	%rcx, %rcx
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rdx,%rcx,4), %rcx
               	cmpq	$0x14, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rcx
               	xorq	%rdx, %rdx
               	addq	$0x0, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
