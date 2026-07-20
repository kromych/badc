
typedef_array_outer_dim.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<fill_and_sum>:
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	leaq	(%rsi), %r8
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	$0x0, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, (%r8)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	addq	%rdi, %rsi
               	addq	$0x0, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rdx,%rsi), %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x8(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x8(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x10(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x10(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0x3, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x18(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x18(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0x4, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x20(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x20(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0x5, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x28(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x28(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0x6, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x30(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x30(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0x7, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x38(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x38(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0x8, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x40(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x40(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0x9, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x48(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x48(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0xa, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x50(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x50(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0xb, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x58(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x58(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0xc, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x60(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x60(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0xd, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x68(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x68(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0xe, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x70(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x70(%rdx), %rdx
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0xf, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, 0x78(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rdi, %rdx
               	movq	0x78(%rdx), %rdx
               	addq	%r8, %rdx
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	movq	%rdx, %rax
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x230, %rsp            # imm = 0x230
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movq	%rax, %rbx
               	jmp	<addr>
               	addq	%rcx, %rbx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x40, %rcx
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
