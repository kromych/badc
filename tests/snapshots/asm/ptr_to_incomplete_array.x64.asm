
ptr_to_incomplete_array.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %r9
               	leaq	<rip>, %rdx
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	shlq	$0x4, %rax
               	addq	%r9, %rax
               	movq	0x8(%rax), %rax
               	movq	%rdx, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rsi
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	incq	%r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	movq	$-0x1, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	xorl	%r8d, %r8d
               	movq	%r8, %rax
               	shlq	$0x4, %rax
               	addq	%r9, %rax
               	movq	0x8(%rax), %rax
               	movq	%rdx, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rsi
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	incq	%r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	movq	$-0x1, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movq	%r8, %rax
               	shlq	$0x4, %rax
               	addq	%r9, %rax
               	movslq	(%rax), %rax
               	jmp	<addr>
               	movq	%r8, %rax
               	shlq	$0x4, %rax
               	addq	%r9, %rax
               	movslq	(%rax), %rax
               	jmp	<addr>
