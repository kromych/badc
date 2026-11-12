
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
               	subq	$0x420, %rsp            # imm = 0x420
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movabsq	$-0x123456789abcdf0, %rdx # imm = 0xFEDCBA9876543210
               	movq	%rcx, -0x418(%rbp)
               	movq	%rdx, -0x410(%rbp)
               	movl	$0xdeadbeef, -0x408(%rbp) # imm = 0xDEADBEEF
               	movb	$0x5a, -0x404(%rbp)
               	movb	$0x0, -0x403(%rbp)
               	movw	$0x0, -0x402(%rbp)
               	movl	-0x408(%rbp), %eax
               	cmpl	$0xdeadbeef, %eax       # imm = 0xDEADBEEF
               	jne	<addr>
               	movzbq	-0x404(%rbp), %rax
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	incq	%rax
               	movl	$0x11223344, -0x8(%rbp) # imm = 0x11223344
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movl	$0x11223345, -0x8(%rbp) # imm = 0x11223345
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	<rip>, %rax # <addr>
               	addq	$0xf, %rax
               	movl	$0x11223346, -0x8(%rbp) # imm = 0x11223346
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	<rip>, %rax # <addr>
               	addq	$0x16, %rax
               	movl	$0x11223347, -0x8(%rbp) # imm = 0x11223347
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	<rip>, %rax # <addr>
               	addq	$0x1d, %rax
               	movl	$0x11223348, -0x8(%rbp) # imm = 0x11223348
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	<rip>, %rax # <addr>
               	incq	%rax
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x11223345, %eax       # imm = 0x11223345
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0xf, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x11223346, %eax       # imm = 0x11223346
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x16, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x11223347, %eax       # imm = 0x11223347
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x1d, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x11223348, %eax       # imm = 0x11223348
               	jne	<addr>
               	movzbq	-0x404(%rbp), %rax
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x4(%rsi), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xf, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x4(%rdi), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x10, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x11, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x12, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x13, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0x400(%rbp), %rcx
               	leaq	(%rax,%rax,2), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	leaq	-0x400(%rbp), %rsi
               	movl	$0x200, %edx            # imm = 0x200
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x200(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	(%rax,%rax,2), %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	movl	$0x18, %edx
               	leaq	-0x200(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x200(%rbp), %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jb	<addr>
               	movzbq	-0x1e8(%rbp), %rax
               	cmpl	$0x48, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movq	%rcx, -0x418(%rbp)
               	movabsq	$-0x123456789abcdf0, %rdx # imm = 0xFEDCBA9876543210
               	movq	%rdx, -0x410(%rbp)
               	movl	$0xdeadbeef, -0x408(%rbp) # imm = 0xDEADBEEF
               	movb	$0x5a, -0x404(%rbp)
               	movb	$0x0, -0x403(%rbp)
               	movw	$0x0, -0x402(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, -0x418(%rbp)
               	movq	%rax, -0x410(%rbp)
               	movq	%rax, -0x408(%rbp)
               	movq	%rcx, -0x418(%rbp)
               	movq	%rdx, -0x410(%rbp)
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
