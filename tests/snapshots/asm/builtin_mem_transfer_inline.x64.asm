
builtin_mem_transfer_inline.x64:	file format elf64-x86-64

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
               	subq	$0x460, %rsp            # imm = 0x460
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	xorq	%r12, %r12
               	movq	%r12, %rax
               	movq	%r12, %rax
               	movq	%r12, %rax
               	movabsq	$0x123456789abcdef, %r13 # imm = 0x123456789ABCDEF
               	movabsq	$-0x123456789abcdf0, %r14 # imm = 0xFEDCBA9876543210
               	movl	$0xdeadbeef, %r15d      # imm = 0xDEADBEEF
               	movl	$0x5a, %r10d
               	movq	%r10, 0x38(%rsp)
               	leaq	-0x418(%rbp), %rax
               	movq	%r13, (%rax)
               	movq	%r14, 0x8(%rax)
               	movl	%r15d, 0x10(%rax)
               	movq	0x38(%rsp), %r11
               	movb	%r11b, 0x14(%rax)
               	movb	%r12b, 0x15(%rax)
               	movw	%r12w, 0x16(%rax)
               	cmpq	%r13, %r13
               	jne	<addr>
               	leaq	-0x418(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	cmpq	%r14, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	0x10(%rax), %eax
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpl	%r11d, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x418(%rbp), %rax
               	movzbq	0x14(%rax), %rax
               	cmpl	$0x5a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	incq	%rax
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movl	%ecx, -0x420(%rbp)
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movl	$0x11223345, %ecx       # imm = 0x11223345
               	movl	%ecx, -0x420(%rbp)
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	addq	$0xf, %rax
               	movl	$0x11223346, %ecx       # imm = 0x11223346
               	movl	%ecx, -0x420(%rbp)
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	addq	$0x16, %rax
               	movl	$0x11223347, %ecx       # imm = 0x11223347
               	movl	%ecx, -0x420(%rbp)
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	addq	$0x1d, %rax
               	movl	$0x11223348, %ecx       # imm = 0x11223348
               	movl	%ecx, -0x420(%rbp)
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	incq	%rax
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	movb	%dl, 0x3(%rcx)
               	popq	%rdx
               	movl	-0x420(%rbp), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	movb	%dl, 0x3(%rcx)
               	popq	%rdx
               	movl	-0x420(%rbp), %eax
               	cmpl	$0x11223345, %eax       # imm = 0x11223345
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0xf, %rax
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	movb	%dl, 0x3(%rcx)
               	popq	%rdx
               	movl	-0x420(%rbp), %eax
               	cmpl	$0x11223346, %eax       # imm = 0x11223346
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x16, %rax
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	movb	%dl, 0x3(%rcx)
               	popq	%rdx
               	movl	-0x420(%rbp), %eax
               	cmpl	$0x11223347, %eax       # imm = 0x11223347
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x1d, %rax
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	movb	%dl, 0x3(%rcx)
               	popq	%rdx
               	movl	-0x420(%rbp), %eax
               	cmpl	$0x11223348, %eax       # imm = 0x11223348
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	-0x418(%rbp), %rcx
               	movzbq	0x14(%rcx), %rcx
               	movb	%cl, (%rax)
               	movb	%cl, 0x1(%rax)
               	movb	%cl, 0x2(%rax)
               	movb	%cl, 0x3(%rax)
               	movb	%cl, 0x4(%rax)
               	movb	%cl, 0x5(%rax)
               	movb	%cl, 0x6(%rax)
               	movb	%cl, 0x7(%rax)
               	movb	%cl, 0x8(%rax)
               	movb	%cl, 0x9(%rax)
               	movb	%cl, 0xa(%rax)
               	movb	%cl, 0xb(%rax)
               	movb	%cl, 0xc(%rax)
               	movb	%cl, 0xd(%rax)
               	movb	%cl, 0xe(%rax)
               	movb	%cl, 0xf(%rax)
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x1(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x6(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xa(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xc(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xd(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xe(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x5a, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	andq	$0xff, %rcx
               	movb	%cl, (%rsi)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rsi
               	leaq	0x4(%rsi), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	xorq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x6(%rax), %rax
               	xorq	$0x2, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0x3, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0x4, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0x5, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xa(%rax), %rax
               	xorq	$0x6, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0x7, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xc(%rax), %rax
               	xorq	$0x8, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xd(%rax), %rax
               	xorq	$0x9, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xe(%rax), %rax
               	xorq	$0xa, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0xb, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x10(%rax), %rax
               	xorq	$0xc, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x11(%rax), %rax
               	xorq	$0xd, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x12(%rax), %rax
               	xorq	$0xe, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x13(%rax), %rax
               	xorq	$0xf, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	andq	$0xff, %rcx
               	movb	%cl, (%rsi)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x4(%rdi), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x1(%rax), %rax
               	xorq	$0x5, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x6, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x7, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x8, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	xorq	$0x9, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x6(%rax), %rax
               	xorq	$0xa, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0xb, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0xc, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0xd, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xa(%rax), %rax
               	xorq	$0xe, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0xf, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xc(%rax), %rax
               	xorq	$0x10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xd(%rax), %rax
               	xorq	$0x11, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xe(%rax), %rax
               	xorq	$0x12, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x13, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdx
               	movslq	%eax, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rcx,%rcx,2), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	leaq	-0x400(%rbp), %rsi
               	movl	$0x200, %edx            # imm = 0x200
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x200(%rbp), %rdx
               	movslq	%eax, %rcx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	leaq	(%rcx,%rcx,2), %rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	movl	$0x18, %edx
               	leaq	-0x200(%rbp), %rdi
               	xorq	%rbx, %rbx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	leaq	-0x200(%rbp), %rax
               	addq	%rbx, %rax
               	movzbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpq	$0x18, %rbx
               	jb	<addr>
               	leaq	-0x200(%rbp), %rax
               	movzbq	0x18(%rax), %rax
               	cmpl	$0x48, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	-0x418(%rbp), %rax
               	movq	%r13, (%rax)
               	movq	%r14, 0x8(%rax)
               	movl	%r15d, 0x10(%rax)
               	movq	0x38(%rsp), %r11
               	movb	%r11b, 0x14(%rax)
               	movb	%r12b, 0x15(%rax)
               	movw	%r12w, 0x16(%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x418(%rbp), %rax
               	movq	%r13, (%rax)
               	movq	%r14, 0x8(%rax)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
