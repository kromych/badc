
int128_mul.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<chk>:
               	popq	%r10
               	subq	$0x40, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, %rsi
               	movq	%rcx, %rdi
               	movq	%r8, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%rsi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	xorq	%rsi, %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	cmpq	%rdi, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>

<mulhi>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	%rdi, %rbx
               	imulq	%rsi, %rbx
               	movl	%edi, %eax
               	movq	%rdi, %rdx
               	shrq	$0x20, %rdx
               	movl	%esi, %r8d
               	movq	%rsi, %r9
               	shrq	$0x20, %r9
               	movq	%rax, %r12
               	imulq	%r8, %r12
               	shrq	$0x20, %r12
               	imulq	%rdx, %r8
               	addq	%r12, %r8
               	movl	%r8d, %r12d
               	shrq	$0x20, %r8
               	imulq	%r9, %rax
               	addq	%r12, %rax
               	shrq	$0x20, %rax
               	imulq	%r9, %rdx
               	addq	%r8, %rdx
               	addq	%rdx, %rax
               	movq	%rdi, %rdx
               	imulq	%rcx, %rdx
               	imulq	%rcx, %rsi
               	addq	%rdx, %rax
               	leaq	(%rax,%rsi), %rdx
               	leaq	-0x20(%rbp), %rax
               	movq	%rbx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rdx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1b0, %rsp            # imm = 0x1B0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	leaq	-0x98(%rbp), %rax
               	movq	%rbx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	%rbx, %r8
               	imulq	%r12, %r8
               	movl	%ebx, %eax
               	movq	%rbx, %rdx
               	shrq	$0x20, %rdx
               	movl	%r12d, %esi
               	movq	%r12, %rdi
               	shrq	$0x20, %rdi
               	movq	%rax, %r9
               	imulq	%rsi, %r9
               	shrq	$0x20, %r9
               	imulq	%rdx, %rsi
               	addq	%r9, %rsi
               	movl	%esi, %r9d
               	shrq	$0x20, %rsi
               	imulq	%rdi, %rax
               	addq	%r9, %rax
               	shrq	$0x20, %rax
               	imulq	%rdi, %rdx
               	addq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	%rbx, %rdx
               	imulq	%rcx, %rdx
               	imulq	%r12, %rcx
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	-0xa8(%rbp), %rax
               	movq	%r8, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x28(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x28(%rbp), %rdi
               	movabsq	$-0x1a30fba3fb44a2f0, %rsi # imm = 0xE5CF045C04BB5D10
               	movabsq	$-0x22409b8b647cc5c5, %rdx # imm = 0xDDBF64749B833A3B
               	movl	$0x1, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movabsq	$-0x22409b8b647cc5c5, %r11 # imm = 0xDDBF64749B833A3B
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %rax
               	movq	%rbx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	%rbx, %rdx
               	imulq	%r12, %rdx
               	movl	%ebx, %eax
               	movq	%rbx, %rsi
               	shrq	$0x20, %rsi
               	movl	%r12d, %edi
               	movq	%r12, %r8
               	shrq	$0x20, %r8
               	movq	%rax, %r9
               	imulq	%rdi, %r9
               	shrq	$0x20, %r9
               	imulq	%rsi, %rdi
               	addq	%r9, %rdi
               	movl	%edi, %r9d
               	shrq	$0x20, %rdi
               	imulq	%r8, %rax
               	addq	%r9, %rax
               	shrq	$0x20, %rax
               	imulq	%r8, %rsi
               	addq	%rdi, %rsi
               	addq	%rsi, %rax
               	movq	%rbx, %rsi
               	imulq	%rcx, %rsi
               	imulq	%r12, %rcx
               	addq	%rsi, %rax
               	addq	%rax, %rcx
               	leaq	-0xc8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rbx, %rax
               	imulq	%r12, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %r9
               	leaq	-0x28(%rbp), %rdx
               	movq	(%rdx), %rcx
               	movq	0x8(%rdx), %rbx
               	movq	%rax, %r12
               	imulq	%rcx, %r12
               	movl	%eax, %edx
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	movl	%ecx, %edi
               	movq	%rcx, %r8
               	shrq	$0x20, %r8
               	movq	%rdx, %r13
               	imulq	%rdi, %r13
               	shrq	$0x20, %r13
               	imulq	%rsi, %rdi
               	addq	%r13, %rdi
               	movl	%edi, %r13d
               	shrq	$0x20, %rdi
               	imulq	%r8, %rdx
               	addq	%r13, %rdx
               	shrq	$0x20, %rdx
               	imulq	%r8, %rsi
               	addq	%rdi, %rsi
               	addq	%rsi, %rdx
               	imulq	%rbx, %rax
               	imulq	%r9, %rcx
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	-0xd8(%rbp), %rax
               	movq	%r12, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x38(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rdi
               	movabsq	$0x6189c7899734a100, %rsi # imm = 0x6189C7899734A100
               	movabsq	$-0x6a05b5499fbdfde8, %rdx # imm = 0x95FA4AB660420218
               	movl	$0x4, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %rax
               	leaq	-0xe8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movabsq	$-0x1, %rsi
               	movq	%rsi, 0x8(%rcx)
               	movabsq	$-0x7, %rcx
               	leaq	-0xf8(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	movq	%rax, %rbx
               	imulq	%rcx, %rbx
               	movl	%eax, %edx
               	movq	%rax, %rdi
               	shrq	$0x20, %rdi
               	movl	%ecx, %r8d
               	movq	%rcx, %r9
               	shrq	$0x20, %r9
               	movq	%rdx, %r12
               	imulq	%r8, %r12
               	shrq	$0x20, %r12
               	imulq	%rdi, %r8
               	addq	%r12, %r8
               	movl	%r8d, %r12d
               	shrq	$0x20, %r8
               	imulq	%r9, %rdx
               	addq	%r12, %rdx
               	shrq	$0x20, %rdx
               	imulq	%r9, %rdi
               	addq	%r8, %rdi
               	addq	%rdi, %rdx
               	imulq	%rsi, %rax
               	imulq	%rsi, %rcx
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	-0x108(%rbp), %rax
               	movq	%rbx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x48(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x48(%rbp), %rdi
               	movl	$0x23, %esi
               	xorq	%rdx, %rdx
               	movl	$0x5, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rbx
               	movl	$0x1, %ecx
               	leaq	-0x118(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, 0x8(%rax)
               	shlq	$0x24, %rcx
               	leaq	-0x128(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$-0x3, %rax
               	movq	%rsi, %r12
               	imulq	%rax, %r12
               	movl	%esi, %edx
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	movl	$0xfffffffd, %r8d       # imm = 0xFFFFFFFD
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	movq	%rdx, %r13
               	imulq	%r8, %r13
               	shrq	$0x20, %r13
               	imulq	%rdi, %r8
               	addq	%r13, %r8
               	movl	%r8d, %r13d
               	shrq	$0x20, %r8
               	imulq	%r9, %rdx
               	addq	%r13, %rdx
               	shrq	$0x20, %rdx
               	imulq	%r9, %rdi
               	addq	%r8, %rdi
               	addq	%rdi, %rdx
               	imulq	$-0x1, %rsi, %rdi
               	imulq	%rcx, %rax
               	leaq	(%rdx,%rdi), %rcx
               	addq	%rax, %rcx
               	leaq	-0x138(%rbp), %rax
               	movq	%r12, (%rax)
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x48(%rbp), %rdi
               	movabsq	$-0x3000000000, %rdx    # imm = 0xFFFFFFD000000000
               	movl	$0x6, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	-0x148(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rcx)
               	shlq	$0x20, %rdx
               	leaq	-0x158(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	0x5(%rax), %rsi
               	cmpq	%rax, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	$0x0, %rdx
               	addq	%rcx, %rdx
               	leaq	-0x168(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x58(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x58(%rbp), %rdx
               	movq	(%rdx), %rcx
               	movq	0x8(%rdx), %r8
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	movl	%ecx, %edx
               	movq	%rcx, %rsi
               	shrq	$0x20, %rsi
               	movq	%rdx, %rdi
               	shlq	$0x4, %rdi
               	shrq	$0x20, %rdi
               	movq	%rsi, %rbx
               	shlq	$0x4, %rbx
               	addq	%rbx, %rdi
               	movl	%edi, %ebx
               	shrq	$0x20, %rdi
               	imulq	%rax, %rdx
               	addq	%rbx, %rdx
               	shrq	$0x20, %rdx
               	imulq	%rax, %rsi
               	addq	%rdi, %rsi
               	addq	%rsi, %rdx
               	imulq	%rcx, %rax
               	movq	%r8, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	leaq	-0x178(%rbp), %rdi
               	movq	%r9, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x50, %esi
               	movabsq	$0x1000000000, %rdx     # imm = 0x1000000000
               	movl	$0x7, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	leaq	-0x58(%rbp), %rdx
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %rdi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	movl	%eax, %edx
               	movq	%rax, %rsi
               	shrq	$0x20, %rsi
               	movq	%rdx, %r9
               	shlq	$0x4, %r9
               	shrq	$0x20, %r9
               	imulq	%rcx, %rdx
               	addq	%r9, %rdx
               	movl	%edx, %r9d
               	shrq	$0x20, %rdx
               	movq	%rsi, %rbx
               	shlq	$0x4, %rbx
               	addq	%rbx, %r9
               	shrq	$0x20, %r9
               	imulq	%rcx, %rsi
               	addq	%rsi, %rdx
               	addq	%r9, %rdx
               	movq	%rdi, %rsi
               	shlq	$0x4, %rsi
               	imulq	%rcx, %rax
               	leaq	(%rdx,%rsi), %rcx
               	addq	%rcx, %rax
               	leaq	-0x188(%rbp), %rdi
               	movq	%r8, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x50, %esi
               	movabsq	$0x1000000000, %rdx     # imm = 0x1000000000
               	movl	$0x8, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x68(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rbx
               	movabsq	$-0x61c8864680b583eb, %rdx # imm = 0x9E3779B97F4A7C15
               	movq	%rcx, %r12
               	imulq	%rdx, %r12
               	movl	%ecx, %esi
               	movq	%rcx, %rdi
               	shrq	$0x20, %rdi
               	movl	$0x7f4a7c15, %r8d       # imm = 0x7F4A7C15
               	movl	$0x9e3779b9, %r9d       # imm = 0x9E3779B9
               	movq	%rsi, %r13
               	imulq	%r8, %r13
               	shrq	$0x20, %r13
               	imulq	%rdi, %r8
               	addq	%r13, %r8
               	movl	%r8d, %r13d
               	shrq	$0x20, %r8
               	imulq	%r9, %rsi
               	addq	%r13, %rsi
               	shrq	$0x20, %rsi
               	imulq	%r9, %rdi
               	addq	%r8, %rdi
               	addq	%rdi, %rsi
               	imulq	$0x0, %rcx, %rcx
               	imulq	%rbx, %rdx
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%r12, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x68(%rbp), %rdi
               	movabsq	$-0x1e22f04504ed9db0, %rsi # imm = 0xE1DD0FBAFB126250
               	movabsq	$-0x54b9b0367b5ac859, %rdx # imm = 0xAB464FC984A537A7
               	movl	$0x9, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
