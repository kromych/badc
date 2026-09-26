
vla_array_type.x64:	file format elf64-x86-64

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
               	cmpl	%edi, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movslq	0x4(%rcx), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movslq	0x8(%rcx), %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	leaq	(%rcx,%rsi), %r8
               	movq	%r8, %rax
               	subq	%rcx, %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	cqto
               	idivq	%rsi
               	cmpq	$0x1, %rax
               	jne	<addr>
               	cmpq	%r8, %r8
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movslq	0xc(%rcx), %rax
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	movq	%r8, %rax
               	subq	%rsi, %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rax
               	subq	%rdx, %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	0x4(%rax), %rdx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	leaq	-0x1(%rdi), %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	imulq	$0xa, %rcx, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movl	$0x8, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movl	$0x5, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<two_dim>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rdi
               	imulq	$0xc, %rdi, %r12
               	movq	%r12, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	imulq	$0xc, %rdi, %r13
               	movq	%r13, %r11
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
               	imulq	$0xc, %rax, %rsi
               	leaq	(%rdx,%rsi), %r9
               	leaq	(%rax,%rax,2), %r8
               	movl	%r8d, (%r9)
               	leaq	(%rcx,%rsi), %r9
               	addq	$0x64, %r8
               	movl	%r8d, (%r9)
               	leaq	(%rdx,%rsi), %r8
               	leaq	(%rax,%rax,2), %rsi
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, 0x4(%r8)
               	imulq	$0xc, %rax, %r8
               	leaq	(%rcx,%r8), %r9
               	leaq	0x64(%rsi), %rbx
               	incq	%rbx
               	movl	%ebx, 0x4(%r9)
               	addq	%rdx, %r8
               	addq	$0x2, %rsi
               	movl	%esi, 0x8(%r8)
               	imulq	$0xc, %rax, %rsi
               	addq	%rcx, %rsi
               	leaq	(%rax,%rax,2), %r8
               	addq	$0x64, %r8
               	addq	$0x2, %r8
               	movl	%r8d, 0x8(%rsi)
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	cmpq	%rax, %r12
               	jne	<addr>
               	cmpq	%r12, %r13
               	je	<addr>
               	movl	$0xb, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movslq	0x14(%rdx), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movslq	0x14(%rcx), %rax
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0x14(%rdx), %rax
               	subq	%rdx, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x1(%rdi), %rax
               	movslq	%eax, %rax
               	imulq	$0xc, %rax, %rsi
               	leaq	(%rdx,%rsi), %r8
               	movslq	(%r8), %r8
               	leaq	(%rax,%rax,2), %rax
               	cmpl	%eax, %r8d
               	je	<addr>
               	movl	$0xf, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	0xc(%rdx), %r8
               	subq	%rdx, %r8
               	cmpq	$0xc, %r8
               	je	<addr>
               	movl	$0x10, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	(%rcx,%rsi), %rdx
               	movslq	0x8(%rdx), %rdx
               	addq	$0x64, %rax
               	addq	$0x2, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movq	%rdi, %r8
               	shlq	$0x3, %r8
               	movq	%r8, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	imulq	$0xc, %rax, %rsi
               	addq	%rcx, %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	movq	%rdi, %rax
               	shlq	$0x3, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	-0x1(%rdi), %rax
               	movslq	%eax, %rax
               	movq	(%rdx,%rax,8), %rcx
               	movslq	0x8(%rcx), %rcx
               	leaq	(%rax,%rax,2), %rax
               	addq	$0x64, %rax
               	addq	$0x2, %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x11, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	0x4(%rbx), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	leaq	0x2(%rbx), %rdi
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq
