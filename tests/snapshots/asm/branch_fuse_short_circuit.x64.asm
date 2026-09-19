
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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rsi
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	cmpq	$-0x1, %rdx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	cmpq	$-0x1, %rcx
               	cmpq	$0x64, %rcx
               	jbe	<addr>
               	movl	$0x2, %ecx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rcx
               	movl	(%rcx), %ecx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	cmpq	$-0x1, %rcx
               	jne	<addr>
               	cmpq	$0x64, %rcx
               	jbe	<addr>
               	movl	$0x2, %ecx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$-0x1, %rcx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x64, %rcx
               	jbe	<addr>
               	movl	$0x2, %eax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpq	$0x64, %rdx
               	jbe	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
