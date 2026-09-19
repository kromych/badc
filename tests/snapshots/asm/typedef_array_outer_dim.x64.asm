
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
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %r8
               	shlq	$0x7, %r8
               	leaq	(%rdi,%r8), %rdx
               	leaq	(%rdx), %r9
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	$0x0, %rsi
               	movq	%rsi, (%r9)
               	leaq	(%rcx,%rsi), %r9
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x1(%rcx), %rsi
               	movq	%rsi, 0x8(%rdx)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	0x8(%rdx), %r8
               	addq	%r9, %r8
               	addq	$0x2, %rcx
               	movq	%rcx, 0x10(%rdx)
               	addq	%rcx, %r8
               	addq	%rdi, %rsi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x3(%rcx), %rdx
               	movq	%rdx, 0x18(%rsi)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	0x18(%rdx), %r9
               	addq	%r9, %r8
               	addq	$0x4, %rcx
               	movq	%rcx, 0x20(%rdx)
               	addq	%rcx, %r8
               	addq	%rdi, %rsi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x5(%rcx), %rdx
               	movq	%rdx, 0x28(%rsi)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	0x28(%rdx), %r9
               	addq	%r9, %r8
               	addq	$0x6, %rcx
               	movq	%rcx, 0x30(%rdx)
               	addq	%rcx, %r8
               	addq	%rdi, %rsi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x7(%rcx), %rdx
               	movq	%rdx, 0x38(%rsi)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	0x38(%rdx), %r9
               	addq	%r9, %r8
               	addq	$0x8, %rcx
               	movq	%rcx, 0x40(%rdx)
               	addq	%rcx, %r8
               	addq	%rdi, %rsi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x9(%rcx), %rdx
               	movq	%rdx, 0x48(%rsi)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	0x48(%rdx), %r9
               	addq	%r9, %r8
               	addq	$0xa, %rcx
               	movq	%rcx, 0x50(%rdx)
               	addq	%rcx, %r8
               	addq	%rdi, %rsi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0xb(%rcx), %rdx
               	movq	%rdx, 0x58(%rsi)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	0x58(%rdx), %r9
               	addq	%r9, %r8
               	addq	$0xc, %rcx
               	movq	%rcx, 0x60(%rdx)
               	addq	%rcx, %r8
               	addq	%rdi, %rsi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0xd(%rcx), %rdx
               	movq	%rdx, 0x68(%rsi)
               	movq	%rax, %rsi
               	shlq	$0x7, %rsi
               	leaq	(%rdi,%rsi), %rdx
               	movq	0x68(%rdx), %r9
               	addq	%r9, %r8
               	addq	$0xe, %rcx
               	movq	%rcx, 0x70(%rdx)
               	addq	%rcx, %r8
               	leaq	(%rdi,%rsi), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	$0xf, %rcx
               	movq	%rcx, 0x78(%rdx)
               	movq	%rax, %rcx
               	shlq	$0x7, %rcx
               	addq	%rdi, %rcx
               	movq	0x78(%rcx), %rcx
               	addq	%r8, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, %rax
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
               	movq	(%rax), %rcx
               	testq	%rcx, %rcx
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
