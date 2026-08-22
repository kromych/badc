
section_attr_aligned_placement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<page_buf_end>:
               	leaq	<rip>, %rax
               	addq	$0x2000, %rax           # imm = 0x2000
               	retq

<main>:
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x1f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x7f, %rcx
               	testl	%ecx, %ecx
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
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x20, %ecx
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
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsbq	0x9(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	0x2000(%rax), %rcx
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	xorq	%rax, %rax
               	retq
