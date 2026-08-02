
gcc_vector_bitwise_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<xor_into>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rdx), %r8
               	xorq	%r8, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x190, %rsp            # imm = 0x190
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x158(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x168(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x158(%rbp), %rdx
               	leaq	-0x168(%rbp), %rsi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x128(%rbp), %rdi
               	leaq	(%rdi,%rax), %r8
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rax), %r9
               	movzbq	(%r9), %r9
               	xorq	%r9, %rdi
               	movb	%dil, (%r8)
               	leaq	-0x138(%rbp), %rdi
               	leaq	(%rdi,%rax), %r8
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rax), %r9
               	movzbq	(%r9), %r9
               	andq	%r9, %rdi
               	movb	%dil, (%r8)
               	leaq	-0x148(%rbp), %rdi
               	leaq	(%rdi,%rax), %r8
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rax), %r9
               	movzbq	(%r9), %r9
               	orq	%r9, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x10, %rax
               	jl	<addr>
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x168(%rbp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rax), %rdi
               	movq	(%rcx), %r8
               	xorq	%r8, %rdi
               	movq	%rdi, (%rsi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x128(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x168(%rbp), %rcx
               	leaq	-0x20(%rbp), %rsi
               	movq	(%rax), %rdi
               	movq	(%rcx), %r8
               	andq	%r8, %rdi
               	movq	%rdi, (%rsi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	andq	%rcx, %rax
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x138(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x168(%rbp), %rcx
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rax), %rdi
               	movq	(%rcx), %r8
               	orq	%r8, %rdi
               	movq	%rdi, (%rsi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	orq	%rcx, %rax
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x148(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rdi,%rcx), %r9
               	movzbq	(%r9), %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x168(%rbp), %rcx
               	movq	(%rax), %rsi
               	movq	(%rcx), %rdi
               	xorq	%rsi, %rdi
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	xorq	%rax, %rcx
               	leaq	-0x168(%rbp), %rax
               	leaq	-0x50(%rbp), %rsi
               	movq	(%rax), %r8
               	xorq	%r8, %rdi
               	movq	%rdi, (%rsi)
               	movq	0x8(%rax), %rax
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%rsi)
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0xe0(%rbp), %rsi
               	leaq	-0xe0(%rbp), %rcx
               	leaq	-0x168(%rbp), %rdx
               	leaq	-0x60(%rbp), %rax
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	xorq	%r8, %rdi
               	movq	%rdi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0xe0(%rbp), %rdx
               	leaq	-0x128(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	leaq	-0x158(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe0(%rbp), %rsi
               	leaq	-0xe0(%rbp), %rcx
               	leaq	-0x168(%rbp), %rdx
               	leaq	-0x70(%rbp), %rax
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	andq	%r8, %rdi
               	movq	%rdi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0xe0(%rbp), %rdx
               	leaq	-0x138(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	leaq	-0x158(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe0(%rbp), %rsi
               	leaq	-0xe0(%rbp), %rcx
               	leaq	-0x168(%rbp), %rdx
               	leaq	-0x80(%rbp), %rax
               	movq	(%rcx), %rdi
               	movq	(%rdx), %r8
               	orq	%r8, %rdi
               	movq	%rdi, (%rax)
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rdx), %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0xe0(%rbp), %rdx
               	leaq	-0x148(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0x158(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x168(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	-0x90(%rbp), %rax
               	xorq	%rsi, %rcx
               	movq	%rcx, (%rax)
               	movq	%rdx, %rcx
               	xorq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x110(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x110(%rbp), %rdx
               	leaq	-0x128(%rbp), %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rcx), %r8
               	movzbq	(%r8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0x118(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x170(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x118(%rbp), %rax
               	movabsq	$0x8f806fa04fc02fe, %rcx # imm = 0x8F806FA04FC02FE
               	movq	%rcx, (%rax)
               	leaq	-0x118(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0xfe, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x1(%rcx), %rax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x7(%rcx), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rbx
               	leaq	-0xc0(%rbp), %r12
               	leaq	(%rbx), %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	leaq	(%r12), %rax
               	movl	$0xc8, %ecx
               	movb	%cl, (%rax)
               	movl	$0x8, %eax
               	movb	%al, 0x1(%rbx)
               	movl	$0xc7, %eax
               	movb	%al, 0x1(%r12)
               	movl	$0xf, %eax
               	movb	%al, 0x2(%rbx)
               	movl	$0xc6, %eax
               	movb	%al, 0x2(%r12)
               	movl	$0x16, %eax
               	movb	%al, 0x3(%rbx)
               	movl	$0xc5, %eax
               	movb	%al, 0x3(%r12)
               	movl	$0x1d, %eax
               	movb	%al, 0x4(%rbx)
               	movl	$0xc4, %eax
               	movb	%al, 0x4(%r12)
               	movl	$0x24, %eax
               	movb	%al, 0x5(%rbx)
               	movl	$0xc3, %eax
               	movb	%al, 0x5(%r12)
               	movl	$0x2b, %eax
               	movb	%al, 0x6(%rbx)
               	movl	$0xc2, %eax
               	movb	%al, 0x6(%r12)
               	movl	$0x32, %eax
               	movb	%al, 0x7(%rbx)
               	movl	$0xc1, %eax
               	movb	%al, 0x7(%r12)
               	movl	$0x39, %eax
               	movb	%al, 0x8(%rbx)
               	movl	$0xc0, %eax
               	movb	%al, 0x8(%r12)
               	movl	$0x40, %eax
               	movb	%al, 0x9(%rbx)
               	movl	$0xbf, %eax
               	movb	%al, 0x9(%r12)
               	movl	$0x47, %eax
               	movb	%al, 0xa(%rbx)
               	movl	$0xbe, %eax
               	movb	%al, 0xa(%r12)
               	movl	$0x4e, %eax
               	movb	%al, 0xb(%rbx)
               	movl	$0xbd, %eax
               	movb	%al, 0xb(%r12)
               	movl	$0x55, %eax
               	movb	%al, 0xc(%rbx)
               	movl	$0xbc, %eax
               	movb	%al, 0xc(%r12)
               	movl	$0x5c, %eax
               	movb	%al, 0xd(%rbx)
               	movl	$0xbb, %eax
               	movb	%al, 0xd(%r12)
               	movl	$0x63, %eax
               	movb	%al, 0xe(%rbx)
               	movl	$0xba, %eax
               	movb	%al, 0xe(%r12)
               	movl	$0x6a, %eax
               	movb	%al, 0xf(%rbx)
               	movl	$0xb9, %eax
               	movb	%al, 0xf(%r12)
               	leaq	-0xd0(%rbp), %rdi
               	leaq	-0xb0(%rbp), %rsi
               	leaq	-0xc0(%rbp), %rdx
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%r12,%rcx), %r8
               	movzbq	(%r8), %r8
               	xorq	%r8, %rdi
               	andq	$0xff, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x190, %rsp            # imm = 0x190
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
