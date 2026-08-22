
unroll_const_trip_copy.x64:	file format elf64-x86-64

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
               	leaq	(%rax), %rcx
               	movl	$0x1, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x4, %edx
               	movq	%rdx, 0x8(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x7, %edx
               	movq	%rdx, 0x10(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0xa, %edx
               	movq	%rdx, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0xd, %edx
               	movq	%rdx, 0x20(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x10, %edx
               	movq	%rdx, 0x28(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x13, %edx
               	movq	%rdx, 0x30(%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x16, %edx
               	movq	%rdx, 0x38(%rcx)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	movq	0x20(%rdx), %rax
               	movq	%rax, 0x20(%rcx)
               	movq	0x28(%rdx), %rax
               	movq	%rax, 0x28(%rcx)
               	movq	0x30(%rdx), %rax
               	movq	%rax, 0x30(%rcx)
               	movq	0x38(%rdx), %rax
               	movq	%rax, 0x38(%rcx)
               	popq	%rax
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	shlq	$0x0, %rcx
               	leaq	(%rcx), %rdx
               	leaq	<rip>, %rcx
               	movq	0x10(%rcx), %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	0x18(%rcx), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	0x20(%rcx), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	0x28(%rcx), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	0x30(%rcx), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	0x38(%rcx), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	addq	$0x0, %rdx
               	movq	(%rdx), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	$0x1c8, %rcx            # imm = 0x1C8
               	je	<addr>
               	retq
               	xorq	%rax, %rax
               	retq
