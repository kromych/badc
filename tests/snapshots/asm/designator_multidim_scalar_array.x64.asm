
designator_multidim_scalar_array.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	leaq	0x20(%rdx), %rcx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	movslq	(%rcx), %rsi
               	cmpl	$0x9, %esi
               	jne	<addr>
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rdx, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rcx)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq
