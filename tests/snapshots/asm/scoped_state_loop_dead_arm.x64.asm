
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rsi, %rsi
               	movl	$0x3, %eax
               	leaq	<rip>, %r9
               	movq	(%r9), %rcx
               	leaq	<rip>, %r8
               	movq	%rsi, %rdi
               	jmp	<addr>
               	movq	(%r8), %rbx
               	addq	%rcx, %rbx
               	movq	%rbx, (%r8)
               	incq	%rdi
               	cmpl	$0x2, %edx
               	jb	<addr>
               	cmpl	$0x3, %edx
               	jb	<addr>
               	movq	(%r9), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	$0x1, %eax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movq	%rsi, %rax
               	movq	%rsi, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movl	%eax, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	(%rsp), %rbx
               	movq	%rdi, %rax
               	leave
               	retq

<work>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
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
