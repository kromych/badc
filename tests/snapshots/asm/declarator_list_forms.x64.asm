
declarator_list_forms.x64:	file format elf64-x86-64

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

<add>:
               	leaq	(%rdi,%rsi), %rax
               	retq

<sub>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, <rip> # <addr>
               	movl	%ecx, <rip> # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x4, %edx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movl	(%rdx), %edx
               	cmpl	$0x2, %edx
               	je	<addr>
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %edx # <addr>
               	addq	%rdx, %rax
               	movl	<rip>, %edx # <addr>
               	addq	%rdx, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	addq	%rax, %rax
               	incq	%rax
               	addq	$0x2, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x3, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
