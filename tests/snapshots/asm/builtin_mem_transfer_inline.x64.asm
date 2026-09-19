
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
               	subq	$0x438, %rsp            # imm = 0x438
               	pushq	%r14
               	pushq	%r12
               	pushq	%rbx
               	movabsq	$0x123456789abcdef, %r12 # imm = 0x123456789ABCDEF
               	movabsq	$-0x123456789abcdf0, %r14 # imm = 0xFEDCBA9876543210
               	leaq	-0x418(%rbp), %rax
               	movq	%r12, (%rax)
               	movq	%r14, 0x8(%rax)
               	movl	$0xdeadbeef, 0x10(%rax) # imm = 0xDEADBEEF
               	movb	$0x5a, 0x14(%rax)
               	movb	$0x0, 0x15(%rax)
               	movw	$0x0, 0x16(%rax)
               	cmpq	%r12, %r12
               	jne	<addr>
               	leaq	-0x418(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	cmpq	%r14, %rcx
               	jne	<addr>
               	movl	0x10(%rax), %eax
               	movl	$0xdeadbeef, %r11d      # imm = 0xDEADBEEF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	-0x418(%rbp), %rax
               	movzbq	0x14(%rax), %rax
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	incq	%rax
               	movl	$0x11223344, -0x420(%rbp) # imm = 0x11223344
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
               	movl	$0x11223345, -0x420(%rbp) # imm = 0x11223345
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
               	movl	$0x11223346, -0x420(%rbp) # imm = 0x11223346
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
               	movl	$0x11223347, -0x420(%rbp) # imm = 0x11223347
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
               	movl	$0x11223348, -0x420(%rbp) # imm = 0x11223348
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
               	popq	%rbx
               	popq	%r12
               	popq	%r14
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
               	movzbq	(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x1(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x6(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xa(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xc(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xd(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xe(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x5a, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rsi
               	leaq	0x4(%rsi), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x4(%rax)
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x6(%rax), %rax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0x3, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xa(%rax), %rax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xc(%rax), %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xd(%rax), %rax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xe(%rax), %rax
               	xorq	$0xa, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0xb, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x10(%rax), %rax
               	xorq	$0xc, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x11(%rax), %rax
               	xorq	$0xd, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x12(%rax), %rax
               	xorq	$0xe, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x13(%rax), %rax
               	xorq	$0xf, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	cmpl	$0x18, %eax
               	jge	<addr>
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x4(%rdi), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x1(%rax), %rax
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x6(%rax), %rax
               	xorq	$0xa, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x7(%rax), %rax
               	xorq	$0xb, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x8(%rax), %rax
               	xorq	$0xc, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0xd, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xa(%rax), %rax
               	xorq	$0xe, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xb(%rax), %rax
               	xorq	$0xf, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xc(%rax), %rax
               	xorq	$0x10, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xd(%rax), %rax
               	xorq	$0x11, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xe(%rax), %rax
               	xorq	$0x12, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x13, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jge	<addr>
               	leaq	-0x400(%rbp), %rdx
               	leaq	(%rax,%rax,2), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	-0x200(%rbp), %rdi
               	leaq	-0x400(%rbp), %rsi
               	movl	$0x200, %edx            # imm = 0x200
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jge	<addr>
               	leaq	-0x200(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rdx
               	leaq	(%rax,%rax,2), %rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	movl	$0x18, %edx
               	leaq	-0x200(%rbp), %rdi
               	xorl	%ebx, %ebx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x18, %ebx
               	jae	<addr>
               	leaq	-0x200(%rbp), %rax
               	cmpb	$0x0, (%rax,%rbx)
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x18, %ebx
               	jb	<addr>
               	leaq	-0x200(%rbp), %rax
               	movzbq	0x18(%rax), %rax
               	cmpl	$0x48, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	leaq	-0x418(%rbp), %rax
               	movq	%r12, (%rax)
               	movq	%r14, 0x8(%rax)
               	movl	$0xdeadbeef, 0x10(%rax) # imm = 0xDEADBEEF
               	movb	$0x5a, 0x14(%rax)
               	movb	$0x0, 0x15(%rax)
               	movw	$0x0, 0x16(%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x418(%rbp), %rax
               	movq	%r12, (%rax)
               	movq	%r14, 0x8(%rax)
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r14
               	leave
               	retq
