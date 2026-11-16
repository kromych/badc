
overaligned_automatic16.x64:	file format elf64-x86-64

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

<probe_even>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	leaq	-0x30(%rbp), %rcx
               	movq	%rdi, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rax
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	leaq	0x3(%rdi), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	sarq	$0x3f, %r8
               	movq	%rax, -0x10(%rbp)
               	movq	%r8, -0x8(%rbp)
               	andq	$0xf, %rcx
               	andq	$0xf, %rdx
               	orq	%rdx, %rcx
               	andq	$0xf, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	<rip>, %ecx # <addr>
               	orq	$0x1, %rcx
               	movl	%ecx, <rip> # <addr>
               	movq	-0x30(%rbp), %rcx
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	movq	-0x20(%rbp), %rcx
               	movq	-0x18(%rbp), %rdx
               	addq	%rdx, %rcx
               	shlq	%rdi
               	leaq	0x3(%rdi), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	-0x10(%rbp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	orq	$0x2, %rax
               	movl	%eax, <rip> # <addr>
               	leave
               	retq

<probe_odd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movq	-0x8(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movq	-0x8(%rbp), %rax
               	addq	$0x3, %rax
               	movq	%rax, %r8
               	sarq	$0x3f, %r8
               	movq	%rax, -0x20(%rbp)
               	movq	%r8, -0x18(%rbp)
               	andq	$0xf, %rdx
               	andq	$0xf, %rcx
               	orq	%rdx, %rcx
               	andq	$0xf, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	orq	$0x4, %rax
               	movl	%eax, <rip> # <addr>
               	movq	-0x40(%rbp), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	0x3(%rdi), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	orq	$0x8, %rax
               	movl	%eax, <rip> # <addr>
               	leave
               	retq

<walk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	leaq	-0x60(%rbp), %rcx
               	imulq	$0x55555556, %rbx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	leaq	(%rax,%rax,2), %rax
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rcx,%rdx), %rax
               	movq	%rbx, (%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%ebx, %ebx
               	jle	<addr>
               	leaq	-0x1(%rbx), %r12
               	leaq	-0x48(%rbp), %rax
               	imulq	$0x55555556, %r12, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%r12, %rdx
               	subq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	movq	%r12, (%rax)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	testl	%r12d, %r12d
               	jle	<addr>
               	leaq	-0x1(%r12), %r13
               	leaq	-0x30(%rbp), %rax
               	imulq	$0x55555556, %r13, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%r13, %rdx
               	subq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	movq	%r13, (%rax)
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%r13d, %r13d
               	jle	<addr>
               	leaq	-0x1(%r13), %rcx
               	leaq	-0x18(%rbp), %rax
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	%rcx, %rsi
               	subq	%rdx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	0x28(%rsp), %rcx
               	movq	%rcx, 0x28(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	0x28(%rsp), %rcx
               	testl	%ecx, %ecx
               	jle	<addr>
               	leaq	-0x1(%rcx), %rdi
               	movq	%rcx, 0x28(%rsp)
               	callq	<addr>
               	movq	0x28(%rsp), %rcx
               	leaq	-0x18(%rbp), %rax
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rax
               	leaq	-0x30(%rbp), %rax
               	imulq	$0x55555556, %r13, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%r13, %rdx
               	subq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	movq	(%rax), %rax
               	leaq	-0x48(%rbp), %rax
               	imulq	$0x55555556, %r12, %rcx # imm = 0x55555556
               	shrq	$0x20, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	%r12, %rdx
               	subq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	movq	(%rax), %rax
               	leaq	-0x60(%rbp), %rcx
               	imulq	$0x55555556, %rbx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	leaq	(%rax,%rax,2), %rax
               	movq	%rbx, %rdx
               	subq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rcx,%rdx), %rax
               	movq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x6, %edi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	popq	%rbp
               	retq
