
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
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	<rip>, %r10 # <addr>
               	movq	%r10, -0x18(%rbp)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movslq	%eax, %r8
               	movl	<rip>, %eax # <addr>
               	decq	%rax
               	movslq	%eax, %rcx
               	movq	%r8, %r10
               	shlq	$0x2, %r10
               	movq	%r10, -0x20(%rbp)
               	movq	-0x18(%rbp), %r10
               	imulq	-0x20(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	%r10, %r11
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
               	xorl	%r9d, %r9d
               	cmpl	-0x18(%rbp), %r9d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r9, %rdx
               	imulq	-0x20(%rbp), %rdx
               	addq	%r15, %rdx
               	imulq	$0xa, %r9, %rsi
               	cmpl	%r8d, %eax
               	jge	<addr>
               	leaq	(%rsi,%rax), %rdi
               	movl	%edi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	-0x18(%rbp), %r9d
               	jl	<addr>
               	movq	%r8, %r10
               	shlq	$0x2, %r10
               	movq	%r10, -0x38(%rbp)
               	leaq	(%r10,%r10,2), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	%r10, %r11
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
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	movq	%rbx, %rdx
               	imulq	-0x38(%rbp), %rdx
               	movq	-0x28(%rbp), %rsi
               	addq	%rdx, %rsi
               	movq	%rbx, %rdx
               	imulq	-0x20(%rbp), %rdx
               	leaq	(%r15,%rdx), %rdi
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %r9
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	shlq	%rdx
               	movl	%edx, (%r9)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	movq	%rcx, %rbx
               	shlq	$0x3, %rbx
               	movq	%r8, %r10
               	imulq	%rbx, %r10
               	movq	%r10, -0x30(%rbp)
               	movq	-0x18(%rbp), %r10
               	imulq	-0x30(%rbp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	%r10, %r11
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
               	movq	%r10, -0x40(%rbp)
               	xorl	%r14d, %r14d
               	cmpl	-0x18(%rbp), %r14d
               	jge	<addr>
               	xorl	%r9d, %r9d
               	movq	%r14, %rax
               	imulq	-0x30(%rbp), %rax
               	movq	-0x40(%rbp), %r12
               	addq	%rax, %r12
               	imulq	$0x64, %r14, %r13
               	cmpl	%r8d, %r9d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r9, %rdx
               	imulq	%rbx, %rdx
               	addq	%r12, %rdx
               	imulq	$0xa, %r9, %rsi
               	addq	%r13, %rsi
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	%r8d, %r9d
               	jl	<addr>
               	incq	%r14
               	cmpl	-0x18(%rbp), %r14d
               	jl	<addr>
               	movq	%r8, %r13
               	shlq	$0x2, %r13
               	movq	-0x18(%rbp), %rax
               	imulq	%r13, %rax
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
               	movq	%r13, %r10
               	shlq	%r10
               	movq	%r10, -0x68(%rbp)
               	movq	%r10, %r11
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
               	movq	%r10, -0x78(%rbp)
               	leaq	(%r13,%r13,2), %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%rax, %r10
               	imulq	%r13, %r10
               	movq	%r10, -0x70(%rbp)
               	movq	%r10, %r11
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
               	movq	%r10, -0x48(%rbp)
               	xorl	%r12d, %r12d
               	cmpl	-0x18(%rbp), %r12d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r12, %rdx
               	imulq	%r13, %rdx
               	leaq	(%r14,%rdx), %rsi
               	movq	%r12, %rdx
               	imulq	-0x20(%rbp), %rdx
               	leaq	(%r15,%rdx), %rdi
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %r9
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	negq	%rdx
               	movl	%edx, (%r9)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	incq	%r12
               	cmpl	-0x18(%rbp), %r12d
               	jl	<addr>
               	xorl	%r12d, %r12d
               	xorl	%eax, %eax
               	movq	%r12, %rdx
               	imulq	%r13, %rdx
               	movq	-0x48(%rbp), %rsi
               	addq	%rdx, %rsi
               	movq	%r12, %rdx
               	imulq	-0x20(%rbp), %rdx
               	leaq	(%r15,%rdx), %rdi
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %r9
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	incq	%rdx
               	movl	%edx, (%r9)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x3, %r12d
               	jl	<addr>
               	movq	-0x78(%rbp), %rax
               	addq	%r13, %rax
               	leaq	-0x1(%r8), %rdx
               	movslq	%edx, %rdx
               	movl	$0x4d, (%rax,%rdx,4)
               	movq	%r8, %rax
               	shlq	$0x2, %rax
               	leaq	(%r15,%rax), %rdx
               	movq	-0x18(%rbp), %rsi
               	imulq	%r8, %rsi
               	shlq	$0x2, %rsi
               	movq	%rsi, %r10
               	movq	-0x50(%rbp), %rsi
               	cmpq	%r10, %rsi
               	jne	<addr>
               	movq	%r8, %rsi
               	shlq	$0x2, %rsi
               	movq	%rsi, %r10
               	movq	-0x20(%rbp), %rsi
               	cmpq	%r10, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	(%r8,%r8,2), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x2, %rsi
               	movq	%rsi, %r10
               	movq	-0x60(%rbp), %rsi
               	cmpq	%r10, %rsi
               	jne	<addr>
               	movq	-0x18(%rbp), %rsi
               	imulq	%r8, %rsi
               	imulq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	movq	%rsi, %r10
               	movq	-0x58(%rbp), %rsi
               	cmpq	%r10, %rsi
               	jne	<addr>
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	cmpq	%rsi, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r8, %rsi
               	shlq	%rsi
               	movslq	%esi, %rsi
               	shlq	$0x2, %rsi
               	movq	%rsi, %r10
               	movq	-0x68(%rbp), %rsi
               	cmpq	%r10, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	(%r8,%r8,2), %rsi
               	movslq	%esi, %rsi
               	shlq	$0x2, %rsi
               	movq	%rsi, %r10
               	movq	-0x70(%rbp), %rsi
               	cmpq	%r10, %rsi
               	jne	<addr>
               	movq	-0x20(%rbp), %rsi
               	shlq	%rsi
               	addq	%r15, %rsi
               	movl	0xc(%rsi), %esi
               	cmpl	$0x17, %esi
               	jne	<addr>
               	movq	-0x38(%rbp), %rsi
               	shlq	%rsi
               	movq	%rsi, %r10
               	movq	-0x28(%rbp), %rsi
               	addq	%r10, %rsi
               	movl	0x4(%rsi), %esi
               	cmpl	$0x2a, %esi
               	jne	<addr>
               	movq	-0x30(%rbp), %rsi
               	shlq	%rsi
               	movq	%rsi, %r10
               	movq	-0x40(%rbp), %rsi
               	addq	%r10, %rsi
               	leaq	(%rbx,%rbx,2), %rdi
               	addq	%rdi, %rsi
               	movq	0x8(%rsi), %rsi
               	cmpq	$0xe7, %rsi
               	jne	<addr>
               	addq	%rdx, %rax
               	movl	0x8(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	(%r14,%r13), %rax
               	movl	0x4(%rax), %eax
               	cmpl	$-0xb, %eax
               	jne	<addr>
               	shlq	%r13
               	movq	-0x48(%rbp), %rax
               	addq	%r13, %rax
               	movl	0xc(%rax), %eax
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r15, %rax
               	addq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	subq	%r15, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rax
               	sarq	$0x2, %rax
               	leaq	0x2(%r8), %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	movq	%rax, %rdx
               	addq	-0x30(%rbp), %rdx
               	subq	%rax, %rdx
               	movq	%rdx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3d, %rax
               	addq	%rdx, %rax
               	sarq	$0x3, %rax
               	movq	%r8, %rdx
               	imulq	%rcx, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r8, %rbx
               	shlq	$0x2, %rbx
               	xorl	%r9d, %r9d
               	movq	%r9, %rdx
               	cmpl	-0x18(%rbp), %r9d
               	jge	<addr>
               	movq	%r9, %rax
               	imulq	%rbx, %rax
               	leaq	(%r15,%rax), %rsi
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movl	(%rsi,%rax,4), %edi
               	addq	%rdi, %rdx
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	-0x18(%rbp), %r9d
               	jl	<addr>
               	cmpl	$0x8a, %edx
               	jne	<addr>
               	movq	%r8, %rbx
               	shlq	$0x2, %rbx
               	xorl	%r9d, %r9d
               	movq	%r9, %rdx
               	movq	%r9, %rax
               	imulq	%rbx, %rax
               	movq	-0x28(%rbp), %rsi
               	addq	%rax, %rsi
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movl	(%rsi,%rax,4), %edi
               	addq	%rdi, %rdx
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x3, %r9d
               	jl	<addr>
               	cmpl	$0x114, %edx            # imm = 0x114
               	je	<addr>
               	movl	$0x9, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r8, %rax
               	shlq	$0x2, %rax
               	movq	-0x18(%rbp), %rdx
               	movq	%rdx, %rsi
               	imulq	%rax, %rsi
               	cmpq	-0x50(%rbp), %rsi
               	jne	<addr>
               	shlq	%rax
               	addq	%r15, %rax
               	movl	0xc(%rax), %eax
               	cmpl	$0x17, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	imulq	%r8, %rax
               	imulq	%rdx, %rax
               	cmpq	-0x58(%rbp), %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xa, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x5, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
