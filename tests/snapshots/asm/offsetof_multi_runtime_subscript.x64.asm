
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	imulq	$0x7, %rax, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	0x2(%rdx), %rdi
               	imulq	$0xe, %rax, %rdx
               	leaq	0x2(%rdx), %rsi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rdi
               	shlq	%rdi
               	addq	$0x2, %rdi
               	addq	$0x2, %rsi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x2(%rcx), %rsi
               	shlq	%rsi
               	addq	$0x2, %rsi
               	leaq	0x4(%rdx), %rdi
               	addq	$0x2, %rdi
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	leaq	0x3(%rcx), %rsi
               	shlq	%rsi
               	addq	$0x2, %rsi
               	addq	$0x6, %rdx
               	addq	$0x2, %rdx
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	addq	$0x4, %rcx
               	shlq	%rcx
               	leaq	0x2(%rcx), %rdx
               	imulq	$0xe, %rax, %rcx
               	leaq	0x8(%rcx), %rsi
               	addq	$0x2, %rsi
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	imulq	$0x7, %rax, %rdx
               	leaq	0x5(%rdx), %rsi
               	shlq	%rsi
               	addq	$0x2, %rsi
               	leaq	0xa(%rcx), %rdi
               	addq	$0x2, %rdi
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	addq	$0x6, %rdx
               	shlq	%rdx
               	addq	$0x2, %rdx
               	addq	$0xc, %rcx
               	addq	$0x2, %rcx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	leaq	(%rcx,%rcx,2), %rdx
               	addq	%rax, %rdx
               	shlq	%rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	leaq	0x48(%rsi), %rdi
               	imulq	$0x18, %rcx, %rsi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	leaq	0x48(%rsi), %r8
               	cmpq	%rdi, %r8
               	jne	<addr>
               	incq	%rdx
               	shlq	$0x2, %rdx
               	addq	$0x48, %rdx
               	addq	$0x4, %rsi
               	addq	$0x48, %rsi
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	imulq	$0x18, %rax, %rcx
               	leaq	0x50(%rcx), %rsi
               	imulq	$0x6, %rax, %rdx
               	movq	%rdx, %rdi
               	shlq	$0x2, %rdi
               	addq	$0x50, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	addq	$0x4, %rcx
               	addq	$0x50, %rcx
               	incq	%rdx
               	shlq	$0x2, %rdx
               	addq	$0x50, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	imulq	$0x34, %r8, %rcx
               	leaq	0xac(%rcx), %rdx
               	leaq	(%rax,%rax,2), %rsi
               	movq	%rsi, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%rdx,%rdi), %r9
               	imulq	$0xc, %rax, %rdi
               	addq	%rcx, %rdi
               	leaq	0xac(%rdi), %rbx
               	cmpq	%r9, %rbx
               	jne	<addr>
               	incq	%rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	leaq	0x4(%rdi), %rsi
               	addq	$0xac, %rsi
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0xac(%rcx), %rdx
               	leaq	(%rax,%rax,2), %rsi
               	addq	$0x2, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	imulq	$0xc, %rax, %rsi
               	addq	%rsi, %rcx
               	addq	$0x8, %rcx
               	addq	$0xac, %rcx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
