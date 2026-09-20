
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
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	$0x5a5a5a5a, %rcx       # imm = 0x5A5A5A5A
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	addq	$0x10, %rax
               	movq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	cmpq	$0xb, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	$0xc, %rcx
               	jne	<addr>
               	movq	0x18(%rax), %rcx
               	cmpq	$0xd, %rcx
               	jne	<addr>
               	movq	0x20(%rax), %rax
               	cmpq	$0xe, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movq	0x28(%rax), %rcx
               	cmpq	$0xf, %rcx
               	jne	<addr>
               	movq	0x30(%rax), %rcx
               	cmpq	$0x10, %rcx
               	jne	<addr>
               	movq	0x38(%rax), %rcx
               	cmpq	$0x11, %rcx
               	jne	<addr>
               	movq	0x40(%rax), %rcx
               	cmpq	$0x12, %rcx
               	jne	<addr>
               	movq	0x48(%rax), %rax
               	cmpq	$0x13, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rcx
               	movq	0x50(%rcx), %rcx
               	cmpq	$0x14, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
