
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
               	xorl	%edx, %edx
               	movl	$0x3, %ecx
               	leaq	<rip>, %r8
               	movq	(%r8), %rax
               	leaq	<rip>, %rdi
               	movq	%rdx, %rsi
               	movq	(%rdi), %r9
               	addq	%rax, %r9
               	movq	%r9, (%rdi)
               	incq	%rsi
               	cmpl	$0x2, %ecx
               	jb	<addr>
               	cmpl	$0x3, %ecx
               	jb	<addr>
               	movq	(%r8), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
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
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
