
sroa_runtime_index_stays_memory.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movslq	%esi, %rsi
               	leaq	-0x40(%rbp), %rax
               	addq	$0x0, %rax
               	leaq	(%rdi), %rcx
               	movq	(%rcx), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	0x8(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	0x10(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	0x18(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	0x20(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	0x28(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	0x30(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x30(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	0x38(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	%rsi, %rcx
               	andq	$0x7, %rcx
               	movq	(%rax,%rcx,8), %rdx
               	leaq	-0x40(%rbp), %rax
               	leaq	0x5(%rsi), %rcx
               	movslq	%ecx, %rcx
               	andq	$0x7, %rcx
               	movq	(%rax,%rcx,8), %rax
               	addq	%rdx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	addq	$0x0, %rax
               	movq	%rcx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x2, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x5, %ecx
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x6, %ecx
               	movq	%rcx, 0x30(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x7, %ecx
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x40(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	cmpq	$0x1d, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
