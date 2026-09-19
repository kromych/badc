
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
               	pushq	%r12
               	pushq	%rbx
               	xorl	%esi, %esi
               	leaq	<rip>, %rdi
               	cmpl	$0x7, %esi
               	jae	<addr>
               	imulq	$0x18, %rsi, %rbx
               	leaq	(%rdi,%rbx), %r8
               	movslq	(%r8), %rcx
               	movslq	0x4(%r8), %rdx
               	movslq	0x8(%r8), %rax
               	movq	%rcx, %r9
               	imulq	%rdx, %r9
               	leaq	(%rax,%r9), %r12
               	movslq	0xc(%r8), %r8
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	leaq	(%r9,%rax), %r8
               	leaq	(%rdi,%rbx), %r9
               	movslq	0xc(%r9), %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	movq	%rcx, %r8
               	imulq	%rdx, %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	imulq	$0x18, %rsi, %rbx
               	leaq	(%rdi,%rbx), %r12
               	movslq	0x10(%r12), %r12
               	cmpl	%r12d, %r9d
               	jne	<addr>
               	movq	%r8, %r9
               	subq	%rax, %r9
               	leaq	(%rdi,%rbx), %r12
               	movslq	0x14(%r12), %r12
               	cmpl	%r12d, %r9d
               	jne	<addr>
               	movq	%rax, %r9
               	subq	%r8, %r9
               	xorq	%r9, %r8
               	movslq	%r8d, %r9
               	leaq	(%rdi,%rbx), %r8
               	movslq	0x10(%r8), %rbx
               	movq	%rcx, %r8
               	imulq	%rdx, %r8
               	movslq	%r8d, %r12
               	xorq	%r12, %rbx
               	cmpq	%rbx, %r9
               	jne	<addr>
               	movq	%rax, %r9
               	subq	%r8, %r9
               	imulq	$0x18, %rsi, %r8
               	addq	%rdi, %r8
               	movslq	0x10(%r8), %r8
               	cmpl	%r8d, %r9d
               	jne	<addr>
               	cmpl	%eax, %eax
               	jne	<addr>
               	incq	%rsi
               	cmpl	$0x7, %esi
               	jb	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x5, %eax
               	jge	<addr>
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
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x5, %eax
               	jge	<addr>
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
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x3, %eax
               	jge	<addr>
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
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
