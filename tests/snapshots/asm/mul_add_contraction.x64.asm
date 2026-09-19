
mul_add_contraction.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax
               	imulq	$0x18, %rcx, %r8
               	leaq	(%rax,%r8), %rdx
               	movslq	(%rdx), %rsi
               	movslq	0x4(%rdx), %rdi
               	movslq	0x8(%rdx), %rax
               	movq	%rsi, %r9
               	imulq	%rdi, %r9
               	leaq	(%rax,%r9), %rbx
               	movslq	0xc(%rdx), %rdx
               	cmpl	%edx, %ebx
               	jne	<addr>
               	leaq	(%r9,%rax), %rdx
               	leaq	<rip>, %r9
               	addq	%r9, %r8
               	movslq	0xc(%r8), %r8
               	cmpl	%r8d, %edx
               	jne	<addr>
               	movq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	leaq	<rip>, %rbx
               	imulq	$0x18, %rcx, %r8
               	addq	%r8, %rbx
               	movslq	0x10(%rbx), %rbx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movq	%rdx, %r9
               	subq	%rax, %r9
               	leaq	<rip>, %rbx
               	addq	%r8, %rbx
               	movslq	0x14(%rbx), %rbx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movq	%rax, %r9
               	subq	%rdx, %r9
               	xorq	%r9, %rdx
               	movslq	%edx, %r9
               	leaq	<rip>, %rdx
               	addq	%r8, %rdx
               	movslq	0x10(%rdx), %r8
               	movq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	movslq	%edx, %rsi
               	xorq	%r8, %rsi
               	cmpq	%rsi, %r9
               	jne	<addr>
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	leaq	<rip>, %rdx
               	imulq	$0x18, %rcx, %rdi
               	addq	%rdi, %rdx
               	movslq	0x10(%rdx), %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	cmpl	%eax, %eax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x7, %ecx
               	jb	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movslq	(%rdx,%rax,4), %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$0x33, %ecx
               	je	<addr>
               	movl	$0x46, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movslq	(%rdx,%rax,4), %rsi
               	imulq	$-0x1, %rsi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpl	$-0x11, %ecx
               	je	<addr>
               	movl	$0x48, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movslq	(%rdx,%rax,4), %rsi
               	imulq	$0x7, %rsi, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x49, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
