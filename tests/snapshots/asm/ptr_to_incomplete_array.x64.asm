
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %r9
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rdx
               	xorl	%r8d, %r8d
               	cmpl	$0x2, %r8d
               	jge	<addr>
               	movslq	%r8d, %r12
               	movq	%r12, %rax
               	shlq	$0x4, %rax
               	addq	%rbx, %rax
               	movq	0x8(%rax), %rax
               	movq	%rdx, %rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rax), %rsi
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	incq	%r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	movq	$-0x1, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	xorl	%r8d, %r8d
               	cmpl	$0x2, %r8d
               	jge	<addr>
               	movslq	%r8d, %rbx
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	addq	%r9, %rax
               	movq	0x8(%rax), %rax
               	movq	%rdx, %rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rax), %rsi
               	movsbq	(%rcx), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	incq	%r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	movq	$-0x1, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	addq	%r9, %rax
               	movslq	(%rax), %rax
               	jmp	<addr>
               	movq	%r12, %rax
               	shlq	$0x4, %rax
               	addq	%rbx, %rax
               	movslq	(%rax), %rax
               	jmp	<addr>
