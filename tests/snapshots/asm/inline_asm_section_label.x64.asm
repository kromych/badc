
inline_asm_section_label.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rcx
               	cmpq	$0x74, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	0x1(%rax), %rcx
               	cmpq	$0x61, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0x2(%rax), %rcx
               	cmpq	$0x67, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsbq	0x3(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x63, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	0x8(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>
