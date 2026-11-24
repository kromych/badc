
vla_element_types.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movslq	%ecx, %r9
               	movl	<rip>, %ecx # <addr>
               	decq	%rcx
               	movslq	%ecx, %rcx
               	movq	%r9, %rdx
               	shlq	$0x2, %rdx
               	movq	%rax, %rsi
               	imulq	%rdx, %rsi
               	movq	%rax, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rsi, %r11
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
               	xorl	%r8d, %r8d
               	cmpl	-0x20(%rbp), %r8d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	imulq	-0x18(%rbp), %rdx
               	addq	%r15, %rdx
               	imulq	$0xa, %r8, %rsi
               	cmpl	%r9d, %eax
               	jge	<addr>
               	leaq	(%rsi,%rax), %rdi
               	movl	%edi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r8
               	nopl	(%rax,%rax)
               	cmpl	-0x20(%rbp), %r8d
               	jl	<addr>
               	movq	%r9, %rax
               	shlq	$0x2, %rax
               	leaq	(%rax,%rax,2), %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rdx, %r11
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
               	movq	%r10, -0x28(%rbp)
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	imulq	-0x40(%rbp), %rdx
               	movq	%rdx, %r10
               	movq	-0x28(%rbp), %rdx
               	addq	%r10, %rdx
               	movq	%r8, %rsi
               	imulq	-0x18(%rbp), %rsi
               	addq	%r15, %rsi
               	nopl	(%rax)
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movl	(%rsi,%rax,4), %edi
               	shlq	%rdi
               	movl	%edi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r8
               	nopl	(%rax)
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	movq	%rcx, %rbx
               	shlq	$0x3, %rbx
               	movq	%r9, %rax
               	imulq	%rbx, %rax
               	movq	-0x20(%rbp), %rdx
               	imulq	%rax, %rdx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	%rdx, %r11
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
               	movq	%r10, -0x38(%rbp)
               	xorl	%r14d, %r14d
               	cmpl	-0x20(%rbp), %r14d
               	jge	<addr>
               	xorl	%r8d, %r8d
               	movq	%r14, %rax
               	imulq	-0x30(%rbp), %rax
               	movq	-0x38(%rbp), %r12
               	addq	%rax, %r12
               	imulq	$0x64, %r14, %r13
               	cmpl	%r9d, %r8d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	imulq	%rbx, %rdx
               	addq	%r12, %rdx
               	imulq	$0xa, %r8, %rsi
               	addq	%r13, %rsi
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	incq	%r8
               	nopl	(%rax)
               	cmpl	%r9d, %r8d
               	jl	<addr>
               	incq	%r14
               	cmpl	-0x20(%rbp), %r14d
               	jl	<addr>
               	movq	%r9, %r12
               	shlq	$0x2, %r12
               	movq	-0x20(%rbp), %rax
               	imulq	%r12, %rax
               	movq	%rax, %r11
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
               	movq	%r12, %rax
               	shlq	%rax
               	movq	%rax, -0x68(%rbp)
               	movq	%rax, %r11
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
               	movq	%r10, -0x50(%rbp)
               	leaq	(%r12,%r12,2), %rax
               	xorl	%edx, %edx
               	divq	%r12
               	imulq	%r12, %rax
               	movq	%rax, -0x70(%rbp)
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r14
               	subq	%r11, %r14
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r14, %rsp
               	xorl	%r8d, %r8d
               	cmpl	-0x20(%rbp), %r8d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	imulq	%r12, %rdx
               	addq	%r13, %rdx
               	movq	%r8, %rsi
               	imulq	-0x18(%rbp), %rsi
               	addq	%r15, %rsi
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movl	(%rsi,%rax,4), %edi
               	negq	%rdi
               	movl	%edi, (%rdx,%rax,4)
               	incq	%rax
               	nop
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	-0x20(%rbp), %r8d
               	jl	<addr>
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	imulq	%r12, %rdx
               	addq	%r14, %rdx
               	movq	%r8, %rsi
               	imulq	-0x18(%rbp), %rsi
               	addq	%r15, %rsi
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movl	(%rsi,%rax,4), %edi
               	incq	%rdi
               	movl	%edi, (%rdx,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	movq	-0x50(%rbp), %rax
               	addq	%r12, %rax
               	leaq	-0x1(%r9), %rdx
               	movslq	%edx, %rdx
               	movl	$0x4d, (%rax,%rdx,4)
               	movq	%r9, %rax
               	shlq	$0x2, %rax
               	leaq	(%r15,%rax), %rsi
               	movq	-0x20(%rbp), %rdx
               	imulq	%r9, %rdx
               	shlq	$0x2, %rdx
               	movq	%rdx, %r10
               	movq	-0x48(%rbp), %rdx
               	cmpq	%r10, %rdx
               	jne	<addr>
               	movq	%r9, %rdx
               	shlq	$0x2, %rdx
               	movq	%rdx, %r10
               	movq	-0x18(%rbp), %rdx
               	cmpq	%r10, %rdx
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
               	leaq	(%r9,%r9,2), %rdx
               	movslq	%edx, %rdx
               	shlq	$0x2, %rdx
               	movq	%rdx, %r10
               	movq	-0x60(%rbp), %rdx
               	cmpq	%r10, %rdx
               	jne	<addr>
               	movq	-0x20(%rbp), %rdx
               	imulq	%r9, %rdx
               	imulq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	movq	%rdx, %r10
               	movq	-0x58(%rbp), %rdx
               	cmpq	%r10, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	cmpq	%rdx, %rbx
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
               	movq	%r9, %rdx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	shlq	$0x2, %rdx
               	movq	%rdx, %r10
               	movq	-0x68(%rbp), %rdx
               	cmpq	%r10, %rdx
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
               	leaq	(%r9,%r9,2), %rdx
               	movslq	%edx, %rdx
               	shlq	$0x2, %rdx
               	movq	%rdx, %r10
               	movq	-0x70(%rbp), %rdx
               	cmpq	%r10, %rdx
               	jne	<addr>
               	movq	-0x18(%rbp), %rdx
               	shlq	%rdx
               	addq	%r15, %rdx
               	movl	0xc(%rdx), %edx
               	cmpl	$0x17, %edx
               	jne	<addr>
               	movq	-0x40(%rbp), %rdx
               	shlq	%rdx
               	movq	%rdx, %r10
               	movq	-0x28(%rbp), %rdx
               	addq	%r10, %rdx
               	movl	0x4(%rdx), %edx
               	cmpl	$0x2a, %edx
               	jne	<addr>
               	movq	-0x30(%rbp), %rdx
               	shlq	%rdx
               	movq	%rdx, %r10
               	movq	-0x38(%rbp), %rdx
               	addq	%r10, %rdx
               	leaq	(%rbx,%rbx,2), %rdi
               	addq	%rdi, %rdx
               	movq	0x8(%rdx), %rdx
               	cmpq	$0xe7, %rdx
               	jne	<addr>
               	addq	%rsi, %rax
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
               	leaq	(%r13,%r12), %rax
               	movl	0x4(%rax), %eax
               	cmpl	$-0xb, %eax
               	jne	<addr>
               	shlq	%r12
               	leaq	(%r14,%r12), %rax
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
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rax
               	sarq	$0x2, %rax
               	leaq	0x2(%r9), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rdx
               	addq	-0x30(%rbp), %rdx
               	subq	%rax, %rdx
               	movq	%rdx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3d, %rax
               	addq	%rdx, %rax
               	sarq	$0x3, %rax
               	movq	%r9, %rdx
               	imulq	%rcx, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
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
               	movq	%r9, %rbx
               	shlq	$0x2, %rbx
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	cmpl	-0x20(%rbp), %esi
               	jge	<addr>
               	movq	%rsi, %rax
               	imulq	%rbx, %rax
               	leaq	(%r15,%rax), %rdi
               	xorl	%eax, %eax
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movl	(%rdi,%rax,4), %r8d
               	addq	%r8, %rdx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	-0x20(%rbp), %esi
               	jl	<addr>
               	cmpl	$0x8a, %edx
               	jne	<addr>
               	movq	%r9, %rbx
               	shlq	$0x2, %rbx
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	movq	%rsi, %rax
               	imulq	%rbx, %rax
               	movq	-0x28(%rbp), %rdi
               	addq	%rax, %rdi
               	xorl	%eax, %eax
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movl	(%rdi,%rax,4), %r8d
               	addq	%r8, %rdx
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%rsi
               	cmpl	$0x3, %esi
               	jl	<addr>
               	cmpl	$0x114, %edx            # imm = 0x114
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
               	movq	%r9, %rax
               	shlq	$0x2, %rax
               	movq	-0x20(%rbp), %rdx
               	movq	%rdx, %rsi
               	imulq	%rax, %rsi
               	cmpq	-0x48(%rbp), %rsi
               	jne	<addr>
               	shlq	%rax
               	addq	%r15, %rax
               	movl	0xc(%rax), %eax
               	cmpl	$0x17, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	imulq	%r9, %rax
               	imulq	%rdx, %rax
               	cmpq	-0x58(%rbp), %rax
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
