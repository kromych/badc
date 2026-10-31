
vla_element_types.x64:	file format elf64-x86-64

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
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %r10
               	movq	%r10, -0x40(%rbp)
               	movl	(%rax), %ecx
               	incq	%rcx
               	movslq	%ecx, %r14
               	movl	(%rax), %eax
               	decq	%rax
               	movslq	%eax, %rsi
               	movq	%r14, %r10
               	shlq	$0x2, %r10
               	movq	%r10, -0x18(%rbp)
               	movq	-0x40(%rbp), %r10
               	imulq	-0x18(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	-0x48(%rbp), %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r15
               	subq	%r11, %r15
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r15, %rsp
               	xorl	%ecx, %ecx
               	cmpl	-0x40(%rbp), %ecx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	%r14d, %eax
               	jge	<addr>
               	movq	%rcx, %rdx
               	imulq	-0x18(%rbp), %rdx
               	addq	%r15, %rdx
               	imulq	$0xa, %rcx, %rdi
               	addq	%rax, %rdi
               	movl	%edi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	%r14d, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	-0x40(%rbp), %ecx
               	jl	<addr>
               	movq	%r14, %r10
               	shlq	$0x2, %r10
               	movq	%r10, -0x28(%rbp)
               	movq	-0x28(%rbp), %r10
               	leaq	(%r10,%r10,2), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r10
               	subq	%r11, %r10
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r10, %rsp
               	movq	%r10, -0x20(%rbp)
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	cmpl	%r14d, %eax
               	jge	<addr>
               	movq	%rcx, %rdx
               	imulq	-0x28(%rbp), %rdx
               	movq	-0x20(%rbp), %rdi
               	addq	%rdx, %rdi
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rdi
               	movq	%rcx, %r8
               	imulq	-0x18(%rbp), %r8
               	addq	%r15, %r8
               	addq	%r8, %rdx
               	movl	(%rdx), %edx
               	shlq	%rdx
               	movl	%edx, (%rdi)
               	incq	%rax
               	cmpl	%r14d, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	movq	%rsi, %rdi
               	shlq	$0x3, %rdi
               	movq	%r14, %r8
               	imulq	%rdi, %r8
               	movq	-0x40(%rbp), %r10
               	imulq	%r8, %r10
               	movq	%r10, -0x50(%rbp)
               	movq	-0x50(%rbp), %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r9
               	subq	%r11, %r9
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r9, %rsp
               	xorl	%edx, %edx
               	cmpl	-0x40(%rbp), %edx
               	jge	<addr>
               	xorl	%ecx, %ecx
               	cmpl	%r14d, %ecx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	%rdx, %rbx
               	imulq	%r8, %rbx
               	addq	%r9, %rbx
               	movq	%rcx, %r12
               	imulq	%rdi, %r12
               	addq	%r12, %rbx
               	imulq	$0x64, %rdx, %r12
               	imulq	$0xa, %rcx, %r13
               	addq	%r13, %r12
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movq	%r12, (%rbx,%rax,8)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r14d, %ecx
               	jl	<addr>
               	incq	%rdx
               	cmpl	-0x40(%rbp), %edx
               	jl	<addr>
               	movq	%r14, %rdx
               	shlq	$0x2, %rdx
               	movq	-0x40(%rbp), %rax
               	imulq	%rdx, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r12
               	subq	%r11, %r12
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r12, %rsp
               	movq	%rdx, %r10
               	shlq	%r10
               	movq	%r10, -0x60(%rbp)
               	movq	-0x60(%rbp), %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r10
               	subq	%r11, %r10
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r10, %rsp
               	movq	%r10, -0x70(%rbp)
               	leaq	(%rdx,%rdx,2), %rax
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorl	%edx, %edx
               	divq	%r10
               	popq	%rdx
               	movq	%rax, %r10
               	imulq	%rdx, %r10
               	movq	%r10, -0x68(%rbp)
               	movq	-0x68(%rbp), %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r13
               	subq	%r11, %r13
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r13, %rsp
               	xorl	%ecx, %ecx
               	cmpl	-0x40(%rbp), %ecx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	%r14d, %eax
               	jge	<addr>
               	movq	%rcx, %rbx
               	imulq	%rdx, %rbx
               	leaq	(%r12,%rbx), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	%rax, %rbx
               	shlq	$0x2, %rbx
               	movq	-0x30(%rbp), %r10
               	addq	%rbx, %r10
               	movq	%r10, -0x30(%rbp)
               	movq	%rcx, %r10
               	imulq	-0x18(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	%r15, %r10
               	addq	-0x38(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	%rbx, %r10
               	movq	-0x38(%rbp), %rbx
               	addq	%r10, %rbx
               	movl	(%rbx), %ebx
               	negq	%rbx
               	movq	-0x30(%rbp), %r10
               	movl	%ebx, (%r10)
               	incq	%rax
               	cmpl	%r14d, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	-0x40(%rbp), %ecx
               	jl	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	cmpl	%r14d, %eax
               	jge	<addr>
               	movq	%rcx, %rbx
               	imulq	%rdx, %rbx
               	leaq	(%r13,%rbx), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	%rax, %rbx
               	shlq	$0x2, %rbx
               	movq	-0x30(%rbp), %r10
               	addq	%rbx, %r10
               	movq	%r10, -0x30(%rbp)
               	movq	%rcx, %r10
               	imulq	-0x18(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	%r15, %r10
               	addq	-0x38(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	%rbx, %r10
               	movq	-0x38(%rbp), %rbx
               	addq	%r10, %rbx
               	movl	(%rbx), %ebx
               	incq	%rbx
               	movq	-0x30(%rbp), %r10
               	movl	%ebx, (%r10)
               	incq	%rax
               	cmpl	%r14d, %eax
               	jl	<addr>
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	movq	-0x70(%rbp), %rax
               	addq	%rdx, %rax
               	leaq	-0x1(%r14), %rcx
               	movslq	%ecx, %rcx
               	movl	$0x4d, (%rax,%rcx,4)
               	movq	%r14, %rax
               	shlq	$0x2, %rax
               	leaq	(%r15,%rax), %rcx
               	movq	-0x40(%rbp), %rbx
               	imulq	%r14, %rbx
               	shlq	$0x2, %rbx
               	movq	%rbx, %r10
               	movq	-0x48(%rbp), %rbx
               	cmpq	%r10, %rbx
               	jne	<addr>
               	movq	%r14, %rbx
               	shlq	$0x2, %rbx
               	movq	%rbx, %r10
               	movq	-0x18(%rbp), %rbx
               	cmpq	%r10, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	(%r14,%r14,2), %rbx
               	movslq	%ebx, %rbx
               	shlq	$0x2, %rbx
               	movq	%rbx, %r10
               	movq	-0x58(%rbp), %rbx
               	cmpq	%r10, %rbx
               	jne	<addr>
               	movq	-0x40(%rbp), %rbx
               	imulq	%r14, %rbx
               	imulq	%rsi, %rbx
               	shlq	$0x3, %rbx
               	movq	%rbx, %r10
               	movq	-0x50(%rbp), %rbx
               	cmpq	%r10, %rbx
               	jne	<addr>
               	movq	%rsi, %rbx
               	shlq	$0x3, %rbx
               	cmpq	%rbx, %rdi
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r14, %rbx
               	shlq	%rbx
               	movslq	%ebx, %rbx
               	shlq	$0x2, %rbx
               	movq	%rbx, %r10
               	movq	-0x60(%rbp), %rbx
               	cmpq	%r10, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	(%r14,%r14,2), %rbx
               	movslq	%ebx, %rbx
               	shlq	$0x2, %rbx
               	movq	%rbx, %r10
               	movq	-0x68(%rbp), %rbx
               	cmpq	%r10, %rbx
               	jne	<addr>
               	movq	-0x18(%rbp), %rbx
               	shlq	%rbx
               	addq	%r15, %rbx
               	movl	0xc(%rbx), %ebx
               	cmpl	$0x17, %ebx
               	jne	<addr>
               	movq	-0x28(%rbp), %rbx
               	shlq	%rbx
               	movq	%rbx, %r10
               	movq	-0x20(%rbp), %rbx
               	addq	%r10, %rbx
               	movl	0x4(%rbx), %ebx
               	cmpl	$0x2a, %ebx
               	jne	<addr>
               	movq	%r8, %rbx
               	shlq	%rbx
               	addq	%r9, %rbx
               	leaq	(%rdi,%rdi,2), %rdi
               	addq	%rbx, %rdi
               	movq	0x8(%rdi), %rdi
               	cmpq	$0xe7, %rdi
               	jne	<addr>
               	addq	%rcx, %rax
               	movl	0x8(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	(%r12,%rdx), %rax
               	movl	0x4(%rax), %eax
               	cmpl	$-0xb, %eax
               	jne	<addr>
               	shlq	%rdx
               	leaq	(%r13,%rdx), %rax
               	movl	0xc(%rax), %eax
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r15, %rax
               	addq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	subq	%r15, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	leaq	0x2(%r14), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	(%r9,%r8), %rax
               	subq	%r9, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	sarq	$0x3, %rax
               	movq	%r14, %rcx
               	imulq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r14, %rdi
               	shlq	$0x2, %rdi
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	cmpl	-0x40(%rbp), %edx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	%r14d, %eax
               	jge	<addr>
               	movq	%rdx, %r8
               	imulq	%rdi, %r8
               	addq	%r15, %r8
               	movl	(%r8,%rax,4), %r8d
               	addq	%r8, %rcx
               	incq	%rax
               	cmpl	%r14d, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	-0x40(%rbp), %edx
               	jl	<addr>
               	cmpl	$0x8a, %ecx
               	jne	<addr>
               	movq	%r14, %rdi
               	shlq	$0x2, %rdi
               	xorl	%edx, %edx
               	movq	%rdx, %rcx
               	xorl	%eax, %eax
               	cmpl	%r14d, %eax
               	jge	<addr>
               	movq	%rdx, %r8
               	imulq	%rdi, %r8
               	movq	%r8, %r10
               	movq	-0x20(%rbp), %r8
               	addq	%r10, %r8
               	movl	(%r8,%rax,4), %r8d
               	addq	%r8, %rcx
               	incq	%rax
               	cmpl	%r14d, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x3, %edx
               	jl	<addr>
               	cmpl	$0x114, %ecx            # imm = 0x114
               	je	<addr>
               	movl	$0x9, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r14, %rax
               	shlq	$0x2, %rax
               	movq	-0x40(%rbp), %rcx
               	movq	%rcx, %rdx
               	imulq	%rax, %rdx
               	cmpq	-0x48(%rbp), %rdx
               	jne	<addr>
               	shlq	%rax
               	addq	%r15, %rax
               	movl	0xc(%rax), %eax
               	cmpl	$0x17, %eax
               	jne	<addr>
               	movq	%rsi, %rax
               	shlq	$0x3, %rax
               	imulq	%r14, %rax
               	imulq	%rcx, %rax
               	cmpq	-0x50(%rbp), %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xa, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x5, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
