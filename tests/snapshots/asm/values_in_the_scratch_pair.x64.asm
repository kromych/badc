
values_in_the_scratch_pair.x64:	file format elf64-x86-64

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

<mix>:
               	shrq	$0x3, %rsi
               	xorq	%rsi, %rdi
               	movabsq	$-0x61c8864680b583eb, %rax # imm = 0x9E3779B97F4A7C15
               	imulq	%rdi, %rax
               	retq

<direct>:
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x80(%rsp)
               	movq	%rdx, 0x78(%rsp)
               	xorl	%r12d, %r12d
               	movq	(%rsi), %r9
               	movq	0x8(%rsi), %r8
               	movq	0x10(%rsi), %rbp
               	movq	0x18(%rsi), %rbx
               	movq	0x20(%rsi), %rcx
               	movq	0x28(%rsi), %r15
               	movq	0x30(%rsi), %r14
               	movq	0x38(%rsi), %r13
               	movq	0x40(%rsi), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x48(%rsi), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	0x50(%rsi), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0x58(%rsi), %rax
               	movq	0x60(%rsi), %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0x68(%rsi), %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0x70(%rsi), %rdi
               	movq	0x78(%rsi), %rdx
               	jmp	<addr>
               	movq	%r15, %rcx
               	addq	0xa0(%rsp), %rcx
               	movq	%r14, %r15
               	xorq	0xa8(%rsp), %r15
               	leaq	(%r13,%rdi), %r14
               	movq	0x88(%rsp), %r13
               	xorq	%rdx, %r13
               	movq	0x90(%rsp), %r10
               	addq	%r9, %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x98(%rsp), %r10
               	xorq	%r8, %r10
               	movq	%r10, 0x90(%rsp)
               	leaq	(%rax,%rbp), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0xa0(%rsp), %rax
               	xorq	%rbx, %rax
               	movq	0xa8(%rsp), %r10
               	addq	%rcx, %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	%rdi, %r10
               	xorq	%r15, %r10
               	movq	%r10, 0xa8(%rsp)
               	leaq	(%rdx,%r14), %rdi
               	movq	%rsi, %rdx
               	xorq	%r13, %rdx
               	incq	%r12
               	nop
               	cmpq	0x78(%rsp), %r12
               	jge	<addr>
               	movabsq	$-0x61c8864680b583eb, %rsi # imm = 0x9E3779B97F4A7C15
               	imulq	%r9, %rsi
               	movq	%rbx, %r9
               	andq	$0x3f, %r9
               	shrxq	%r9, %rbp, %r9
               	addq	%r8, %r9
               	movq	%rcx, %r8
               	orq	$0x1, %r8
               	movq	%rax, -0x18(%rsp)
               	movq	%rdx, -0x20(%rsp)
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r8
               	movq	-0x20(%rsp), %rdx
               	movq	-0x18(%rsp), %rax
               	xorq	%rbp, %r8
               	cmpq	%r14, %r15
               	movq	%r9, 0x38(%rsp)
               	movq	0x88(%rsp), %r9
               	movq	%r9, %r10
               	cmovbq	%r13, %r10
               	movq	0x38(%rsp), %r9
               	leaq	(%rbx,%r10), %rbp
               	movq	%r12, %rbx
               	andq	$0x7, %rbx
               	movq	0x90(%rsp), %r10
               	addq	0x98(%rsp), %r10
               	movq	0x80(%rsp), %r11
               	movq	%r10, (%r11,%rbx,8)
               	movq	%r12, %r10
               	andq	$0x3, %r10
               	nopl	(%rax,%rax)
               	cmpl	$0x1, %r10d
               	jl	<addr>
               	cmpl	$0x2, %r10d
               	jl	<addr>
               	cmpl	$0x2, %r10d
               	je	<addr>
               	movq	%rcx, %rbx
               	orq	$0x1, %rbx
               	imulq	%rax, %rbx
               	testb	$0xf, %r12b
               	jne	<addr>
               	movq	%rdx, 0x70(%rsp)
               	movq	%rdi, 0x68(%rsp)
               	movq	%rax, 0x60(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	movq	%r9, 0x50(%rsp)
               	movq	%r8, 0x58(%rsp)
               	movq	%r9, %rdi
               	movq	%r8, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	0x70(%rsp), %rdx
               	movq	0x68(%rsp), %rdi
               	movq	0x60(%rsp), %rax
               	movq	0x48(%rsp), %rsi
               	movq	0x50(%rsp), %r9
               	movq	0x58(%rsp), %r8
               	xorq	%rcx, %rsi
               	nopl	(%rax)
               	jmp	<addr>
               	movq	%rcx, %rbx
               	subq	%rax, %rbx
               	jmp	<addr>
               	movq	%rax, %r10
               	shlq	$0x3, %r10
               	leaq	(%rcx,%r10), %rbx
               	jmp	<addr>
               	movq	%rcx, %rbx
               	xorq	%rax, %rbx
               	jmp	<addr>
               	xorq	%r9, %r8
               	xorq	%rbp, %r8
               	xorq	%rbx, %r8
               	xorq	%rcx, %r8
               	xorq	%r15, %r8
               	xorq	%r14, %r8
               	xorq	%r13, %r8
               	xorq	0x88(%rsp), %r8
               	xorq	0x90(%rsp), %r8
               	xorq	0x98(%rsp), %r8
               	xorq	%rax, %r8
               	xorq	0xa0(%rsp), %r8
               	xorq	0xa8(%rsp), %r8
               	xorq	%rdi, %r8
               	xorq	%rdx, %r8
               	movq	%r8, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x88, %rsp
               	retq

<in_memory>:
               	subq	$0x88, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	movq	%rdx, %r14
               	xorl	%eax, %eax
               	leaq	0x20(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rdx)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	movq	0x48(%rsp), %rax
               	movq	0x80(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x40(%rsp)
               	movq	0x50(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x48(%rsp)
               	movq	0x58(%rsp), %rax
               	movq	0x90(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x50(%rsp)
               	movq	0x60(%rsp), %rax
               	movq	0x98(%rsp), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x58(%rsp)
               	movq	0x68(%rsp), %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0x70(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x68(%rsp)
               	movq	0x78(%rsp), %rax
               	movq	0x30(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0x80(%rsp), %rax
               	movq	0x38(%rsp), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x78(%rsp)
               	movq	0x88(%rsp), %rax
               	movq	0x40(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0x90(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x88(%rsp)
               	movq	0x98(%rsp), %rax
               	movq	0x50(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, 0x90(%rsp)
               	movq	0x58(%rsp), %rax
               	xorq	%r12, %rax
               	movq	%rax, 0x98(%rsp)
               	incq	%rbx
               	nopw	(%rax,%rax)
               	cmpq	%r14, %rbx
               	jge	<addr>
               	movq	0x20(%rsp), %rax
               	movabsq	$-0x61c8864680b583eb, %r12 # imm = 0x9E3779B97F4A7C15
               	imulq	%rax, %r12
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rax
               	andq	$0x3f, %rax
               	shrxq	%rax, %rdx, %rax
               	addq	%rcx, %rax
               	movq	%rax, 0x20(%rsp)
               	movq	0x30(%rsp), %rsi
               	movq	0x40(%rsp), %rcx
               	orq	$0x1, %rcx
               	movq	%r12, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	xorq	%rax, %rsi
               	movq	%rsi, 0x28(%rsp)
               	movq	0x38(%rsp), %rcx
               	movq	0x48(%rsp), %rax
               	movq	0x50(%rsp), %rdx
               	cmpq	%rdx, %rax
               	jae	<addr>
               	movq	0x58(%rsp), %rax
               	addq	%rcx, %rax
               	movq	%rax, 0x30(%rsp)
               	movq	%rbx, %rax
               	andq	$0x7, %rax
               	movq	0x68(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%r13,%rax,8)
               	movq	%rbx, %rax
               	andq	$0x3, %rax
               	nop
               	cmpl	$0x1, %eax
               	jl	<addr>
               	cmpl	$0x2, %eax
               	jl	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movq	0x40(%rsp), %rax
               	orq	$0x1, %rax
               	movq	0x78(%rsp), %rcx
               	imulq	%rcx, %rax
               	movq	%rax, 0x38(%rsp)
               	testb	$0xf, %bl
               	jne	<addr>
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %rsi
               	nopl	(%rax)
               	callq	<addr>
               	xorq	%rax, %r12
               	jmp	<addr>
               	movq	0x40(%rsp), %rax
               	movq	0x78(%rsp), %rcx
               	subq	%rcx, %rax
               	movq	%rax, 0x38(%rsp)
               	nop
               	jmp	<addr>
               	movq	0x40(%rsp), %rcx
               	movq	0x78(%rsp), %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	movq	%rax, 0x38(%rsp)
               	jmp	<addr>
               	movq	0x40(%rsp), %rax
               	movq	0x78(%rsp), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x38(%rsp)
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
               	jmp	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	0x20(%rsp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rdx
               	xorq	%rdx, %rcx
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x88, %rsp
               	retq

<main>:
               	subq	$0x138, %rsp            # imm = 0x138
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	movq	%rax, 0xc0(%rsp)
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	movl	$0x8, %esi
               	callq	<addr>
               	movq	%rax, 0xc8(%rsp)
               	movabsq	$0x2468acf13579bde, %rdi # imm = 0x2468ACF13579BDE
               	movl	$0x9, %esi
               	callq	<addr>
               	movq	%rax, 0xd0(%rsp)
               	movabsq	$0x369d0369d0369cd, %rdi # imm = 0x369D0369D0369CD
               	movl	$0xa, %esi
               	callq	<addr>
               	movq	%rax, 0xd8(%rsp)
               	movabsq	$0x48d159e26af37bc, %rdi # imm = 0x48D159E26AF37BC
               	movl	$0xb, %esi
               	callq	<addr>
               	movq	%rax, 0xe0(%rsp)
               	movabsq	$0x5b05b05b05b05ab, %rdi # imm = 0x5B05B05B05B05AB
               	movl	$0xc, %esi
               	callq	<addr>
               	movq	%rax, 0xe8(%rsp)
               	movabsq	$0x6d3a06d3a06d39a, %rdi # imm = 0x6D3A06D3A06D39A
               	movl	$0xd, %esi
               	callq	<addr>
               	movq	%rax, 0xf0(%rsp)
               	movabsq	$0x7f6e5d4c3b2a189, %rdi # imm = 0x7F6E5D4C3B2A189
               	movl	$0xe, %esi
               	callq	<addr>
               	movq	%rax, 0xf8(%rsp)
               	movabsq	$0x91a2b3c4d5e6f78, %rdi # imm = 0x91A2B3C4D5E6F78
               	movl	$0xf, %esi
               	callq	<addr>
               	movq	%rax, 0x100(%rsp)
               	movabsq	$0xa3d70a3d70a3d67, %rdi # imm = 0xA3D70A3D70A3D67
               	movl	$0x10, %esi
               	callq	<addr>
               	movq	%rax, 0x108(%rsp)
               	movabsq	$0xb60b60b60b60b56, %rdi # imm = 0xB60B60B60B60B56
               	movl	$0x11, %esi
               	callq	<addr>
               	movq	%rax, 0x110(%rsp)
               	movabsq	$0xc83fb72ea61d945, %rdi # imm = 0xC83FB72EA61D945
               	movl	$0x12, %esi
               	callq	<addr>
               	movq	%rax, 0x118(%rsp)
               	movabsq	$0xda740da740da734, %rdi # imm = 0xDA740DA740DA734
               	movl	$0x13, %esi
               	callq	<addr>
               	movq	%rax, 0x120(%rsp)
               	movabsq	$0xeca8641fdb97523, %rdi # imm = 0xECA8641FDB97523
               	movl	$0x14, %esi
               	callq	<addr>
               	movq	%rax, 0x128(%rsp)
               	movabsq	$0xfedcba987654312, %rdi # imm = 0xFEDCBA987654312
               	movl	$0x15, %esi
               	callq	<addr>
               	movq	%rax, 0x130(%rsp)
               	movabsq	$0x1111111111111101, %rdi # imm = 0x1111111111111101
               	movl	$0x16, %esi
               	callq	<addr>
               	movq	%rax, 0x138(%rsp)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	xorl	%ebx, %ebx
               	movq	0x10(%rsp,%rbx,8), %rdx
               	leaq	0x40(%rsp), %rdi
               	leaq	0xc0(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	0x10(%rsp,%rbx,8), %rdx
               	leaq	0x80(%rsp), %rdi
               	leaq	0xc0(%rsp), %rsi
               	callq	<addr>
               	nopl	(%rax,%rax)
               	cmpq	%rax, %r12
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	movq	0x80(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x50(%rsp), %rax
               	movq	0x90(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x58(%rsp), %rax
               	movq	0x98(%rsp), %rcx
               	nopl	(%rax,%rax)
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x60(%rsp), %rax
               	movq	0xa0(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x68(%rsp), %rax
               	movq	0xa8(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x70(%rsp), %rax
               	movq	0xb0(%rsp), %rcx
               	nopw	(%rax,%rax)
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x78(%rsp), %rax
               	movq	0xb8(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	incq	%rbx
               	nopw	(%rax,%rax)
               	cmpl	$0x6, %ebx
               	jb	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
               	leaq	0xa(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x138, %rsp            # imm = 0x138
               	retq
