
designator_range_in_chain.x64:	file format elf64-x86-64

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
               	addq	$0x8, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movq	0x10(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movq	0x18(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	leaq	0x4(%rdx), %rdi
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movslq	(%rdi), %rdi
               	cmpl	$0x7, %edi
               	jne	<addr>
               	leaq	0x4(%rdx), %rdi
               	addq	%rdi, %rsi
               	movslq	0x4(%rsi), %rsi
               	cmpl	$0x8, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x9, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x3, %eax
               	retq
