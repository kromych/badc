
extern_incomplete_struct_completion.x64:	file format elf64-x86-64

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
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpq	$0x4, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0xb, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
