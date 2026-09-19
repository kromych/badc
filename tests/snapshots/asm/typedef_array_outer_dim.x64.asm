
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

<fill_and_sum>:
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %r8
               	shlq	$0x7, %r8
               	leaq	(%rdi,%r8), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	movq	%rcx, (%rdx)
               	leaq	(%rsi,%rcx), %r9
               	incq	%rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rcx
               	movq	0x8(%rcx), %rdx
               	addq	%rdx, %r9
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x2(%rdx), %r8
               	movq	%r8, 0x10(%rcx)
               	addq	%r9, %r8
               	addq	$0x3, %rdx
               	movq	%rdx, 0x18(%rcx)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rcx
               	movq	0x18(%rcx), %rdx
               	leaq	(%r8,%rdx), %r9
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x4(%rdx), %r8
               	movq	%r8, 0x20(%rcx)
               	addq	%r9, %r8
               	addq	$0x5, %rdx
               	movq	%rdx, 0x28(%rcx)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rcx
               	movq	0x28(%rcx), %rdx
               	leaq	(%r8,%rdx), %r9
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x6(%rdx), %r8
               	movq	%r8, 0x30(%rcx)
               	addq	%r9, %r8
               	addq	$0x7, %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rcx
               	movq	0x38(%rcx), %rdx
               	leaq	(%r8,%rdx), %r9
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0x8(%rdx), %r8
               	movq	%r8, 0x40(%rcx)
               	addq	%r9, %r8
               	addq	$0x9, %rdx
               	movq	%rdx, 0x48(%rcx)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rcx
               	movq	0x48(%rcx), %rdx
               	leaq	(%r8,%rdx), %r9
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0xa(%rdx), %r8
               	movq	%r8, 0x50(%rcx)
               	addq	%r9, %r8
               	addq	$0xb, %rdx
               	movq	%rdx, 0x58(%rcx)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rcx
               	movq	0x58(%rcx), %rdx
               	leaq	(%r8,%rdx), %r9
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0xc(%rdx), %r8
               	movq	%r8, 0x60(%rcx)
               	addq	%r9, %r8
               	addq	$0xd, %rdx
               	movq	%rdx, 0x68(%rcx)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rcx
               	movq	0x68(%rcx), %rdx
               	leaq	(%r8,%rdx), %r9
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	0xe(%rdx), %r8
               	movq	%r8, 0x70(%rcx)
               	addq	%r9, %r8
               	addq	$0xf, %rdx
               	movq	%rdx, 0x78(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x7, %rcx
               	addq	%rdi, %rcx
               	movq	0x78(%rcx), %rcx
               	leaq	(%r8,%rcx), %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rsi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x208, %rsp            # imm = 0x208
               	pushq	%rbx
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	cmpl	$0x40, %eax
               	jge	<addr>
               	addq	%rax, %rbx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x200(%rbp), %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	0x1f8(%rax), %rcx
               	cmpq	$0x3f, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	0xb8(%rax), %rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
