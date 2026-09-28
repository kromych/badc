
early_return_before_frame.x64:	file format elf64-x86-64

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

<fib>:
               	cmpl	$0x2, %edi
               	jl	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	xorl	%r12d, %r12d
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	subq	$0x2, %rbx
               	addq	%rax, %r12
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	leaq	(%r12,%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movslq	%edi, %rax
               	retq

<qs>:
               	cmpl	%edx, %esi
               	jge	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rdx, %r13
               	leaq	(%rsi,%r13), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	movq	(%r12,%rax,8), %rax
               	movq	%r13, %rdx
               	movq	%rsi, %rbx
               	jmp	<addr>
               	incq	%rbx
               	movslq	%ebx, %rcx
               	movq	(%r12,%rcx,8), %rdi
               	cmpq	%rax, %rdi
               	jl	<addr>
               	movslq	%edx, %rdi
               	movq	(%r12,%rdi,8), %r8
               	cmpq	%rax, %r8
               	jle	<addr>
               	decq	%rdx
               	movslq	%edx, %rdi
               	movq	(%r12,%rdi,8), %r8
               	cmpq	%rax, %r8
               	jg	<addr>
               	cmpl	%edx, %ebx
               	jg	<addr>
               	movq	(%r12,%rcx,8), %r8
               	movq	(%r12,%rdi,8), %r9
               	movq	%r9, (%r12,%rcx,8)
               	movq	%r8, (%r12,%rdi,8)
               	incq	%rbx
               	decq	%rdx
               	cmpl	%edx, %ebx
               	jle	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rbx, %rsi
               	cmpl	%r13d, %esi
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	retq

<tree_sum>:
               	testq	%rdi, %rdi
               	je	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	xorl	%r12d, %r12d
               	movq	0x10(%rbx), %r13
               	movq	(%rbx), %rdi
               	callq	<addr>
               	addq	%r13, %rax
               	movq	0x8(%rbx), %rbx
               	addq	%rax, %r12
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	retq

<narrow>:
               	movsbq	%dil, %rax
               	testl	%eax, %eax
               	jle	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movsbq	%dil, %rdi
               	movswq	%si, %rsi
               	leaq	-0x1(%rdi), %rax
               	subq	%rdi, %rsi
               	movq	%rax, %rdi
               	callq	<addr>
               	movswq	%ax, %rax
               	incq	%rax
               	movswq	%ax, %rax
               	popq	%rbp
               	retq
               	movswq	%si, %rax
               	retq

<ucount>:
               	cmpl	%esi, %edi
               	jb	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	%rsi, %rdi
               	callq	<addr>
               	xorq	$0x1, %rax
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	addq	%rsi, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	retq

<many>:
               	testq	%rdi, %rdi
               	jle	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rcx, %rbx
               	movq	%r9, %r13
               	movq	%r8, %r12
               	decq	%rdi
               	movq	0x20(%rbp), %rax
               	addq	%rax, %rsi
               	movq	0x28(%rbp), %rcx
               	addq	%rcx, %rdx
               	movq	0x10(%rbp), %r8
               	movq	0x18(%rbp), %r9
               	subq	$0x20, %rsp
               	movq	%r8, (%rsp)
               	movq	%r9, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	movq	%rbx, %rcx
               	movq	%r13, %r9
               	movq	%r12, %r8
               	callq	<addr>
               	addq	$0x20, %rsp
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	movq	0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rsi, %rax
               	xorq	%rdx, %rax
               	retq

<gcd>:
               	testl	%esi, %esi
               	je	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	callq	*%rcx
               	popq	%rbp
               	retq
               	movslq	%edi, %rax
               	retq

<count_yield>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	retq

<lex>:
               	testq	%rdi, %rdi
               	je	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movsbq	(%rbx), %rax
               	subq	$0x2a, %rax
               	cmpq	$0x10, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	leaq	<rip>, %rax
               	movl	$0x1, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	incq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	movsbq	(%rbx), %rax
               	subq	$0x2a, %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	leaq	<rip>, %rax
               	movl	$0x2, (%rax)
               	popq	%rbx
               	leave
               	retq
               	retq

<keep>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	movq	0x20(%rax), %r15
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	0x40(%rax), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x48(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x50(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, 0x30(%rsp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	0x30(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x30(%rsp)
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	movswq	%ax, %rax
               	movq	%rax, %r10
               	movq	0x30(%rsp), %rax
               	addq	%r10, %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0x30(%rsp)
               	xorl	%edi, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rdi, 0x8(%rsp)
               	movq	%rdi, 0x10(%rsp)
               	movq	%rdi, 0x18(%rsp)
               	movq	%rdi, %rcx
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %r10
               	movq	0x30(%rsp), %rax
               	addq	%r10, %rax
               	addq	%rbx, %rax
               	movq	%r12, %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	movq	%r14, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x60(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	leaq	(%rcx,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	imulq	$0xb, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	imulq	$0xc, %rcx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2b8, %rsp            # imm = 0x2B8
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpq	$0x1a6d, %rax           # imm = 0x1A6D
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x3, %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorl	%eax, %eax
               	movabsq	$0x14057b7ef767814f, %rdx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rsi # imm = 0x5851F42D4C957F2D
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	leaq	-0x200(%rbp), %rdi
               	movq	%rcx, %r8
               	shrq	$0x21, %r8
               	subq	$0x40000000, %r8        # imm = 0x40000000
               	movq	%r8, (%rdi,%rax,8)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x200(%rbp), %rbx
               	xorl	%esi, %esi
               	movl	$0x3f, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x1, %eax
               	leaq	-0x1(%rax), %rcx
               	movq	(%rbx,%rcx,8), %rcx
               	leaq	-0x200(%rbp), %rdx
               	movq	(%rdx,%rax,8), %rdx
               	cmpq	%rdx, %rcx
               	jg	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	movl	$0x5, %esi
               	movq	%rsi, %rdx
               	callq	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	leaq	-0x2a8(%rbp), %rcx
               	imulq	$0x18, %rax, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	leaq	0x1(%rax), %r8
               	movq	%r8, 0x10(%rdi)
               	movq	%rax, %r8
               	shlq	%r8
               	leaq	0x1(%r8), %r9
               	cmpl	$0x7, %r9d
               	jge	<addr>
               	imulq	$0x18, %r9, %r9
               	addq	%r9, %rcx
               	movq	%rcx, (%rdi)
               	leaq	-0x2a8(%rbp), %rcx
               	addq	%rcx, %rsi
               	leaq	0x2(%r8), %rdi
               	cmpl	$0x7, %edi
               	jge	<addr>
               	movq	%rax, %rdi
               	shlq	%rdi
               	addq	$0x2, %rdi
               	imulq	$0x18, %rdi, %rdi
               	addq	%rdi, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rcx, 0x8(%rsi)
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	leaq	-0x2a8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5, %edi
               	movl	$0x64, %esi
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x7, %rdi
               	movq	$-0x12c, %rsi           # imm = 0xFED4
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x64, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	jne	<addr>
               	movl	$0xa, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xfffffff0, %edi       # imm = 0xFFFFFFF0
               	movl	$0x7ffffff0, %esi       # imm = 0x7FFFFFF0
               	callq	<addr>
               	movl	$0x80000030, %r11d      # imm = 0x80000030
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	movl	$0x80000000, %esi       # imm = 0x80000000
               	callq	<addr>
               	cmpq	$0x7ffffffc, %rax       # imm = 0x7FFFFFFC
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0xa, %ecx
               	movl	$0x14, %r8d
               	movl	$0x1e, %r9d
               	movl	$0x28, %eax
               	movl	$0x32, %ebx
               	movl	$0x64, %r12d
               	movl	$0x3e8, %r13d           # imm = 0x3E8
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0xc59, %rax            # imm = 0xC59
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x6, %esi
               	movl	$0x3, %edx
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rdi, 0x8(%rsp)
               	movq	%rdi, 0x10(%rsp)
               	movq	%rdi, 0x18(%rsp)
               	movq	%rdi, %rcx
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1ce, %edi            # imm = 0x1CE
               	movl	$0x93, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x29a, %rax            # imm = 0x29A
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r13
               	leaq	<rip>, %r12
               	movsbq	(%rbx), %rax
               	subq	$0x2a, %rax
               	cmpq	$0x10, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	movl	$0x1, (%r12)
               	jmp	<addr>
               	movl	$0x0, (%r12)
               	incq	%rbx
               	movq	(%r13), %rax
               	callq	*%rax
               	movsbq	(%rbx), %rax
               	subq	$0x2a, %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	leaq	<rip>, %rax
               	movl	$0x2, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
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
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
