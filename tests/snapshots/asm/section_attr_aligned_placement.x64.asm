
section_attr_aligned_placement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<page_buf_end>:
               	leaq	<rip>, %rax
               	addq	$0x2000, %rax           # imm = 0x2000
               	retq

<main>:
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x7f, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	leaq	0x1fff(%rax), %rcx
               	movl	$0x2, %edx
               	movb	%dl, (%rcx)
               	leaq	<rip>, %rdx
               	movl	$0x15, %esi
               	movl	%esi, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x3, %esi
               	movb	%sil, 0xfff(%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x4, %esi
               	movb	%sil, 0x9(%rdx)
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x20, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	addq	%rdx, %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsbq	0xfff(%rcx), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsbq	0x9(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xb, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	0x2000(%rax), %rcx
               	addq	$0x2000, %rax           # imm = 0x2000
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	xorq	%rax, %rax
               	retq
