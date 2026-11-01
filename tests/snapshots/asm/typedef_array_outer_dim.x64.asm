
typedef_array_outer_dim.x64:	file format elf64-x86-64

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
               	subq	$0x200, %rsp            # imm = 0x200
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	addq	%rax, %rsi
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x200(%rbp), %rcx
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	movq	%rax, %rdi
               	shlq	$0x7, %rdi
               	addq	%rcx, %rdi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	movq	%r8, (%rdi)
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x1(%rdx), %r9
               	movq	%r9, 0x8(%rdi)
               	movq	%rax, %rdi
               	shlq	$0x7, %rdi
               	addq	%rcx, %rdi
               	movq	0x8(%rdi), %r9
               	addq	%r9, %r8
               	addq	$0x2, %rdx
               	movq	%rdx, 0x10(%rdi)
               	addq	%rdx, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rcx, %rdx
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	addq	$0x3, %rdi
               	movq	%rdi, 0x18(%rdx)
               	addq	%rdi, %r8
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	leaq	0x4(%rdi), %r9
               	movq	%r9, 0x20(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rcx, %rdx
               	movq	0x20(%rdx), %r9
               	addq	%r9, %r8
               	addq	$0x5, %rdi
               	movq	%rdi, 0x28(%rdx)
               	addq	%rdi, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rcx, %rdx
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	addq	$0x6, %rdi
               	movq	%rdi, 0x30(%rdx)
               	addq	%rdi, %r8
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	leaq	0x7(%rdi), %r9
               	movq	%r9, 0x38(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rcx, %rdx
               	movq	0x38(%rdx), %r9
               	addq	%r9, %r8
               	addq	$0x8, %rdi
               	movq	%rdi, 0x40(%rdx)
               	addq	%rdi, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rcx, %rdx
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	addq	$0x9, %rdi
               	movq	%rdi, 0x48(%rdx)
               	addq	%rdi, %r8
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	leaq	0xa(%rdi), %r9
               	movq	%r9, 0x50(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rcx, %rdx
               	movq	0x50(%rdx), %r9
               	addq	%r9, %r8
               	addq	$0xb, %rdi
               	movq	%rdi, 0x58(%rdx)
               	addq	%rdi, %r8
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rcx, %rdx
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	addq	$0xc, %rdi
               	movq	%rdi, 0x60(%rdx)
               	addq	%rdi, %r8
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	leaq	0xd(%rdi), %r9
               	movq	%r9, 0x68(%rdx)
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	addq	%rcx, %rdx
               	movq	0x68(%rdx), %r9
               	addq	%r9, %r8
               	addq	$0xe, %rdi
               	movq	%rdi, 0x70(%rdx)
               	addq	%r8, %rdi
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rcx,%rdx), %r8
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	$0xf, %rdx
               	movq	%rdx, 0x78(%r8)
               	addq	%rdi, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpq	$0x0, -0x200(%rbp)
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x3f, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0x148(%rbp), %rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
