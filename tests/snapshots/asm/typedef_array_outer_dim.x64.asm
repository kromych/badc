
typedef_array_outer_dim.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fill_and_sum>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	addq	$0x0, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0x0, %r8
               	movslq	%r8d, %r8
               	movq	%r8, (%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	addq	$0x0, %rsi
               	movq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	incq	%r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x8(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x8(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0x2, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x10(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x10(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0x3, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x18(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x18(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0x4, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x20(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x20(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0x5, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x28(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x28(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0x6, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x30(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x30(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0x7, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x38(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x38(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0x8, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x40(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x40(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0x9, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x48(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x48(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0xa, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x50(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x50(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0xb, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x58(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x58(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0xc, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x60(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x60(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0xd, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x68(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x68(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0xe, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x70(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x70(%rsi), %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	%rdx, %r8
               	shlq	$0x4, %r8
               	addq	$0xf, %r8
               	movslq	%r8d, %r8
               	movq	%r8, 0x78(%rsi)
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	movq	0x78(%rsi), %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x4, %rdx
               	jl	<addr>
               	movq	%rcx, %rax
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x230, %rsp            # imm = 0x230
               	movq	%rbx, (%rsp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rbx
               	jmp	<addr>
               	addq	%rax, %rbx
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x40, %rax
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	movq	0x1f8(%rax), %rax
               	cmpq	$0x3f, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x200(%rbp), %rax
               	movq	0xb8(%rax), %rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
