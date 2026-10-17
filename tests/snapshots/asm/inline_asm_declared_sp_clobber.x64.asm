
inline_asm_declared_sp_clobber.x64:	file format elf64-x86-64

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

<mix>:
               	shlq	%rdi
               	leaq	0x1(%rdi), %rax
               	retq

<moved>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x1(%rdi), %r12
               	leaq	(%rdi,%rdi,2), %r13
               	movq	%rdi, %r14
               	xorq	$0x55, %r14
               	movq	%rdi, %r15
               	imulq	%rdi, %r15
               	leaq	-0x9(%rdi), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rdi, %r10
               	shlq	$0x4, %r10
               	movq	%r10, -0x10(%rbp)
               	imulq	$0x7, %rdi, %rax
               	leaq	0x2(%rax), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	%rdi, %r10
               	xorq	$0x1234, %r10           # imm = 0x1234
               	movq	%r10, -0x20(%rbp)
               	imulq	$0xb, %rdi, %r10
               	movq	%r10, -0x28(%rbp)
               	leaq	0x64(%rdi), %r10
               	movq	%r10, -0x30(%rbp)
               	imulq	$0xd, %rdi, %rax
               	leaq	-0x5(%rax), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	%rdi, %r10
               	shlq	$0x9, %r10
               	movq	%r10, -0x40(%rbp)
               	movq	%rdi, %r10
               	xorq	$0x7777, %r10           # imm = 0x7777
               	movq	%r10, -0x48(%rbp)
               	imulq	$0x11, %rdi, %r10
               	movq	%r10, -0x50(%rbp)
               	leaq	0x3039(%rdi), %r10
               	movq	%r10, -0x58(%rbp)
               	imulq	$0x13, %rdi, %rax
               	leaq	0x3(%rax), %r10
               	movq	%r10, -0x60(%rbp)
               	callq	<addr>
               	movq	%rax, %rbx
               	pushq	$0x77
               	pushq	$0x77
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	shlq	%r13
               	leaq	(%r12,%r13), %rcx
               	leaq	(%r14,%r14,2), %rdx
               	addq	%rdx, %rcx
               	shlq	$0x2, %r15
               	addq	%r15, %rcx
               	movq	-0x8(%rbp), %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	movq	-0x10(%rbp), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	-0x18(%rbp), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	-0x20(%rbp), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	-0x28(%rbp), %rdx
               	leaq	(%rdx,%rdx,8), %rdx
               	addq	%rdx, %rcx
               	movq	-0x30(%rbp), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	-0x38(%rbp), %rdx
               	imulq	$0xb, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	-0x40(%rbp), %rdx
               	imulq	$0xc, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	-0x48(%rbp), %rdx
               	imulq	$0xd, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	-0x50(%rbp), %rdx
               	imulq	$0xe, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	-0x58(%rbp), %rdx
               	imulq	$0xf, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	-0x60(%rbp), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<kept>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x1(%rdi), %r12
               	leaq	(%rdi,%rdi,2), %r13
               	movq	%rdi, %r14
               	xorq	$0x55, %r14
               	movq	%rdi, %r15
               	imulq	%rdi, %r15
               	leaq	-0x9(%rdi), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	%rdi, %r10
               	shlq	$0x4, %r10
               	movq	%r10, 0x80(%rsp)
               	imulq	$0x7, %rdi, %rax
               	leaq	0x2(%rax), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	%rdi, %r10
               	xorq	$0x1234, %r10           # imm = 0x1234
               	movq	%r10, 0x70(%rsp)
               	imulq	$0xb, %rdi, %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	0x64(%rdi), %r10
               	movq	%r10, 0x60(%rsp)
               	imulq	$0xd, %rdi, %rax
               	leaq	-0x5(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rdi, %r10
               	shlq	$0x9, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rdi, %r10
               	xorq	$0x7777, %r10           # imm = 0x7777
               	movq	%r10, 0x48(%rsp)
               	imulq	$0x11, %rdi, %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0x3039(%rdi), %r10
               	movq	%r10, 0x38(%rsp)
               	imulq	$0x13, %rdi, %rax
               	leaq	0x3(%rax), %r10
               	movq	%r10, 0x30(%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	shlq	%r13
               	leaq	(%r12,%r13), %rcx
               	leaq	(%r14,%r14,2), %rdx
               	addq	%rdx, %rcx
               	shlq	$0x2, %r15
               	addq	%r15, %rcx
               	movq	0x88(%rsp), %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	addq	%rdx, %rcx
               	movq	0x80(%rsp), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x78(%rsp), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x70(%rsp), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	0x68(%rsp), %rdx
               	leaq	(%rdx,%rdx,8), %rdx
               	addq	%rdx, %rcx
               	movq	0x60(%rsp), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x58(%rsp), %rdx
               	imulq	$0xb, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x50(%rsp), %rdx
               	imulq	$0xc, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x48(%rsp), %rdx
               	imulq	$0xd, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x40(%rsp), %rdx
               	imulq	$0xe, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x38(%rsp), %rdx
               	imulq	$0xf, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x30(%rsp), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	(%rcx,%rcx,4), %r12
               	movq	(%rax), %rcx
               	movq	%rcx, %r13
               	xorq	$0x99, %r13
               	movq	(%rax), %rcx
               	leaq	0x4d(%rcx), %r14
               	movq	(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %r15
               	movq	(%rax), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	cmpq	$0x23, %r12
               	jne	<addr>
               	cmpq	$0x9e, %r13
               	jne	<addr>
               	cmpq	$0x54, %r14
               	jne	<addr>
               	cmpq	$0x15, %r15
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x1(%rbx), %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	0x1(%rbx), %rdi
               	callq	<addr>
               	cmpq	%rax, %r12
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
