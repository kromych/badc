
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
               	subq	$0x480, %rsp            # imm = 0x480
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x448(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	movabsq	$0x123456789abcdef, %r12 # imm = 0x123456789ABCDEF
               	movq	%r12, (%rax)
               	movabsq	$-0x123456789abcdf0, %r13 # imm = 0xFEDCBA9876543210
               	movq	%r13, 0x8(%rax)
               	movl	$0xdeadbeef, %ecx       # imm = 0xDEADBEEF
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x448(%rbp), %rax
               	movl	$0x5a, %ecx
               	movb	%cl, 0x14(%rax)
               	leaq	-0x418(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movq	(%rcx), %rax
               	cmpq	%r12, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	movq	0x8(%rcx), %rsi
               	cmpq	%r13, %rsi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x10(%rcx), %eax
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
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x1(%rax), %rcx
               	movl	$0x11223344, %eax       # imm = 0x11223344
               	movq	%rax, -0x450(%rbp)
               	leaq	-0x450(%rbp), %rax
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
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	movl	$0x11223345, %edx       # imm = 0x11223345
               	movq	%rdx, -0x450(%rbp)
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
               	leaq	<rip>, %rcx
               	addq	$0xf, %rcx
               	movl	$0x11223346, %edx       # imm = 0x11223346
               	movq	%rdx, -0x450(%rbp)
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
               	leaq	<rip>, %rcx
               	addq	$0x16, %rcx
               	movl	$0x11223347, %edx       # imm = 0x11223347
               	movq	%rdx, -0x450(%rbp)
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
               	leaq	<rip>, %rcx
               	addq	$0x1d, %rcx
               	movl	$0x11223348, %edx       # imm = 0x11223348
               	movq	%rdx, -0x450(%rbp)
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
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	leaq	0x1(%rax), %rcx
               	leaq	-0x450(%rbp), %rax
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
               	movq	%rax, %rcx
               	movl	-0x450(%rbp), %ecx
               	cmpl	$0x11223344, %ecx       # imm = 0x11223344
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
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
               	movq	%rax, %rcx
               	movl	-0x450(%rbp), %ecx
               	cmpl	$0x11223345, %ecx       # imm = 0x11223345
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0xf, %rcx
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
               	movq	%rax, %rcx
               	movl	-0x450(%rbp), %ecx
               	cmpl	$0x11223346, %ecx       # imm = 0x11223346
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x16, %rcx
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
               	movq	%rax, %rcx
               	movl	-0x450(%rbp), %ecx
               	cmpl	$0x11223347, %ecx       # imm = 0x11223347
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x1d, %rcx
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
               	movl	-0x450(%rbp), %eax
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
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x1(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x6(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xa(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xc(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xd(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xe(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x5a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movq	%rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
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
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x6(%rax), %rax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0x3, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xa(%rax), %rax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xc(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xd(%rax), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xe(%rax), %rax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0xb, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x10(%rax), %rax
               	xorq	$0xc, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x11(%rax), %rax
               	xorq	$0xd, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x12(%rax), %rax
               	xorq	$0xe, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x13(%rax), %rax
               	xorq	$0xf, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movq	%rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
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
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x1(%rax), %rax
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x6(%rax), %rax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0xb, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0xc, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0xd, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xa(%rax), %rax
               	xorq	$0xe, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0xf, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xc(%rax), %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xd(%rax), %rax
               	xorq	$0x11, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xe(%rax), %rax
               	xorq	$0x12, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x13, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rcx,%rcx,2), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
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
               	movzbq	(%rdx), %rsi
               	leaq	(%rcx,%rcx,2), %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
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
               	leave
               	retq
               	leaq	-0x418(%rbp), %rax
               	leaq	-0x448(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%r12, (%rax)
               	movq	%r13, 0x8(%rax)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	leave
               	retq
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
