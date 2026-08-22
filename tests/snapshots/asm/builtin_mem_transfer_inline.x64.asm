
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
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x448(%rbp), %rax
               	movabsq	$0x123456789abcdef, %r12 # imm = 0x123456789ABCDEF
               	movq	%r12, (%rax)
               	leaq	-0x448(%rbp), %rax
               	movabsq	$-0x123456789abcdf0, %r13 # imm = 0xFEDCBA9876543210
               	movq	%r13, 0x8(%rax)
               	leaq	-0x448(%rbp), %rax
               	movl	$0xdeadbeef, %ecx       # imm = 0xDEADBEEF
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x448(%rbp), %rax
               	movl	$0x5a, %ecx
               	movb	%cl, 0x14(%rax)
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
               	leaq	-0x418(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%r12, %rax
               	movl	$0x1, %ecx
               	jne	<addr>
               	leaq	-0x418(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	cmpq	%r13, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x418(%rbp), %rax
               	movl	0x10(%rax), %eax
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x418(%rbp), %rax
               	movzbq	0x14(%rax), %rax
               	cmpq	$0x5a, %rax
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
               	incq	%rax
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movq	%rcx, -0x450(%rbp)
               	leaq	-0x450(%rbp), %rcx
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
               	movq	%rcx, -0x450(%rbp)
               	leaq	-0x450(%rbp), %rcx
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
               	movq	%rcx, -0x450(%rbp)
               	leaq	-0x450(%rbp), %rcx
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
               	movq	%rcx, -0x450(%rbp)
               	leaq	-0x450(%rbp), %rcx
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
               	movq	%rcx, -0x450(%rbp)
               	leaq	-0x450(%rbp), %rcx
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	imulq	$0x7, %rax, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	addq	%rsi, %rdx
               	leaq	-0x450(%rbp), %rsi
               	pushq	%rax
               	movzbq	(%rdx), %rax
               	movb	%al, (%rsi)
               	movzbq	0x1(%rdx), %rax
               	movb	%al, 0x1(%rsi)
               	movzbq	0x2(%rdx), %rax
               	movb	%al, 0x2(%rsi)
               	movzbq	0x3(%rdx), %rax
               	movb	%al, 0x3(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	movl	-0x450(%rbp), %esi
               	movl	%ecx, %edx
               	addq	$0x11223344, %rdx       # imm = 0x11223344
               	movl	%edx, %edx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5, %rcx
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
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	$0x5a, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x430(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x100, %ecx            # imm = 0x100
               	movq	%rcx, (%rax)
               	leaq	-0x430(%rbp), %rax
               	movl	$0x101, %ecx            # imm = 0x101
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x430(%rbp), %rax
               	movl	$0x102, %ecx            # imm = 0x102
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x430(%rbp), %rax
               	movl	$0x103, %ecx            # imm = 0x103
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x430(%rbp), %rax
               	movl	$0x104, %ecx            # imm = 0x104
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x430(%rbp), %rax
               	movl	$0x105, %ecx            # imm = 0x105
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x430(%rbp), %rcx
               	leaq	-0x430(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	(%rdx), %rsi
               	movq	0x8(%rdx), %rdi
               	movq	0x10(%rdx), %rdx
               	movq	%rsi, 0x8(%rcx)
               	movq	%rdi, 0x10(%rcx)
               	movq	%rdx, 0x18(%rcx)
               	jmp	<addr>
               	leaq	-0x430(%rbp), %rdx
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	leaq	0x100(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	-0x430(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x100, %ecx            # imm = 0x100
               	movq	%rcx, (%rax)
               	leaq	-0x430(%rbp), %rax
               	movl	$0x101, %ecx            # imm = 0x101
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x430(%rbp), %rax
               	movl	$0x102, %ecx            # imm = 0x102
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x430(%rbp), %rax
               	movl	$0x103, %ecx            # imm = 0x103
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x430(%rbp), %rax
               	movl	$0x104, %ecx            # imm = 0x104
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x430(%rbp), %rax
               	movl	$0x105, %ecx            # imm = 0x105
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x430(%rbp), %rdx
               	xorq	%rax, %rax
               	leaq	-0x430(%rbp), %rcx
               	movq	0x8(%rcx), %rsi
               	movq	0x10(%rcx), %rdi
               	movq	0x18(%rcx), %rcx
               	movq	%rsi, (%rdx)
               	movq	%rdi, 0x8(%rdx)
               	movq	%rcx, 0x10(%rdx)
               	jmp	<addr>
               	leaq	-0x430(%rbp), %rdx
               	movq	(%rdx,%rcx,8), %rdx
               	leaq	0x101(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	addq	%rcx, %rdx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x18, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	leaq	0x4(%rsi), %rdi
               	xorq	%rbx, %rbx
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x4(%rax), %rcx
               	movslq	%ecx, %rcx
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	%rax, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x10, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	addq	%rcx, %rdx
               	movq	%rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x18, %rcx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	xorq	%rbx, %rbx
               	leaq	0x4(%rdi), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	addq	%rax, %rcx
               	movzbq	(%rcx), %rdx
               	leaq	0x4(%rax), %rcx
               	movslq	%ecx, %rcx
               	xorq	%rdx, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x10, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rcx,%rcx,2), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x200, %rcx            # imm = 0x200
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	leaq	-0x400(%rbp), %rsi
               	movl	$0x200, %edx            # imm = 0x200
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x200(%rbp), %rdx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rsi
               	leaq	(%rcx,%rcx,2), %rdx
               	movslq	%edx, %rdx
               	andq	$0xff, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x200, %rcx            # imm = 0x200
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
               	leaq	-0x418(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x418(%rbp), %rax
               	movq	%r12, (%rax)
               	movq	%r13, 0x8(%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	jmp	<addr>
