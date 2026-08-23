
deferred_jit_thread_local.x64:	file format elf64-x86-64

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
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rax
               	leaq	(%rax), %rcx
               	movl	%edx, (%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movslq	(%rax), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movslq	(%rcx), %rax
               	movq	%fs:0x0, %rsi
               	addq	$-0x8, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	popq	%rbp
               	retq
