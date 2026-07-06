
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
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	addq	$0x0, %rsi
               	shlq	$0x4, %rdx
               	addq	$0x0, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, (%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	addq	$0x0, %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x8(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x10(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x10(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0x3, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x18(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x18(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0x4, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x20(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x20(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0x5, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x28(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x28(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0x6, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x30(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x30(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0x7, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x38(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x38(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0x8, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x40(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x40(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0x9, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x48(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x48(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0xa, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x50(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x50(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0xb, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x58(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x58(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0xc, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x60(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x60(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0xd, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x68(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x68(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0xe, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x70(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x70(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	shlq	$0x4, %rdx
               	addq	$0xf, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x78(%rsi)
               	movslq	%eax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x78(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%eax, %rax
               	incq	%rax
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
               	movslq	%ecx, %rax
               	addq	%rax, %rbx
               	movslq	%ecx, %rax
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
