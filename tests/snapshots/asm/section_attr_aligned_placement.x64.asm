
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
               	testl	$0xfff, %eax            # imm = 0xFFF
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	testb	$0x3f, %cl
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	testb	$0x3f, %dl
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rdx
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rdx
               	testl	$0xfff, %edx            # imm = 0xFFF
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rsi
               	testb	$0x1f, %sil
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rsi
               	testb	$0x7f, %sil
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movb	$0x1, (%rax)
               	leaq	0x1fff(%rax), %rsi
               	movb	$0x2, (%rsi)
               	movl	$0x15, (%rcx)
               	movb	$0x3, 0xfff(%rdx)
               	leaq	<rip>, %rdx
               	movb	$0x4, 0x9(%rdx)
               	movsbq	(%rax), %rax
               	movsbq	(%rsi), %rsi
               	addq	%rsi, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movslq	(%rcx), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x20, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	0xfff(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movsbq	0x9(%rdx), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x2000, %rax           # imm = 0x2000
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	xorl	%eax, %eax
               	retq
