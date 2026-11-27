
vla_array_type.x64:	file format elf64-x86-64

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

<one_dim>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, %rsi
               	shlq	$0x2, %rsi
               	movq	%rsi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	imulq	$0xa, %rax, %rdx
               	movl	%edx, (%rcx,%rax,4)
               	incq	%rax
               	nop
               	cmpl	%edi, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movl	0x8(%rcx), %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	(%rcx,%rsi), %r8
               	movq	%r8, %rax
               	subq	%rcx, %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cqto
               	idivq	%rsi
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	0xc(%rcx), %eax
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	subq	%rsi, %r8
               	cmpq	%rcx, %r8
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	shlq	%rsi
               	leaq	(%r8,%rsi), %rax
               	subq	%rsi, %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	0x4(%rax), %rdx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	-0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	imulq	$0xa, %rcx, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq

<two_dim>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	imulq	$0xc, %rdi, %r11
               	movq	%r11, %r9
               	addq	$0xf, %r9
               	andq	$-0x10, %r9
               	movq	%rsp, %rdx
               	subq	%r9, %rdx
               	shrq	$0xc, %r9
               	testq	%r9, %r9
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r9
               	jne	<addr>
               	movq	%rdx, %rsp
               	imulq	$0xc, %rdi, %rax
               	movq	%rax, -0x18(%rbp)
               	movq	%rax, %r9
               	addq	$0xf, %r9
               	andq	$-0x10, %r9
               	movq	%rsp, %rsi
               	subq	%r9, %rsi
               	shrq	$0xc, %r9
               	testq	%r9, %r9
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r9
               	jne	<addr>
               	movq	%rsi, %rsp
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	imulq	$0xc, %rax, %r8
               	leaq	(%rdx,%r8), %r9
               	leaq	(%rax,%rax,2), %rcx
               	movl	%ecx, (%r9)
               	addq	%rsi, %r8
               	leaq	0x64(%rcx), %r10
               	movl	%r10d, (%r8)
               	incq	%rcx
               	movl	%ecx, 0x4(%r9)
               	imulq	$0xc, %rax, %r8
               	leaq	(%rsi,%r8), %r9
               	leaq	(%rax,%rax,2), %rcx
               	leaq	0x64(%rcx), %r10
               	incq	%r10
               	movl	%r10d, 0x4(%r9)
               	addq	%rdx, %r8
               	leaq	0x2(%rcx), %r10
               	movl	%r10d, 0x8(%r8)
               	addq	$0x64, %rcx
               	addq	$0x2, %rcx
               	movl	%ecx, 0x8(%r9)
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	cmpq	%rax, %r11
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	0x14(%rdx), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	0x14(%rsi), %eax
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	0x14(%rdx), %rax
               	subq	%rdx, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x1(%rdi), %rax
               	movslq	%eax, %rax
               	imulq	$0xc, %rax, %rcx
               	leaq	(%rdx,%rcx), %r8
               	movl	(%r8), %r8d
               	leaq	(%rax,%rax,2), %rax
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	0xc(%rdx), %r8
               	subq	%rdx, %r8
               	cmpq	$0xc, %r8
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	addq	%rsi, %rcx
               	movl	0x8(%rcx), %ecx
               	addq	$0x64, %rax
               	addq	$0x2, %rax
               	cmpl	%eax, %ecx
               	jne	<addr>
               	movq	%rdi, %rdx
               	shlq	$0x3, %rdx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	imulq	$0xc, %rax, %r8
               	addq	%rsi, %r8
               	movq	%r8, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	shlq	$0x3, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	-0x1(%rdi), %rax
               	movslq	%eax, %rax
               	movq	(%rcx,%rax,8), %rcx
               	movl	0x8(%rcx), %ecx
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x64, %rax
               	addq	$0x2, %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x11, %eax
               	leave
               	retq

<main>:
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	0x4(%rbx), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	retq
               	leaq	0x2(%rbx), %rdi
               	popq	%rbx
               	jmp	<addr>
