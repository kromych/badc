
compound_literal_alignment.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x6, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
