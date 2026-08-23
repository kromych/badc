
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

<work>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	xorq	%rcx, %rcx
               	movl	$0x3, %edx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rcx, %rdi
               	jmp	<addr>
               	leaq	<rip>, %r8
               	movq	(%r8), %r9
               	addq	%rax, %r9
               	movq	%r9, (%r8)
               	incq	%rdi
               	cmpl	$0x2, %esi
               	jb	<addr>
               	cmpl	$0x3, %esi
               	jb	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	%rcx, %rdx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movl	$0x1, %edx
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movl	%edx, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	$0x1, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
