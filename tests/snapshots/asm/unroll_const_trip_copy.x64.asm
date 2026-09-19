
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
               	movq	$0x1, (%rax)
               	movq	$0x4, 0x8(%rax)
               	movq	$0x7, 0x10(%rax)
               	movq	$0xa, 0x18(%rax)
               	movq	$0xd, 0x20(%rax)
               	movq	$0x10, 0x28(%rax)
               	movq	$0x13, 0x30(%rax)
               	leaq	<rip>, %rcx
               	movq	$0x16, 0x38(%rcx)
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	popq	%rdx
               	movq	0x8(%rax), %rcx
               	movq	0x10(%rax), %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	0x18(%rax), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	movq	0x20(%rax), %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movq	0x28(%rax), %rax
               	leaq	(%rax,%rax,4), %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	0x30(%rax), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x38(%rax), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	(%rax), %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	cmpq	$0x1c8, %rax            # imm = 0x1C8
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq
