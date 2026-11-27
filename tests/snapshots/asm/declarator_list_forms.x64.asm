
declarator_list_forms.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	%rsi, %rdi
               	movq	%rdi, %rax
               	retq

<main>:
               	movl	$0x2, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	movl	<rip>, %edx # <addr>
               	addq	%rdx, %rcx
               	movl	<rip>, %edx # <addr>
               	addq	%rdx, %rcx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
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
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x3, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
