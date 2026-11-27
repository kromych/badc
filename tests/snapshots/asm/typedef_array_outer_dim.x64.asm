
typedef_array_outer_dim.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x208, %rsp            # imm = 0x208
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	addq	%rax, %rdi
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	(%rsp), %rcx
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	movq	%rax, %r8
               	shlq	$0x7, %r8
               	leaq	(%rcx,%r8), %r9
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	movq	%rsi, (%r9)
               	addq	%rsi, %rdx
               	incq	%rsi
               	movq	%rsi, 0x8(%r9)
               	leaq	(%rcx,%r8), %rsi
               	movq	0x8(%rsi), %rsi
               	leaq	(%rdx,%rsi), %r10
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	0x2(%r8), %r9
               	movq	%r9, 0x10(%rsi)
               	addq	%r10, %r9
               	addq	$0x3, %r8
               	movq	%r8, 0x18(%rsi)
               	addq	%rcx, %rdx
               	movq	0x18(%rdx), %rdx
               	leaq	(%r9,%rdx), %r10
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	0x4(%r8), %r9
               	movq	%r9, 0x20(%rsi)
               	addq	%r10, %r9
               	addq	$0x5, %r8
               	movq	%r8, 0x28(%rsi)
               	addq	%rcx, %rdx
               	movq	0x28(%rdx), %rdx
               	leaq	(%r9,%rdx), %r10
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	0x6(%r8), %r9
               	movq	%r9, 0x30(%rsi)
               	addq	%r10, %r9
               	addq	$0x7, %r8
               	movq	%r8, 0x38(%rsi)
               	addq	%rcx, %rdx
               	movq	0x38(%rdx), %rdx
               	leaq	(%r9,%rdx), %r10
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	0x8(%r8), %r9
               	movq	%r9, 0x40(%rsi)
               	addq	%r10, %r9
               	addq	$0x9, %r8
               	movq	%r8, 0x48(%rsi)
               	addq	%rcx, %rdx
               	movq	0x48(%rdx), %rdx
               	leaq	(%r9,%rdx), %r10
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	0xa(%r8), %r9
               	movq	%r9, 0x50(%rsi)
               	addq	%r10, %r9
               	addq	$0xb, %r8
               	movq	%r8, 0x58(%rsi)
               	addq	%rcx, %rdx
               	movq	0x58(%rdx), %rdx
               	leaq	(%r9,%rdx), %r10
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	0xc(%r8), %r9
               	movq	%r9, 0x60(%rsi)
               	addq	%r10, %r9
               	addq	$0xd, %r8
               	movq	%r8, 0x68(%rsi)
               	addq	%rcx, %rdx
               	movq	0x68(%rdx), %rdx
               	leaq	(%r9,%rdx), %r10
               	movq	%rax, %rdx
               	shlq	$0x7, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	0xe(%r8), %r9
               	movq	%r9, 0x70(%rsi)
               	addq	%r10, %r9
               	addq	$0xf, %r8
               	movq	%r8, 0x78(%rsi)
               	addq	%rcx, %rdx
               	movq	0x78(%rdx), %rdx
               	addq	%r9, %rdx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x208, %rsp            # imm = 0x208
               	retq
               	cmpq	$0x0, (%rsp)
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x208, %rsp            # imm = 0x208
               	retq
               	movq	0x1f8(%rsp), %rax
               	cmpq	$0x3f, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x208, %rsp            # imm = 0x208
               	retq
               	movq	0xb8(%rsp), %rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x208, %rsp            # imm = 0x208
               	retq
               	xorl	%eax, %eax
               	addq	$0x208, %rsp            # imm = 0x208
               	retq
