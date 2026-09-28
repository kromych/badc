
inline_asm_stack_switch_spill.x64:	file format elf64-x86-64

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
               	movq	%rdi, %rax
               	shlq	%rax
               	incq	%rax
               	retq

<on_other_stack>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
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
               	leaq	<rip>, %rax
               	leaq	<rip>, %rbx
               	leaq	0xff00(%rbx), %rbx
               	movq	%rsp, (%rax)
               	movq	%rbx, %rsp
               	callq	<addr>
               	movq	%r13, %rcx
               	shlq	%rcx
               	addq	%r12, %rcx
               	leaq	(%r14,%r14,2), %rdx
               	addq	%rdx, %rcx
               	movq	%r15, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
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
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rsp
               	movq	%rcx, %rax
               	leaq	-0x90(%rbp), %rsp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rbx
               	leave
               	retq

<on_own_stack>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	0x1(%rdi), %rbx
               	leaq	(%rdi,%rdi,2), %r12
               	movq	%rdi, %r13
               	xorq	$0x55, %r13
               	movq	%rdi, %r14
               	imulq	%rdi, %r14
               	leaq	-0x9(%rdi), %r15
               	movq	%rdi, %r10
               	shlq	$0x4, %r10
               	movq	%r10, 0x88(%rsp)
               	imulq	$0x7, %rdi, %rax
               	leaq	0x2(%rax), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	%rdi, %r10
               	xorq	$0x1234, %r10           # imm = 0x1234
               	movq	%r10, 0x78(%rsp)
               	imulq	$0xb, %rdi, %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	0x64(%rdi), %r10
               	movq	%r10, 0x68(%rsp)
               	imulq	$0xd, %rdi, %rax
               	leaq	-0x5(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	%rdi, %r10
               	shlq	$0x9, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rdi, %r10
               	xorq	$0x7777, %r10           # imm = 0x7777
               	movq	%r10, 0x50(%rsp)
               	imulq	$0x11, %rdi, %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x3039(%rdi), %r10
               	movq	%r10, 0x40(%rsp)
               	imulq	$0x13, %rdi, %rax
               	leaq	0x3(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	callq	<addr>
               	movq	%r12, %rcx
               	shlq	%rcx
               	addq	%rbx, %rcx
               	leaq	(%r13,%r13,2), %rdx
               	addq	%rdx, %rcx
               	movq	%r14, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	leaq	(%r15,%r15,4), %rdx
               	addq	%rdx, %rcx
               	movq	0x88(%rsp), %rdx
               	imulq	$0x6, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x80(%rsp), %rdx
               	imulq	$0x7, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x78(%rsp), %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	0x70(%rsp), %rdx
               	leaq	(%rdx,%rdx,8), %rdx
               	addq	%rdx, %rcx
               	movq	0x68(%rsp), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x60(%rsp), %rdx
               	imulq	$0xb, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x58(%rsp), %rdx
               	imulq	$0xc, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x50(%rsp), %rdx
               	imulq	$0xd, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x48(%rsp), %rdx
               	imulq	$0xe, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x40(%rsp), %rdx
               	imulq	$0xf, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x38(%rsp), %rdx
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
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%r12, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	0x1(%rbx), %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	0x1(%rbx), %rdi
               	callq	<addr>
               	cmpq	%rax, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
