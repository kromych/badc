
align16_arg_abi.x64:	file format elf64-x86-64

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

<mk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %rbx
               	movq	%rdi, %r12
               	sarq	$0x3f, %r12
               	xorl	%eax, %eax
               	movq	%rdi, %rcx
               	imulq	%rax, %rcx
               	movl	%edi, %edx
               	movq	%rdi, %r8
               	shrq	$0x20, %r8
               	xorl	%r9d, %r9d
               	xorl	%esi, %esi
               	movq	%rdx, %r13
               	imulq	%r9, %r13
               	shrq	$0x20, %r13
               	imulq	%r8, %r9
               	addq	%r13, %r9
               	movl	%r9d, %r13d
               	shrq	$0x20, %r9
               	imulq	%rsi, %rdx
               	addq	%r13, %rdx
               	shrq	$0x20, %rdx
               	imulq	%r8, %rsi
               	addq	%r9, %rsi
               	addq	%rsi, %rdx
               	imulq	%r12, %rax
               	addq	%rdi, %rdx
               	addq	%rdx, %rax
               	leaq	(%rcx,%rbx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%rax, %rcx
               	leaq	-0x60(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rax, %rcx
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<after_one>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rdx, %rax
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	testq	%rdi, %rdi
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<after_five>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rbx, %rax
               	imulq	$0x7, %r9, %r9
               	addq	%r9, %rax
               	addq	%rdi, %rax
               	shlq	%rsi
               	addq	%rsi, %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<after_seven>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rbx, %rax
               	movq	0x30(%rbp), %rbx
               	imulq	$0x7, %rbx, %rbx
               	addq	%rbx, %rax
               	addq	%rdi, %rax
               	shlq	%rsi
               	addq	%rsi, %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r9, %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rbp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<after_double>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rdx, %rax
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	(%rdi,%rdi,2), %rcx
               	addq	%rcx, %rax
               	cvttsd2si	%xmm0, %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<twice>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	leaq	-0x30(%rbp), %rdx
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %r12
               	xorl	%edx, %edx
               	movq	%rax, %rsi
               	shlq	%rsi
               	movl	%eax, %r8d
               	movq	%rax, %r9
               	shrq	$0x20, %r9
               	movq	%r8, %rbx
               	shlq	%rbx
               	shrq	$0x20, %rbx
               	movq	%r9, %r13
               	shlq	%r13
               	addq	%r13, %rbx
               	movl	%ebx, %r13d
               	shrq	$0x20, %rbx
               	imulq	%rdx, %r8
               	addq	%r13, %r8
               	shrq	$0x20, %r8
               	imulq	%rdx, %r9
               	addq	%rbx, %r9
               	addq	%r9, %r8
               	imulq	%rdx, %rax
               	movq	%r12, %rdx
               	shlq	%rdx
               	addq	%r8, %rax
               	addq	%rax, %rdx
               	movq	%rdi, %r8
               	sarq	$0x3f, %r8
               	leaq	(%rsi,%rdi), %rax
               	cmpq	%rsi, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	addq	%r8, %rdx
               	addq	%rsi, %rdx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	addq	%rax, %rcx
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	addq	%rsi, %rdx
               	addq	%rax, %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rax, %rcx
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<wrapped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rdx, %rax
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	(%rdi,%rdi,2), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<member_aligned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	movq	(%rax), %rax
               	addq	%rdx, %rax
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	(%rdi,%rdi,2), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<whole_aligned>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	movq	(%rax), %rax
               	addq	%rdx, %rax
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	(%rdi,%rdi,2), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<whole_on_stack>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	movq	-0x20(%rbp), %rbx
               	addq	%rbx, %rax
               	movq	0x40(%rbp), %rbx
               	imulq	$0x7, %rbx, %rbx
               	addq	%rbx, %rax
               	movq	0x20(%rbp), %rbx
               	leaq	(%rbx,%rbx,2), %rbx
               	addq	%rbx, %rax
               	addq	%rdi, %rax
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<va_after>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	movq	%rax, %rcx
               	movslq	-0xd0(%rbp), %rdx
               	cmpl	%edx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movq	(%rdx), %rdx
               	incq	%rax
               	imulq	%rax, %rdx
               	addq	%rdx, %rcx
               	movslq	-0xd0(%rbp), %rdx
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x28, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rsi
               	movq	(%rsi), %rsi
               	leaq	-0x18(%rbp), %rdi
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	imulq	$0x7, %rsi, %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x168, %rsp            # imm = 0x168
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x5, %edi
               	movl	$0xb, %esi
               	callq	<addr>
               	movq	%rax, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x160(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	$-0x2, %rdi
               	movl	$0x28, %esi
               	callq	<addr>
               	movq	%rax, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	leaq	-0xb0(%rbp), %rcx
               	leaq	-0x150(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x160(%rbp), %rsi
               	movq	(%rsi), %rcx
               	movq	0x8(%rsi), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	addq	%rdx, %rcx
               	cmpq	$0x1393, %rcx           # imm = 0x1393
               	jne	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rcx, %rax
               	cmpq	$-0x7a8, %rax           # imm = 0xF858
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$0x13a9, %rax           # imm = 0x13A9
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	-0x150(%rbp), %rsi
               	movl	$0x4, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$-0x78c, %rax           # imm = 0xF874
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	leaq	-0x160(%rbp), %rax
               	subq	$0x10, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rdx, %r9
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x13df, %rax           # imm = 0x13DF
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5, %edi
               	movl	$0x4, %esi
               	movl	$0x3, %edx
               	movl	$0x2, %ecx
               	movl	$0x1, %r8d
               	leaq	-0x150(%rbp), %rax
               	movl	$0x6, %r9d
               	subq	$0x10, %rsp
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$-0x75b, %rax           # imm = 0xF8A5
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %eax
               	leaq	-0x160(%rbp), %rbx
               	subq	$0x30, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, 0x20(%rsp)
               	movq	%rbx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x30, %rsp
               	cmpq	$0x143b, %rax           # imm = 0x143B
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x1, %eax
               	leaq	-0x150(%rbp), %rcx
               	movl	$0x9, %edx
               	subq	$0x30, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdx, 0x20(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	addq	$0x30, %rsp
               	cmpq	$-0x761, %rax           # imm = 0xF89F
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movl	$0x1, %edi
               	leaq	-0x160(%rbp), %rsi
               	movl	$0x3, %ecx
               	movq	%rax, %xmm0
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$0x13ad, %rax           # imm = 0x13AD
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movabsq	$-0x4010000000000000, %rax # imm = 0xBFF0000000000000
               	movl	$0x4, %edi
               	leaq	-0x150(%rbp), %rsi
               	movl	$0x5, %ecx
               	movq	%rax, %xmm0
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$-0x77a, %rax           # imm = 0xF886
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0x160(%rbp), %rsi
               	movl	$0x2, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	leaq	-0xb0(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movl	$0xa, %edi
               	movl	$0x19, %esi
               	callq	<addr>
               	movq	%rax, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	leaq	-0xb0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	%rbx, %rcx
               	xorq	%r12, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x3, %rdi
               	leaq	-0x150(%rbp), %rsi
               	movl	$0x4, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	leaq	-0xb0(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	$-0x4, %rdi
               	movl	$0x51, %esi
               	callq	<addr>
               	movq	%rax, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	leaq	-0xb0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	%rbx, %rcx
               	xorq	%r12, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0x140(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x160(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movl	$0x3, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$0x13ab, %rax           # imm = 0x13AB
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	leaq	-0x130(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x150(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movl	$0x4, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$-0x786, %rax           # imm = 0xF87A
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0x120(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movl	$0x3, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$0x13ab, %rax           # imm = 0x13AB
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	leaq	-0x110(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movl	$0x4, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$-0x786, %rax           # imm = 0xF87A
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0x100(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movl	$0x3, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$0x13ab, %rax           # imm = 0x13AB
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	leaq	-0xf0(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movl	$0x4, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	cmpq	$-0x786, %rax           # imm = 0xF87A
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movl	$0x7, %eax
               	movl	$0x8, %ebx
               	leaq	-0xe0(%rbp), %r12
               	leaq	<rip>, %r13
               	pushq	%rax
               	movq	(%r13), %rax
               	movq	%rax, (%r12)
               	movq	0x8(%r13), %rax
               	movq	%rax, 0x8(%r12)
               	popq	%rax
               	leaq	-0xe0(%rbp), %r12
               	subq	$0x40, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%rdi, 0x10(%rsp)
               	movq	%rdx, 0x30(%rsp)
               	movq	%r12, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x13cf, %rax           # imm = 0x13CF
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x1, %ecx
               	movl	$0x2, %edx
               	leaq	-0xd0(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movl	$0x4, %esi
               	subq	$0x40, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rsi, 0x30(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$-0x785, %rax           # imm = 0xF87B
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	-0x160(%rbp), %rsi
               	movl	$0x3, %ecx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x13a8, %rax           # imm = 0x13A8
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	leaq	-0x150(%rbp), %rdx
               	movl	$0x4, %r8d
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$-0x78a, %rax           # imm = 0xF876
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x3, %edx
               	leaq	-0x160(%rbp), %rcx
               	movq	%rdi, %rsi
               	movq	%rdx, %r9
               	movq	0x8(%rcx), %r8
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x13b0, %rax           # imm = 0x13B0
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x7, %edi
               	movl	$0x1, %esi
               	leaq	-0x150(%rbp), %rax
               	movl	$0x5, %ecx
               	subq	$0x30, %rsp
               	movq	%rsi, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%rcx, 0x20(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rsi, %rdx
               	movq	%rsi, %r9
               	movq	%rsi, %r8
               	movq	%rsi, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x30, %rsp
               	cmpq	$-0x769, %rax           # imm = 0xF897
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x8, %edi
               	movl	$0x1, %esi
               	leaq	-0x160(%rbp), %rax
               	movl	$0x3, %ecx
               	subq	$0x40, %rsp
               	movq	%rsi, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rcx, 0x30(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	%rsi, %rdx
               	movq	%rsi, %r9
               	movq	%rsi, %r8
               	movq	%rsi, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x13cc, %rax           # imm = 0x13CC
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
