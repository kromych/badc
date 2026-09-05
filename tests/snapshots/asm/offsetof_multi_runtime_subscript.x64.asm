
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
               	addq	$0xc, %rdx
               	addq	$0x2, %rdx
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jl	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %rdx
               	leaq	(%rdx,%rdx,2), %rdi
               	movslq	%eax, %rcx
               	leaq	(%rdi,%rcx), %r8
               	movq	%r8, %r9
               	shlq	%r9
               	leaq	(%r9), %rbx
               	shlq	$0x2, %rbx
               	leaq	0x48(%rbx), %r12
               	imulq	$0x18, %rdx, %rbx
               	movq	%rcx, %r13
               	shlq	$0x3, %r13
               	addq	%rbx, %r13
               	addq	$0x0, %r13
               	addq	$0x48, %r13
               	cmpq	%r12, %r13
               	jne	<addr>
               	leaq	0x1(%r9), %rdi
               	shlq	$0x2, %rdi
               	addq	$0x48, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rbx, %rdx
               	addq	$0x4, %rdx
               	addq	$0x48, %rdx
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
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
               	incq	%rsi
               	shlq	$0x2, %rsi
               	addq	$0x50, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %rdi
               	imulq	$0x34, %rdi, %rdx
               	leaq	0xac(%rdx), %r8
               	movslq	%eax, %rcx
               	leaq	(%rcx,%rcx,2), %r9
               	leaq	(%r9), %rbx
               	shlq	$0x2, %rbx
               	leaq	(%r8,%rbx), %r12
               	imulq	$0xc, %rcx, %rbx
               	leaq	(%rdx,%rbx), %r13
               	addq	$0x0, %r13
               	addq	$0xac, %r13
               	cmpq	%r12, %r13
               	jne	<addr>
               	incq	%r9
               	shlq	$0x2, %r9
               	addq	%r9, %r8
               	addq	%rbx, %rdx
               	addq	$0x4, %rdx
               	addq	$0xac, %rdx
               	cmpq	%r8, %rdx
               	jne	<addr>
               	imulq	$0x34, %rdi, %rdx
               	leaq	0xac(%rdx), %rdi
               	leaq	(%rcx,%rcx,2), %r8
               	addq	$0x2, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdi
               	imulq	$0xc, %rcx, %r8
               	addq	%r8, %rdx
               	addq	$0x8, %rdx
               	addq	$0xac, %rdx
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
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
