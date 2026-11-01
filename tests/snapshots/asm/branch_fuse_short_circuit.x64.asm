
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
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rdx), %rdi
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %r8
               	leaq	<rip>, %rsi # <addr>
               	movl	(%rsi), %r9d
               	cmpq	$-0x1, %rdi
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%r8, %r8
               	jne	<addr>
               	testl	%r9d, %r9d
               	jne	<addr>
               	movq	(%rdx), %rax
               	movq	(%rcx), %rdx
               	movl	(%rsi), %edx
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	movq	(%rcx), %rax
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rdx
               	movl	(%rax), %eax
               	cmpq	$0x64, %rdx
               	jbe	<addr>
               	movq	(%rcx), %rax
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x4, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
