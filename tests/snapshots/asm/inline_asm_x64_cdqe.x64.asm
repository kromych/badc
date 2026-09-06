
inline_asm_x64_cdqe.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movabsq	$-0x5, %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	cltq
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rcx
               	movl	$0x2f, %eax
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	cltq
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rdx
               	cmpq	$-0x5, %rcx
               	jne	<addr>
               	cmpq	$0x2f, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
