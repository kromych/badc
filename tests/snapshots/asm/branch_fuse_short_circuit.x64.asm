
branch_fuse_short_circuit.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r8
               	leaq	<rip>, %rdi
               	movl	(%rdi), %r9d
               	cmpq	$-0x1, %rdx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%r8, %r8
               	jne	<addr>
               	testl	%r9d, %r9d
               	jne	<addr>
               	movq	(%rcx), %rax
               	movq	(%rsi), %rcx
               	movl	(%rdi), %ecx
               	cmpq	$-0x1, %rax
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rcx
               	movl	(%rcx), %edx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movl	(%rcx), %ecx
               	cmpq	$-0x1, %rsi
               	cmpq	$0x64, %rsi
               	jbe	<addr>
               	movq	(%rdx), %rcx
               	movq	(%rax), %rax
               	cmpq	$-0x1, %rcx
               	jne	<addr>
               	cmpq	$0x64, %rcx
               	jbe	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	$0x64, %rdx
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
