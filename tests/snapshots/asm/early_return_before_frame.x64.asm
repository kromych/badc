
early_return_before_frame.x64:	file format elf64-x86-64

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

<fib>:
               	cmpl	$0x2, %edi
               	jl	<addr>
               	pushq	%rax
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %r13
               	xorl	%r14d, %r14d
               	leaq	-0x1(%r13), %rbx
               	xorl	%r12d, %r12d
               	nop
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	subq	$0x2, %rbx
               	addq	%rax, %r12
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	leaq	(%r12,%rbx), %rax
               	subq	$0x2, %r13
               	addq	%rax, %r14
               	cmpl	$0x2, %r13d
               	jge	<addr>
               	leaq	(%r14,%r13), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r11
               	retq
               	movslq	%edi, %rax
               	retq

<qs>:
               	cmpl	%edx, %esi
               	jge	<addr>
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
               	cmpl	%edx, %ebx
               	jg	<addr>
               	movslq	%ebx, %rcx
               	movq	(%r12,%rcx,8), %rdi
               	cmpq	%rax, %rdi
               	jge	<addr>
               	incq	%rbx
               	movslq	%ebx, %rcx
               	movq	(%r12,%rcx,8), %rdi
               	cmpq	%rax, %rdi
               	jl	<addr>
               	movslq	%edx, %rdi
               	movq	(%r12,%rdi,8), %r8
               	nopl	(%rax,%rax)
               	cmpq	%rax, %r8
               	jle	<addr>
               	decq	%rdx
               	movslq	%edx, %rdi
               	movq	(%r12,%rdi,8), %r8
               	cmpq	%rax, %r8
               	jg	<addr>
               	cmpl	%edx, %ebx
               	jg	<addr>
               	movq	(%r12,%rcx,8), %r9
               	movq	%r8, (%r12,%rcx,8)
               	movq	%r9, (%r12,%rdi,8)
               	incq	%rbx
               	decq	%rdx
               	cmpl	%edx, %ebx
               	jle	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rbx, %rsi
               	nopl	(%rax)
               	cmpl	%r13d, %esi
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq
               	retq

<tree_sum>:
               	testq	%rdi, %rdi
               	je	<addr>
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	xorl	%r12d, %r12d
               	movq	0x10(%rbx), %r13
               	movq	(%rbx), %rdi
               	nopl	(%rax,%rax)
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
               	retq
               	xorl	%eax, %eax
               	nop
               	retq

<narrow>:
               	movsbq	%dil, %rdi
               	movswq	%si, %rsi
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jle	<addr>
               	leaq	-0x1(%rdi), %rcx
               	movq	%rsi, %rdx
               	subq	%rdi, %rdx
               	movswq	%dx, %rsi
               	incq	%rax
               	movswq	%ax, %rax
               	movq	%rcx, %rdi
               	testl	%edi, %edi
               	jg	<addr>
               	addq	%rsi, %rax
               	movswq	%ax, %rax
               	retq

<ucount>:
               	xorl	%ecx, %ecx
               	cmpl	%esi, %edi
               	jb	<addr>
               	subq	%rsi, %rdi
               	xorq	$0x1, %rcx
               	cmpl	%esi, %edi
               	jae	<addr>
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	addq	%rsi, %rax
               	movl	%eax, %eax
               	xorq	%rcx, %rax
               	retq

