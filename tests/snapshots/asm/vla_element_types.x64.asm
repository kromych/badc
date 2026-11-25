
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
               	movslq	<rip>, %r15 # <addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movslq	%eax, %r9
               	movl	<rip>, %eax # <addr>
               	decq	%rax
               	movslq	%eax, %rcx
               	movq	%r9, %r14
               	shlq	$0x2, %r14
               	movq	%r15, %rax
               	imulq	%r14, %rax
               	movq	%rax, -0x38(%rbp)
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
               	xorl	%r8d, %r8d
               	cmpl	%r15d, %r8d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	imulq	%r14, %rdx
               	addq	%r13, %rdx
               	imulq	$0xa, %r8, %rsi
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %eax
               	jge	<addr>
               	leaq	(%rsi,%rax), %rdi
               	movl	%edi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r8
               	nopw	(%rax,%rax)
               	cmpl	%r15d, %r8d
               	jl	<addr>
               	movq	%r9, %rax
               	shlq	$0x2, %rax
               	leaq	(%rax,%rax,2), %rdx
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x50(%rbp)
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
               	movq	%r10, -0x18(%rbp)
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	imulq	-0x30(%rbp), %rdx
               	movq	-0x18(%rbp), %rsi
               	addq	%rdx, %rsi
               	movq	%r8, %rdx
               	imulq	%r14, %rdx
               	leaq	(%r13,%rdx), %rdi
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movl	(%rdi,%rax,4), %edx
               	shlq	%rdx
               	movl	%edx, (%rsi,%rax,4)
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	movq	%rcx, %rbx
               	shlq	$0x3, %rbx
               	movq	%r9, %rax
               	imulq	%rbx, %rax
               	movq	%r15, %rdx
               	imulq	%rax, %rdx
               	movq	%rax, -0x20(%rbp)
               	movq	%rdx, -0x48(%rbp)
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
               	xorl	%r12d, %r12d
               	cmpl	%r15d, %r12d
               	jge	<addr>
               	xorl	%r8d, %r8d
               	movq	%r12, %rax
               	imulq	-0x20(%rbp), %rax
               	movq	-0x28(%rbp), %r10
               	addq	%rax, %r10
               	imulq	$0x64, %r12, %r11
               	cmpl	%r9d, %r8d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	imulq	%rbx, %rdx
               	addq	%r10, %rdx
               	imulq	$0xa, %r8, %rsi
               	addq	%r11, %rsi
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	%r9d, %r8d
               	jl	<addr>
               	incq	%r12
               	cmpl	%r15d, %r12d
               	jl	<addr>
               	movq	%r9, %r10
               	shlq	$0x2, %r10
               	movq	%r15, %rax
               	imulq	%r10, %rax
               	movq	%r10, -0x70(%rbp)
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%rsp, %r11
               	subq	%r10, %r11
               	shrq	$0xc, %r10
               	testq	%r10, %r10
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r10
               	jne	<addr>
               	movq	%r11, %rsp
               	movq	-0x70(%rbp), %r10
               	movq	%r10, %rax
               	shlq	%rax
               	movq	%rax, -0x58(%rbp)
               	movq	%r10, -0x70(%rbp)
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%rsp, %r8
               	subq	%r10, %r8
               	shrq	$0xc, %r10
               	testq	%r10, %r10
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r10
               	jne	<addr>
               	movq	%r8, %rsp
               	movq	%r8, -0x40(%rbp)
               	movq	-0x70(%rbp), %r10
               	leaq	(%r10,%r10,2), %rax
               	xorl	%edx, %edx
               	divq	%r10
               	imulq	%r10, %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%r10, -0x70(%rbp)
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%rsp, %r12
               	subq	%r10, %r12
               	shrq	$0xc, %r10
               	testq	%r10, %r10
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r10
               	jne	<addr>
               	movq	%r12, %rsp
               	movq	-0x70(%rbp), %r10
               	xorl	%r8d, %r8d
               	cmpl	%r15d, %r8d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	imulq	%r10, %rdx
               	addq	%r11, %rdx
               	movq	%r8, %rsi
               	imulq	%r14, %rsi
               	addq	%r13, %rsi
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movl	(%rsi,%rax,4), %edi
               	negq	%rdi
               	movl	%edi, (%rdx,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	%r15d, %r8d
               	jl	<addr>
               	xorl	%r8d, %r8d
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	imulq	%r10, %rdx
               	addq	%r12, %rdx
               	movq	%r8, %rsi
               	imulq	%r14, %rsi
               	addq	%r13, %rsi
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movl	(%rsi,%rax,4), %edi
               	incq	%rdi
               	movl	%edi, (%rdx,%rax,4)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	movq	-0x40(%rbp), %rax
               	addq	%r10, %rax
               	leaq	-0x1(%r9), %rdx
               	movslq	%edx, %rdx
               	movl	$0x4d, (%rax,%rdx,4)
               	movq	%r9, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%r13,%rdx), %rsi
               	movq	%r15, %rax
               	imulq	%r9, %rax
               	shlq	$0x2, %rax
               	movq	%rax, %r8
               	movq	-0x38(%rbp), %rax
               	cmpq	%r8, %rax
               	jne	<addr>
               	movq	%r9, %rax
               	shlq	$0x2, %rax
               	cmpq	%rax, %r14
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
               	leaq	(%r9,%r9,2), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	movq	%rax, %r8
               	movq	-0x50(%rbp), %rax
               	cmpq	%r8, %rax
               	jne	<addr>
               	movq	%r15, %rax
               	imulq	%r9, %rax
               	imulq	%rcx, %rax
               	shlq	$0x3, %rax
               	movq	%rax, %r8
               	movq	-0x48(%rbp), %rax
               	cmpq	%r8, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	cmpq	%rax, %rbx
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
               	movq	%r9, %rax
               	shlq	%rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	movq	%rax, %r8
               	movq	-0x58(%rbp), %rax
               	cmpq	%r8, %rax
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
               	leaq	(%r9,%r9,2), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	movq	%rax, %r8
               	movq	-0x60(%rbp), %rax
               	cmpq	%r8, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	shlq	%rax
               	addq	%r13, %rax
               	movl	0xc(%rax), %eax
               	cmpl	$0x17, %eax
               	jne	<addr>
               	movq	-0x30(%rbp), %r8
               	shlq	%r8
               	movq	%r8, -0x30(%rbp)
               	movq	-0x18(%rbp), %rax
               	addq	-0x30(%rbp), %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	shlq	%rax
               	movq	%rax, %r8
               	movq	-0x28(%rbp), %rax
               	addq	%r8, %rax
               	leaq	(%rbx,%rbx,2), %rdi
               	addq	%rdi, %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0xe7, %rax
               	jne	<addr>
               	leaq	(%rsi,%rdx), %rax
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
               	leaq	(%r11,%r10), %rax
               	movl	0x4(%rax), %eax
               	cmpl	$-0xb, %eax
               	jne	<addr>
               	shlq	%r10
               	leaq	(%r12,%r10), %rax
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
               	leaq	(%r13,%r14), %rax
               	addq	$0x8, %rax
               	subq	%r13, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rax
               	sarq	$0x2, %rax
               	leaq	0x2(%r9), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	-0x28(%rbp), %rdx
               	movq	%rdx, %rax
               	addq	-0x20(%rbp), %rax
               	subq	%rdx, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3d, %rdx
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
               	movq	%r9, %r10
               	shlq	$0x2, %r10
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	cmpl	%r15d, %esi
               	jge	<addr>
               	movq	%rsi, %rax
               	imulq	%r10, %rax
               	leaq	(%r13,%rax), %rdi
               	xorl	%eax, %eax
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movl	(%rdi,%rax,4), %r8d
               	addq	%r8, %rdx
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	incq	%rsi
               	nopl	(%rax,%rax)
               	cmpl	%r15d, %esi
               	jl	<addr>
               	cmpl	$0x8a, %edx
               	jne	<addr>
               	movq	%r9, %r10
               	shlq	$0x2, %r10
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	movq	%rsi, %rax
               	imulq	%r10, %rax
               	movq	-0x18(%rbp), %rdi
               	addq	%rax, %rdi
               	xorl	%eax, %eax
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movl	(%rdi,%rax,4), %r8d
               	addq	%r8, %rdx
               	incq	%rax
               	nopl	(%rax,%rax)
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
               	movq	%r15, %rdx
               	imulq	%rax, %rdx
               	cmpq	-0x38(%rbp), %rdx
               	jne	<addr>
               	shlq	%rax
               	addq	%r13, %rax
               	movl	0xc(%rax), %eax
               	cmpl	$0x17, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	imulq	%r9, %rax
               	imulq	%r15, %rax
               	cmpq	-0x48(%rbp), %rax
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
