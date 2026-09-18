
offsetof_multi_runtime_subscript.x64:	file format elf64-x86-64

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
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	imulq	$0x7, %rax, %rdx
               	leaq	(%rdx), %rsi
               	shlq	%rsi
               	leaq	0x2(%rsi), %rdi
               	imulq	$0xe, %rax, %rsi
               	leaq	(%rsi), %r8
               	addq	$0x2, %r8
               	cmpq	%rdi, %r8
               	jne	<addr>
               	leaq	0x1(%rdx), %rdi
               	shlq	%rdi
               	addq	$0x2, %rdi
               	leaq	0x2(%rsi), %r8
               	addq	$0x2, %r8
               	cmpq	%rdi, %r8
               	jne	<addr>
               	leaq	0x2(%rdx), %rdi
               	shlq	%rdi
               	addq	$0x2, %rdi
               	leaq	0x4(%rsi), %r8
               	addq	$0x2, %r8
               	cmpq	%rdi, %r8
               	jne	<addr>
               	leaq	0x3(%rdx), %rdi
               	shlq	%rdi
               	addq	$0x2, %rdi
               	addq	$0x6, %rsi
               	addq	$0x2, %rsi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	addq	$0x4, %rdx
               	shlq	%rdx
               	leaq	0x2(%rdx), %rsi
               	imulq	$0xe, %rax, %rdx
               	leaq	0x8(%rdx), %rdi
               	addq	$0x2, %rdi
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	imulq	$0x7, %rax, %rsi
               	leaq	0x5(%rsi), %rdi
               	shlq	%rdi
               	addq	$0x2, %rdi
               	leaq	0xa(%rdx), %r8
               	addq	$0x2, %r8
               	cmpq	%rdi, %r8
               	jne	<addr>
               	addq	$0x6, %rsi
               	shlq	%rsi
               	addq	$0x2, %rsi
               	leaq	0xc(%rdx), %rax
               	addq	$0x2, %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x5, %ecx
               	jl	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %rcx
               	leaq	(%rcx,%rcx,2), %rdi
               	movslq	%eax, %rdx
               	leaq	(%rdi,%rdx), %r8
               	movq	%r8, %r9
               	shlq	%r9
               	leaq	(%r9), %rbx
               	shlq	$0x2, %rbx
               	leaq	0x48(%rbx), %r12
               	imulq	$0x18, %rcx, %rbx
               	movq	%rdx, %r13
               	shlq	$0x3, %r13
               	addq	%rbx, %r13
               	addq	$0x0, %r13
               	addq	$0x48, %r13
               	cmpq	%r12, %r13
               	jne	<addr>
               	leaq	0x1(%r9), %rdi
               	shlq	$0x2, %rdi
               	addq	$0x48, %rdi
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rbx, %rcx
               	addq	$0x4, %rcx
               	addq	$0x48, %rcx
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x4, %esi
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	imulq	$0x18, %rcx, %rdx
               	leaq	(%rdx), %rsi
               	leaq	0x50(%rsi), %rdi
               	imulq	$0x6, %rcx, %rsi
               	leaq	(%rsi), %r8
               	shlq	$0x2, %r8
               	addq	$0x50, %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	addq	$0x4, %rdx
               	addq	$0x50, %rdx
               	leaq	0x1(%rsi), %rcx
               	shlq	$0x2, %rcx
               	addq	$0x50, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %rdi
               	imulq	$0x34, %rdi, %rcx
               	leaq	0xac(%rcx), %r8
               	movslq	%eax, %rdx
               	leaq	(%rdx,%rdx,2), %r9
               	leaq	(%r9), %rbx
               	shlq	$0x2, %rbx
               	leaq	(%r8,%rbx), %r12
               	imulq	$0xc, %rdx, %rbx
               	leaq	(%rcx,%rbx), %r13
               	addq	$0x0, %r13
               	addq	$0xac, %r13
               	cmpq	%r12, %r13
               	jne	<addr>
               	incq	%r9
               	shlq	$0x2, %r9
               	addq	%r9, %r8
               	addq	%rbx, %rcx
               	addq	$0x4, %rcx
               	addq	$0xac, %rcx
               	cmpq	%r8, %rcx
               	jne	<addr>
               	imulq	$0x34, %rdi, %rcx
               	leaq	0xac(%rcx), %rdi
               	leaq	(%rdx,%rdx,2), %r8
               	addq	$0x2, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdi
               	imulq	$0xc, %rdx, %rdx
               	addq	%rdx, %rcx
               	addq	$0x8, %rcx
               	addq	$0xac, %rcx
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x3, %esi
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
