
overaligned_automatic16.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x38, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, %rcx
               	sarq	$0x3f, %rcx
               	leaq	(%rsp), %rax
               	movq	%rdi, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	leaq	0x10(%rsp), %rdx
               	leaq	0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, 0x10(%rsp)
               	leaq	0x2(%rdi), %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, 0x18(%rsp)
               	leaq	0x20(%rsp), %rsi
               	leaq	0x3(%rdi), %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, %r8
               	sarq	$0x3f, %r8
               	movq	%rcx, 0x20(%rsp)
               	movq	%r8, 0x28(%rsp)
               	andq	$0xf, %rax
               	andq	$0xf, %rdx
               	orq	%rdx, %rax
               	andq	$0xf, %rsi
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	orq	$0x1, %rax
               	movl	%eax, <rip> # <addr>
               	movq	(%rsp), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rdx
               	addq	%rdx, %rax
               	shlq	%rdi
               	leaq	0x3(%rdi), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	orq	$0x2, %rax
               	movl	%eax, <rip> # <addr>
               	addq	$0x38, %rsp
               	retq

<probe_odd>:
               	subq	$0x48, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, 0x38(%rsp)
               	movq	0x38(%rsp), %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	leaq	(%rsp), %rax
               	movq	%rcx, (%rsp)
               	movq	%rdx, 0x8(%rsp)
               	leaq	0x10(%rsp), %rdx
               	movq	0x38(%rsp), %rcx
               	incq	%rcx
               	movq	%rcx, 0x10(%rsp)
               	movq	0x38(%rsp), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, 0x18(%rsp)
               	leaq	0x20(%rsp), %rsi
               	movq	0x38(%rsp), %rcx
               	addq	$0x3, %rcx
               	movq	%rcx, %r8
               	sarq	$0x3f, %r8
               	movq	%rcx, 0x20(%rsp)
               	movq	%r8, 0x28(%rsp)
               	andq	$0xf, %rax
               	andq	$0xf, %rdx
               	orq	%rdx, %rax
               	andq	$0xf, %rsi
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	orq	$0x4, %rax
               	movl	%eax, <rip> # <addr>
               	movq	(%rsp), %rax
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rdi, %rcx
               	shlq	%rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	leaq	0x3(%rdi), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	orq	$0x8, %rax
               	movl	%eax, <rip> # <addr>
               	addq	$0x48, %rsp
               	retq

<walk>:
               	subq	$0x80, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	leaq	0x30(%rsp), %rcx
               	imulq	$0x55555556, %rbx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	leaq	(%rax,%rax,2), %rdx
               	movq	%rbx, %rax
               	subq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	%rbx, (%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%ebx, %ebx
               	jle	<addr>
               	leaq	-0x1(%rbx), %r12
               	leaq	0x48(%rsp), %rcx
               	imulq	$0x55555556, %r12, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	leaq	(%rax,%rax,2), %rdx
               	movq	%r12, %rax
               	subq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	%r12, (%rax)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	testl	%r12d, %r12d
               	jle	<addr>
               	leaq	-0x1(%r12), %r13
               	leaq	0x60(%rsp), %rcx
               	imulq	$0x55555556, %r13, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	leaq	(%rax,%rax,2), %rdx
               	movq	%r13, %rax
               	subq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	%r13, (%rax)
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%r13d, %r13d
               	jle	<addr>
               	leaq	-0x1(%r13), %rcx
               	leaq	0x78(%rsp), %rdx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	leaq	(%rax,%rax,2), %rsi
               	movq	%rcx, %rax
               	subq	%rsi, %rax
               	shlq	$0x3, %rax
               	addq	%rdx, %rax
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
               	leaq	0x78(%rsp), %rdx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rax
               	movq	(%rax), %rax
               	leaq	0x60(%rsp), %rcx
               	imulq	$0x55555556, %r13, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	leaq	(%rax,%rax,2), %rdx
               	movq	%r13, %rax
               	subq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	(%rax), %rax
               	leaq	0x48(%rsp), %rcx
               	imulq	$0x55555556, %r12, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	leaq	(%rax,%rax,2), %rdx
               	movq	%r12, %rax
               	subq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	(%rax), %rax
               	leaq	0x30(%rsp), %rcx
               	imulq	$0x55555556, %rbx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	leaq	(%rax,%rax,2), %rdx
               	movq	%rbx, %rax
               	subq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x80, %rsp
               	retq

<main>:
               	pushq	%rax
               	movl	$0x6, %edi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	popq	%r11
               	retq
