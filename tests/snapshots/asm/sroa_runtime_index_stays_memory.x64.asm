
sroa_runtime_index_stays_memory.x64:	file format elf64-x86-64

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

<pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movslq	%esi, %rsi
               	leaq	-0x40(%rbp), %rax
               	leaq	(%rax), %rcx
               	leaq	(%rdi), %rdx
               	movq	(%rdx), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	incq	%rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x20(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x40(%rbp), %rax
               	movq	0x28(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x28(%rax)
               	movq	0x30(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x30(%rax)
               	movq	0x38(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x38(%rax)
               	movq	%rsi, %rcx
               	andq	$0x7, %rcx
               	movq	(%rax,%rcx,8), %rdx
               	leaq	0x5(%rsi), %rcx
               	movslq	%ecx, %rcx
               	andq	$0x7, %rcx
               	movq	(%rax,%rcx,8), %rax
               	addq	%rdx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	leaq	(%rax), %rdx
               	movq	%rcx, (%rdx)
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x2, %ecx
               	movq	%rcx, 0x10(%rax)
               	movl	$0x3, %ecx
               	movq	%rcx, 0x18(%rax)
               	movl	$0x4, %ecx
               	movq	%rcx, 0x20(%rax)
               	movl	$0x5, %ecx
               	movq	%rcx, 0x28(%rax)
               	movl	$0x6, %ecx
               	movq	%rcx, 0x30(%rax)
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x7, %eax
               	movq	%rax, 0x38(%rdi)
               	movl	$0xa, %esi
               	callq	<addr>
               	cmpq	$0x1d, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
