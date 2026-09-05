
ptr_diff_plus_ptr.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
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
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	0x20(%rax), %rdx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3c, %rdi
               	leaq	(%rcx,%rdi), %r8
               	sarq	$0x4, %r8
               	shlq	$0x4, %r8
               	addq	%rax, %r8
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	addq	%rdi, %rcx
               	sarq	$0x4, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x10(%rax), %rdx
               	addq	%rcx, %rdx
               	leaq	-0x30(%rbp), %rcx
               	leaq	0x30(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	addq	$0x20, %rax
               	addq	$0x20, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
