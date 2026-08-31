
flexible_array_member_after_tentative_decl.x64:	file format elf64-x86-64

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

<early_ref>:
               	leaq	<rip>, %rax
               	retq

<main>:
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x5a5a5a5a, %rax       # imm = 0x5A5A5A5A
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	0x10(%rcx), %rax
               	leaq	(%rax), %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0xa, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x8(%rax), %rdx
               	cmpq	$0xb, %rdx
               	jne	<addr>
               	movq	0x10(%rax), %rdx
               	cmpq	$0xc, %rdx
               	jne	<addr>
               	movq	0x18(%rax), %rdx
               	cmpq	$0xd, %rdx
               	jne	<addr>
               	movq	0x20(%rax), %rdx
               	cmpq	$0xe, %rdx
               	jne	<addr>
               	movq	0x28(%rax), %rdx
               	cmpq	$0xf, %rdx
               	jne	<addr>
               	movq	0x30(%rax), %rdx
               	cmpq	$0x10, %rdx
               	jne	<addr>
               	movq	0x38(%rax), %rdx
               	cmpq	$0x11, %rdx
               	jne	<addr>
               	movq	0x40(%rax), %rax
               	cmpq	$0x12, %rax
               	jne	<addr>
               	leaq	0x10(%rcx), %rax
               	movq	0x48(%rax), %rdx
               	cmpq	$0x13, %rdx
               	jne	<addr>
               	movq	0x50(%rax), %rax
               	cmpq	$0x14, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
