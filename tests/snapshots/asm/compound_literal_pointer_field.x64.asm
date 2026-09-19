
compound_literal_pointer_field.x64:	file format elf64-x86-64

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
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	0x18(%rax), %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	0x20(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x28(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
