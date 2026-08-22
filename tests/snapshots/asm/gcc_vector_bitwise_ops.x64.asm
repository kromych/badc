
gcc_vector_bitwise_ops.x64:	file format elf64-x86-64

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
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x88(%rbp), %rdx
               	leaq	-0x78(%rbp), %rsi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rdi
               	leaq	(%rdi,%rax), %r8
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rax), %r9
               	movzbq	(%r9), %r9
               	xorq	%r9, %rdi
               	movb	%dil, (%r8)
               	leaq	-0x58(%rbp), %rdi
               	leaq	(%rdi,%rax), %r8
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rax), %r9
               	movzbq	(%r9), %r9
               	andq	%r9, %rdi
               	movb	%dil, (%r8)
               	leaq	-0x48(%rbp), %rdi
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
               	leaq	-0x88(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x28(%rbp), %rsi
               	movq	(%rax), %rdi
               	movq	(%rcx), %r8
               	xorq	%r8, %rdi
               	movq	%rdi, (%rsi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x68(%rbp), %rdi
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x28(%rbp), %rsi
               	movq	(%rax), %rdi
               	movq	(%rcx), %r8
               	andq	%r8, %rdi
               	movq	%rdi, (%rsi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	andq	%rcx, %rax
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x58(%rbp), %rdi
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x28(%rbp), %rsi
               	movq	(%rax), %rdi
               	movq	(%rcx), %r8
               	orq	%r8, %rdi
               	movq	%rdi, (%rsi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	orq	%rcx, %rax
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x48(%rbp), %rdi
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	movq	(%rax), %rsi
               	movq	(%rcx), %rdi
               	xorq	%rsi, %rdi
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	xorq	%rax, %rcx
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x28(%rbp), %rsi
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rsi
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x78(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
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
               	leaq	-0x38(%rbp), %rdx
               	leaq	-0x68(%rbp), %rsi
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x88(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rsi
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x78(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
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
               	leaq	-0x38(%rbp), %rdx
               	leaq	-0x58(%rbp), %rsi
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x88(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rsi
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x78(%rbp), %rdx
               	leaq	-0x28(%rbp), %rax
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
               	leaq	-0x38(%rbp), %rdx
               	leaq	-0x48(%rbp), %rsi
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x88(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x78(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	-0x28(%rbp), %rax
               	xorq	%rsi, %rcx
               	movq	%rcx, (%rax)
               	movq	%rdx, %rcx
               	xorq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x38(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rdx
               	leaq	-0x68(%rbp), %rsi
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rax
               	movabsq	$0x8f806fa04fc02fe, %rcx # imm = 0x8F806FA04FC02FE
               	movq	%rcx, (%rax)
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0xfe, %rax
               	movl	%eax, %edx
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
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rdx
               	leaq	-0x48(%rbp), %rsi
               	leaq	(%rdx), %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	leaq	(%rsi), %rax
               	movl	$0xc8, %ecx
               	movb	%cl, (%rax)
               	movl	$0x8, %eax
               	movb	%al, 0x1(%rdx)
               	movl	$0xc7, %eax
               	movb	%al, 0x1(%rsi)
               	movl	$0xf, %eax
               	movb	%al, 0x2(%rdx)
               	movl	$0xc6, %eax
               	movb	%al, 0x2(%rsi)
               	movl	$0x16, %eax
               	movb	%al, 0x3(%rdx)
               	movl	$0xc5, %eax
               	movb	%al, 0x3(%rsi)
               	movl	$0x1d, %eax
               	movb	%al, 0x4(%rdx)
               	movl	$0xc4, %eax
               	movb	%al, 0x4(%rsi)
               	movl	$0x24, %eax
               	movb	%al, 0x5(%rdx)
               	movl	$0xc3, %eax
               	movb	%al, 0x5(%rsi)
               	movl	$0x2b, %eax
               	movb	%al, 0x6(%rdx)
               	movl	$0xc2, %eax
               	movb	%al, 0x6(%rsi)
               	movl	$0x32, %eax
               	movb	%al, 0x7(%rdx)
               	movl	$0xc1, %eax
               	movb	%al, 0x7(%rsi)
               	movl	$0x39, %eax
               	movb	%al, 0x8(%rdx)
               	movl	$0xc0, %eax
               	movb	%al, 0x8(%rsi)
               	movl	$0x40, %eax
               	movb	%al, 0x9(%rdx)
               	movl	$0xbf, %eax
               	movb	%al, 0x9(%rsi)
               	movl	$0x47, %eax
               	movb	%al, 0xa(%rdx)
               	movl	$0xbe, %eax
               	movb	%al, 0xa(%rsi)
               	movl	$0x4e, %eax
               	movb	%al, 0xb(%rdx)
               	movl	$0xbd, %eax
               	movb	%al, 0xb(%rsi)
               	movl	$0x55, %eax
               	movb	%al, 0xc(%rdx)
               	movl	$0xbc, %eax
               	movb	%al, 0xc(%rsi)
               	movl	$0x5c, %eax
               	movb	%al, 0xd(%rdx)
               	movl	$0xbb, %eax
               	movb	%al, 0xd(%rsi)
               	movl	$0x63, %eax
               	movb	%al, 0xe(%rdx)
               	movl	$0xba, %eax
               	movb	%al, 0xe(%rsi)
               	movl	$0x6a, %eax
               	movb	%al, 0xf(%rdx)
               	movl	$0xb9, %eax
               	movb	%al, 0xf(%rsi)
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x58(%rbp), %rax
               	leaq	-0x48(%rbp), %rcx
               	movq	(%rax), %r8
               	movq	0x8(%rax), %r9
               	leaq	-0x18(%rbp), %rax
               	movq	(%rcx), %rbx
               	xorq	%rbx, %r8
               	movq	%r8, (%rax)
               	movq	0x8(%rcx), %rcx
               	xorq	%r9, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x38(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rdx,%rcx), %r9
               	movzbq	(%r9), %r9
               	leaq	(%rsi,%rcx), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	%rbx, %r9
               	andq	$0xff, %r9
               	cmpq	%r9, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	addq	$0xa0, %rsp
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
