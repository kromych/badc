
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
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
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
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	imulq	$0x7, %rax, %rcx
               	incq	%rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	leaq	-0x450(%rbp), %rsi
               	pushq	%rax
               	movzbq	(%rcx), %rax
               	movb	%al, (%rsi)
               	movzbq	0x1(%rcx), %rax
               	movb	%al, 0x1(%rsi)
               	movzbq	0x2(%rcx), %rax
               	movb	%al, 0x2(%rsi)
               	movzbq	0x3(%rcx), %rax
               	movb	%al, 0x3(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	movl	-0x450(%rbp), %esi
               	movl	%eax, %ecx
               	addq	$0x11223344, %rcx       # imm = 0x11223344
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	cmpq	$0x5, %rax
               	jl	<addr>
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
               	xorq	%rax, %rax
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x5a, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpq	$0x10, %rax
               	jl	<addr>
               	leaq	-0x430(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x100, %edx            # imm = 0x100
               	movq	%rdx, (%rcx)
               	movl	$0x101, %ecx            # imm = 0x101
               	movq	%rcx, 0x8(%rax)
               	movl	$0x102, %ecx            # imm = 0x102
               	movq	%rcx, 0x10(%rax)
               	movl	$0x103, %ecx            # imm = 0x103
               	movq	%rcx, 0x18(%rax)
               	movl	$0x104, %ecx            # imm = 0x104
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x430(%rbp), %rcx
               	movl	$0x105, %eax            # imm = 0x105
               	movq	%rax, 0x28(%rcx)
               	xorq	%rax, %rax
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rsi
               	movq	0x10(%rcx), %rdi
               	movq	%rdx, 0x8(%rcx)
               	movq	%rsi, 0x10(%rcx)
               	movq	%rdi, 0x18(%rcx)
               	jmp	<addr>
               	leaq	-0x430(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	leaq	0x100(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	leaq	-0x430(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x100, %edx            # imm = 0x100
               	movq	%rdx, (%rcx)
               	movl	$0x101, %ecx            # imm = 0x101
               	movq	%rcx, 0x8(%rax)
               	movl	$0x102, %ecx            # imm = 0x102
               	movq	%rcx, 0x10(%rax)
               	movl	$0x103, %ecx            # imm = 0x103
               	movq	%rcx, 0x18(%rax)
               	movl	$0x104, %ecx            # imm = 0x104
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x430(%rbp), %rcx
               	movl	$0x105, %eax            # imm = 0x105
               	movq	%rax, 0x28(%rcx)
               	xorq	%rax, %rax
               	movq	0x8(%rcx), %rdx
               	movq	0x10(%rcx), %rsi
               	movq	0x18(%rcx), %rdi
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	jmp	<addr>
               	leaq	-0x430(%rbp), %rdx
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rdx
               	leaq	0x101(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movq	%rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpq	$0x18, %rax
               	jl	<addr>
               	leaq	<rip>, %rsi
               	leaq	0x4(%rsi), %rdi
               	xorq	%rbx, %rbx
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	leaq	0x4(%rbx), %rax
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	xorq	%rbx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	cmpq	$0x10, %rbx
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movq	%rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpq	$0x18, %rax
               	jl	<addr>
               	leaq	<rip>, %rdi
               	xorq	%rbx, %rbx
               	leaq	0x4(%rdi), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rcx), %rsi
               	leaq	0x4(%rax), %rcx
               	xorq	%rsi, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x1(%rax), %rbx
               	cmpq	$0x10, %rbx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rcx,%rcx,2), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpq	$0x200, %rax            # imm = 0x200
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
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpq	$0x200, %rax            # imm = 0x200
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
               	cmpq	$0x48, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
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
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x480, %rsp            # imm = 0x480
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