<many>:
               	testq	%rdi, %rdi
               	jle	<addr>
               	subq	$0x38, %rsp
               	subq	$0x20, %rsp
               	decq	%rdi
               	movq	0x70(%rsp), %rax
               	leaq	(%rsi,%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x78(%rsp), %rsi
               	addq	%rsi, %rdx
               	movq	0x60(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x68(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rcx, 0x30(%rsp)
               	movq	%r8, 0x28(%rsp)
               	movq	%r9, 0x20(%rsp)
               	movq	0x40(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	movq	0x48(%rsp), %rsi
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	movq	0x28(%rsp), %r8
               	movq	0x20(%rsp), %r9
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x60(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x20, %rsp
               	addq	$0x38, %rsp
               	retq
               	movq	%rsi, %rax
               	xorq	%rdx, %rax
               	retq

<gcd>:
               	testl	%esi, %esi
               	je	<addr>
               	pushq	%rax
               	movl	%edi, %eax
               	cltd
               	idivl	%esi
               	movq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	callq	*%rcx
               	popq	%r11
               	retq
               	movq	%rdi, %rax
               	retq

<count_yield>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	retq

<lex>:
               	testq	%rdi, %rdi
               	je	<addr>
               	pushq	%rbx
               	movq	%rdi, %rbx
               	jmp	<addr>
               	incq	%rbx
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movsbq	(%rbx), %rax
               	subq	$0x2a, %rax
               	cmpq	$0x10, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	movl	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movl	$0x0, <rip> # <addr>
               	jmp	<addr>
               	movl	$0x2, <rip> # <addr>
               	popq	%rbx
               	retq
               	retq

<main>:
               	subq	$0x328, %rsp            # imm = 0x328
               	subq	$0x20, %rsp
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpq	$0x1a6d, %rax           # imm = 0x1A6D
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	movq	$-0x3, %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorl	%eax, %eax
               	movabsq	$0x14057b7ef767814f, %rdx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %rsi # imm = 0x5851F42D4C957F2D
               	imulq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, %r8
               	shrq	$0x21, %r8
               	subq	$0x40000000, %r8        # imm = 0x40000000
               	movq	%r8, 0x140(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rcx
               	movq	%rcx, 0x20(%rsp)
               	movq	%rcx, %rdi
               	xorl	%esi, %esi
               	movl	$0x3f, %edx
               	callq	<addr>
               	movq	0x20(%rsp), %rcx
               	movl	$0x1, %eax
               	leaq	-0x1(%rax), %rdx
               	movq	0x140(%rsp,%rdx,8), %rdx
               	movq	0x140(%rsp,%rax,8), %rsi
               	cmpq	%rsi, %rdx
               	jg	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rdi
               	movl	$0x5, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	xorl	%esi, %esi
               	movq	%rsi, %rax
               	jmp	<addr>
               	movq	%rdx, 0x8(%rcx)
               	incq	%rax
               	cmpl	$0x7, %eax
               	jge	<addr>
               	leaq	0x98(%rsp), %rdx
               	imulq	$0x18, %rax, %rcx
               	addq	%rdx, %rcx
               	leaq	0x1(%rax), %rdi
               	movq	%rdi, 0x10(%rcx)
               	movq	%rax, %rdi
               	shlq	%rdi
               	leaq	0x1(%rdi), %r8
               	imulq	$0x18, %r8, %r9
               	addq	%r9, %rdx
               	cmpl	$0x7, %r8d
               	cmovgeq	%rsi, %rdx
               	movq	%rdx, (%rcx)
               	leaq	0x2(%rdi), %rdx
               	cmpl	$0x7, %edx
               	jge	<addr>
               	leaq	0x98(%rsp), %rdx
               	movq	%rax, %rdi
               	shlq	%rdi
               	addq	$0x2, %rdi
               	imulq	$0x18, %rdi, %rdi
               	addq	%rdi, %rdx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	leaq	0x98(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	movl	$0x5, %edi
               	movl	$0x64, %esi
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	movq	$-0x7, %rdi
               	movq	$-0x12c, %rsi           # imm = 0xFED4
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
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
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
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
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	movq	$0x28, (%rsp)
               	movq	$0x32, 0x8(%rsp)
               	movq	$0x64, 0x10(%rsp)
               	movq	$0x3e8, 0x18(%rsp)      # imm = 0x3E8
               	movl	$0x3, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0xa, %ecx
               	movl	$0x14, %r8d
               	movl	$0x1e, %r9d
               	callq	<addr>
               	cmpq	$0xc59, %rax            # imm = 0xC59
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	movq	$0x0, (%rsp)
               	movq	$0x0, 0x8(%rsp)
               	movq	$0x0, 0x10(%rsp)
               	movq	$0x0, 0x18(%rsp)
               	xorl	%edi, %edi
               	movl	$0x6, %esi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	xorl	%r8d, %r8d
               	xorl	%r9d, %r9d
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x1ce, %edi            # imm = 0x1CE
               	movl	$0x93, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x88(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x80(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x78(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x70(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x68(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x60(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x58(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x50(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x48(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x40(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x38(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x30(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	0x28(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	xorl	%edi, %edi
               	movl	$0x5, %esi
               	callq	<addr>
               	movswq	%ax, %rax
               	movq	%rax, %r10
               	movq	0x28(%rsp), %rax
               	addq	%r10, %rax
               	leaq	0x7(%rax), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	$0x0, (%rsp)
               	movq	$0x0, 0x8(%rsp)
               	movq	$0x0, 0x10(%rsp)
               	movq	$0x0, 0x18(%rsp)
               	xorl	%edi, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	xorl	%r8d, %r8d
               	xorl	%r9d, %r9d
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x28(%rsp), %rax
               	addq	%r10, %rax
               	addq	0x88(%rsp), %rax
               	movq	0x80(%rsp), %rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	movq	0x78(%rsp), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rsp), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	addq	%rcx, %rax
               	movq	0x60(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	leaq	(%rcx,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	imulq	$0xb, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x30(%rsp), %rcx
               	imulq	$0xc, %rcx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x29a, %rax            # imm = 0x29A
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	incq	%rcx
               	movq	<rip>, %rax # <addr>
               	movq	%rcx, 0x20(%rsp)
               	nop
               	callq	*%rax
               	movq	0x20(%rsp), %rcx
               	movsbq	(%rcx), %rax
               	subq	$0x2a, %rax
               	cmpq	$0x10, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	movl	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movl	$0x0, <rip> # <addr>
               	jmp	<addr>
               	movl	$0x2, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	xorl	%eax, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	addq	$0x328, %rsp            # imm = 0x328
               	retq
