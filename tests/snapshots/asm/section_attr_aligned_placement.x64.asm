
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
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	%rcx, %rsi
               	andq	$0xfff, %rsi            # imm = 0xFFF
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rsi
               	andq	$0x1f, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rsi
               	andq	$0x7f, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movb	$0x1, (%rax)
               	leaq	0x1fff(%rax), %rsi
               	movb	$0x2, (%rsi)
               	movl	$0x15, (%rdx)
               	movb	$0x3, 0xfff(%rcx)
               	leaq	<rip>, %rcx
               	movb	$0x4, 0x9(%rcx)
               	movsbq	(%rax), %rax
               	movsbq	(%rsi), %rsi
               	addq	%rsi, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movslq	(%rdx), %rax
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rax
               	cmpl	$0x20, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
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
               	movsbq	0x9(%rcx), %rax
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
               	leaq	0x2000(%rax), %rcx
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	xorl	%eax, %eax
               	retq
