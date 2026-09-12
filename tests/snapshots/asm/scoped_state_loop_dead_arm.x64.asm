
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
               	xorq	%rdi, %rdi
               	movl	$0x3, %ecx
               	leaq	<rip>, %r9
               	movq	(%r9), %rax
               	leaq	<rip>, %r8
               	movq	%rdi, %rsi
               	jmp	<addr>
               	movq	(%r8), %rbx
               	addq	%rax, %rbx
               	movq	%rbx, (%r8)
               	incq	%rsi
               	cmpl	$0x2, %edx
               	jb	<addr>
               	cmpl	$0x3, %edx
               	jb	<addr>
               	movq	(%r9), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rdi, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movl	%ecx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	(%rsp), %rbx
               	movq	%rsi, %rax
               	leave
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
