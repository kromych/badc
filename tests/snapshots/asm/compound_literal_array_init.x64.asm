
compound_literal_array_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movzbq	0x1(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	cmpl	$0x18, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x5(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x1(%rax), %rcx
               	movzbq	0x5(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x12, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
