
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
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	cmpl	$0x5, %eax
               	jge	<addr>
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
               	cmpl	$0x4, %ecx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	(%rcx,%rcx,2), %rdi
               	leaq	(%rdi,%rax), %r8
               	movq	%r8, %rdx
               	shlq	%rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	leaq	0x48(%rsi), %r12
               	imulq	$0x18, %rcx, %r9
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	leaq	(%r9,%rbx), %rsi
               	leaq	0x48(%rsi), %r13
               	cmpq	%r12, %r13
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
               	cmpl	$0x4, %eax
               	jge	<addr>
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
               	xorl	%edx, %edx
               	cmpl	$0x3, %edx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	imulq	$0x34, %rdx, %rcx
               	leaq	0xac(%rcx), %r8
               	leaq	(%rax,%rax,2), %rsi
               	movq	%rsi, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%r8,%rdi), %rbx
               	imulq	$0xc, %rax, %r9
               	leaq	(%rcx,%r9), %rdi
               	leaq	0xac(%rdi), %r12
               	cmpq	%rbx, %r12
               	jne	<addr>
               	incq	%rsi
               	shlq	$0x2, %rsi
               	addq	%r8, %rsi
               	addq	$0x4, %rdi
               	addq	$0xac, %rdi
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	leaq	0xac(%rcx), %rsi
               	leaq	(%rax,%rax,2), %rdi
               	addq	$0x2, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rsi
               	imulq	$0xc, %rax, %rdi
               	addq	%rdi, %rcx
               	addq	$0x8, %rcx
               	addq	$0xac, %rcx
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x3, %edx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
