
scoped_state_loop_dead_arm.x64:	file format elf64-x86-64

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

<reader>:
               	xorq	%rdx, %rdx
               	movl	$0x3, %eax
               	leaq	<rip>, %r8
               	movq	(%r8), %rcx
               	leaq	<rip>, %rdi
               	movq	%rdx, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rdi), %r9
               	addq	%rcx, %r9
               	movq	%r9, (%rdi)
               	incq	%rsi
               	cmpl	$0x2, %eax
               	jb	<addr>
               	cmpl	$0x3, %eax
               	jb	<addr>
               	movq	(%r8), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rdx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %rax
               	retq

<work>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
