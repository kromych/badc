
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
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x78(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x68(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x58(%rbp), %rdi
               	leaq	(%rdi,%rax), %rbx
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %r9
               	leaq	(%rsi,%rax), %r8
               	movzbq	(%r8), %r12
               	xorq	%r12, %r9
               	movb	%r9b, (%rbx)
               	leaq	-0x48(%rbp), %r9
               	addq	%rax, %r9
               	movzbq	(%rdi), %rbx
               	movzbq	(%r8), %r8
               	andq	%rbx, %r8
               	movb	%r8b, (%r9)
               	leaq	-0x38(%rbp), %r8
               	addq	%rax, %r8
               	movzbq	(%rdi), %rdi
               	leaq	(%rsi,%rax), %r9
               	movzbq	(%r9), %r9
               	orq	%r9, %rdi
               	movb	%dil, (%r8)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x10, %rax
               	jl	<addr>
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x18(%rbp), %rsi
               	movq	(%rax), %rdi
               	movq	(%rcx), %r8
               	xorq	%r8, %rdi
               	movq	%rdi, (%rsi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	xorq	%rcx, %rax
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
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x18(%rbp), %rsi
               	movq	(%rax), %rdi
               	movq	(%rcx), %r8
               	andq	%r8, %rdi
               	movq	%rdi, (%rsi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	andq	%rcx, %rax
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
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x18(%rbp), %rsi
               	movq	(%rax), %rdi
               	movq	(%rcx), %r8
               	orq	%r8, %rdi
               	movq	%rdi, (%rsi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	orq	%rcx, %rax
               	movq	%rax, 0x8(%rsi)
               	leaq	-0x38(%rbp), %rdi
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
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdi
               	movq	%rsi, %r8
               	xorq	%rdi, %r8
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rax), %rsi
               	xorq	%rsi, %rcx
               	leaq	-0x18(%rbp), %rsi
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
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x28(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x18(%rbp), %rax
               	movq	(%rdx), %rsi
               	movq	(%rcx), %rdi
               	xorq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rdx), %rsi
               	movq	0x8(%rcx), %rcx
               	xorq	%rsi, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
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
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x78(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x18(%rbp), %rax
               	movq	(%rdx), %rsi
               	movq	(%rcx), %rdi
               	andq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rdx), %rsi
               	movq	0x8(%rcx), %rcx
               	andq	%rsi, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
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
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rdx
               	leaq	-0x78(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x18(%rbp), %rax
               	movq	(%rdx), %rsi
               	movq	(%rcx), %rdi
               	orq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	movq	0x8(%rdx), %rsi
               	movq	0x8(%rcx), %rcx
               	orq	%rsi, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x38(%rbp), %rsi
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
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x68(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	-0x18(%rbp), %rax
               	xorq	%rsi, %rcx
               	movq	%rcx, (%rax)
               	movq	%rdx, %rcx
               	xorq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x28(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
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
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movabsq	$0x8f806fa04fc02fe, %rcx # imm = 0x8F806FA04FC02FE
               	movq	%rcx, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0xfe, %rcx
               	movl	%ecx, %ecx
               	movl	$0x1, %edi
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x2, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x7(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rsi
               	leaq	-0x48(%rbp), %rdx
               	leaq	(%rsi), %rax
               	movb	%dil, (%rax)
               	leaq	(%rdx), %rax
               	movl	$0xc8, %ecx
               	movb	%cl, (%rax)
               	movl	$0x8, %eax
               	movb	%al, 0x1(%rsi)
               	movl	$0xc7, %eax
               	movb	%al, 0x1(%rdx)
               	movl	$0xf, %eax
               	movb	%al, 0x2(%rsi)
               	movl	$0xc6, %eax
               	movb	%al, 0x2(%rdx)
               	movl	$0x16, %eax
               	movb	%al, 0x3(%rsi)
               	movl	$0xc5, %eax
               	movb	%al, 0x3(%rdx)
               	movl	$0x1d, %eax
               	movb	%al, 0x4(%rsi)
               	movl	$0xc4, %eax
               	movb	%al, 0x4(%rdx)
               	movl	$0x24, %eax
               	movb	%al, 0x5(%rsi)
               	movl	$0xc3, %eax
               	movb	%al, 0x5(%rdx)
               	movl	$0x2b, %eax
               	movb	%al, 0x6(%rsi)
               	movl	$0xc2, %eax
               	movb	%al, 0x6(%rdx)
               	movl	$0x32, %eax
               	movb	%al, 0x7(%rsi)
               	movl	$0xc1, %eax
               	movb	%al, 0x7(%rdx)
               	movl	$0x39, %eax
               	movb	%al, 0x8(%rsi)
               	movl	$0xc0, %eax
               	movb	%al, 0x8(%rdx)
               	movl	$0x40, %eax
               	movb	%al, 0x9(%rsi)
               	movl	$0xbf, %eax
               	movb	%al, 0x9(%rdx)
               	movl	$0x47, %eax
               	movb	%al, 0xa(%rsi)
               	movl	$0xbe, %eax
               	movb	%al, 0xa(%rdx)
               	movl	$0x4e, %eax
               	movb	%al, 0xb(%rsi)
               	movl	$0xbd, %eax
               	movb	%al, 0xb(%rdx)
               	movl	$0x55, %eax
               	movb	%al, 0xc(%rsi)
               	movl	$0xbc, %eax
               	movb	%al, 0xc(%rdx)
               	movl	$0x5c, %eax
               	movb	%al, 0xd(%rsi)
               	movl	$0xbb, %eax
               	movb	%al, 0xd(%rdx)
               	movl	$0x63, %eax
               	movb	%al, 0xe(%rsi)
               	movl	$0xba, %eax
               	movb	%al, 0xe(%rdx)
               	movl	$0x6a, %eax
               	movb	%al, 0xf(%rsi)
               	movl	$0xb9, %eax
               	movb	%al, 0xf(%rdx)
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rsi), %rdi
               	movq	0x8(%rsi), %r8
               	leaq	-0x18(%rbp), %rax
               	movq	(%rdx), %r9
               	xorq	%r9, %rdi
               	movq	%rdi, (%rax)
               	movq	0x8(%rdx), %rdi
               	xorq	%r8, %rdi
               	movq	%rdi, 0x8(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdi,%rcx), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rsi,%rcx), %r9
               	movzbq	(%r9), %r9
               	leaq	(%rdx,%rcx), %rbx
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
               	movq	0x8(%rsp), %r12
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%rdi, %rcx
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
