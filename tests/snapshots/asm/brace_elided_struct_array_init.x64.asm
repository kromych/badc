
brace_elided_struct_array_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	0x8(%rax), %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x18(%rax), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x20(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	0x28(%rax), %rcx
               	cmpq	$0x2, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x40(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movslq	0x48(%rax), %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x50(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	0x68(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x70(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
