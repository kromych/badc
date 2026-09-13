
brace_elided_toplevel_struct_array.x64:	file format elf64-x86-64

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
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x14(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x10(%rcx), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0x18, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	%rax, %rcx
               	retq
