
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

<same16>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, %rsi
               	leaq	-0x10(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	leaq	(%rsi), %rdx
               	movzbq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movzbq	0x1(%rax), %rcx
               	movzbq	0x1(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	movzbq	0x2(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	movzbq	0x3(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	movzbq	0x4(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	movzbq	0x5(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	movzbq	0x6(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	movzbq	0x7(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	movzbq	0x8(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	movzbq	0x9(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	movzbq	0xa(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xb(%rax), %rcx
               	movzbq	0xb(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	movzbq	0xc(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	movzbq	0xd(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	movzbq	0xe(%rsi), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	movzbq	0xf(%rsi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x48(%rbp), %rbx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x78(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rsi
               	movslq	%ecx, %rax
               	leaq	(%rsi,%rax), %r9
               	leaq	(%rbx,%rax), %rsi
               	movzbq	(%rsi), %r8
               	leaq	(%rdx,%rax), %rdi
               	movzbq	(%rdi), %r12
               	xorq	%r12, %r8
               	movb	%r8b, (%r9)
               	leaq	-0x28(%rbp), %r8
               	addq	%rax, %r8
               	movzbq	(%rsi), %r9
               	movzbq	(%rdi), %rdi
               	andq	%r9, %rdi
               	movb	%dil, (%r8)
               	leaq	-0x18(%rbp), %rdi
               	addq	%rax, %rdi
               	movzbq	(%rsi), %rsi
               	leaq	(%rdx,%rax), %r8
               	movzbq	(%r8), %r8
               	orq	%r8, %rsi
               	movb	%sil, (%rdi)
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x58(%rbp), %rdi
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, (%rdi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x38(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x58(%rbp), %rdi
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	andq	%rsi, %rdx
               	movq	%rdx, (%rdi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	andq	%rcx, %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x28(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x58(%rbp), %rdi
               	movq	(%rax), %rdx
               	movq	(%rcx), %rsi
               	orq	%rsi, %rdx
               	movq	%rdx, (%rdi)
               	movq	0x8(%rax), %rax
               	movq	0x8(%rcx), %rcx
               	orq	%rcx, %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x78(%rbp), %rax
               	movq	(%rcx), %rsi
               	movq	(%rax), %rdx
               	xorq	%rdx, %rsi
               	movq	0x8(%rcx), %rcx
               	movq	0x8(%rax), %rdi
               	xorq	%rdi, %rcx
               	leaq	-0x58(%rbp), %rdi
               	xorq	%rsi, %rdx
               	movq	%rdx, (%rdi)
               	movq	0x8(%rax), %rax
               	xorq	%rcx, %rax
               	movq	%rax, 0x8(%rdi)
               	movq	%rbx, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	leaq	-0x68(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x58(%rbp), %rax
               	movq	(%rdi), %rdx
               	movq	(%rcx), %rsi
               	xorq	%rsi, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rcx), %rcx
               	xorq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x38(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rdi
               	leaq	-0x48(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x58(%rbp), %rax
               	movq	(%rdi), %rdx
               	movq	(%rcx), %rsi
               	andq	%rsi, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rcx), %rcx
               	andq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x28(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rdi
               	leaq	-0x48(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x78(%rbp), %rcx
               	leaq	-0x58(%rbp), %rax
               	movq	(%rdi), %rdx
               	movq	(%rcx), %rsi
               	orq	%rsi, %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rdi), %rdx
               	movq	0x8(%rcx), %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x78(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	-0x58(%rbp), %rax
               	xorq	%rsi, %rcx
               	movq	%rcx, (%rax)
               	movq	%rdx, %rcx
               	xorq	%rdi, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x68(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x38(%rbp), %rsi
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
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
               	movl	$0x1, %esi
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x2, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x7(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rdx
               	leaq	-0x88(%rbp), %rcx
               	leaq	(%rdx), %rax
               	movb	%sil, (%rax)
               	leaq	(%rcx), %rax
               	movl	$0xc8, %esi
               	movb	%sil, (%rax)
               	movl	$0x8, %eax
               	movb	%al, 0x1(%rdx)
               	movl	$0xc7, %eax
               	movb	%al, 0x1(%rcx)
               	movl	$0xf, %eax
               	movb	%al, 0x2(%rdx)
               	movl	$0xc6, %eax
               	movb	%al, 0x2(%rcx)
               	movl	$0x16, %eax
               	movb	%al, 0x3(%rdx)
               	movl	$0xc5, %eax
               	movb	%al, 0x3(%rcx)
               	movl	$0x1d, %eax
               	movb	%al, 0x4(%rdx)
               	movl	$0xc4, %eax
               	movb	%al, 0x4(%rcx)
               	movl	$0x24, %eax
               	movb	%al, 0x5(%rdx)
               	movl	$0xc3, %eax
               	movb	%al, 0x5(%rcx)
               	movl	$0x2b, %eax
               	movb	%al, 0x6(%rdx)
               	movl	$0xc2, %eax
               	movb	%al, 0x6(%rcx)
               	movl	$0x32, %eax
               	movb	%al, 0x7(%rdx)
               	movl	$0xc1, %eax
               	movb	%al, 0x7(%rcx)
               	movl	$0x39, %eax
               	movb	%al, 0x8(%rdx)
               	movl	$0xc0, %eax
               	movb	%al, 0x8(%rcx)
               	movl	$0x40, %eax
               	movb	%al, 0x9(%rdx)
               	movl	$0xbf, %eax
               	movb	%al, 0x9(%rcx)
               	movl	$0x47, %eax
               	movb	%al, 0xa(%rdx)
               	movl	$0xbe, %eax
               	movb	%al, 0xa(%rcx)
               	movl	$0x4e, %eax
               	movb	%al, 0xb(%rdx)
               	movl	$0xbd, %eax
               	movb	%al, 0xb(%rcx)
               	movl	$0x55, %eax
               	movb	%al, 0xc(%rdx)
               	movl	$0xbc, %eax
               	movb	%al, 0xc(%rcx)
               	movl	$0x5c, %eax
               	movb	%al, 0xd(%rdx)
               	movl	$0xbb, %eax
               	movb	%al, 0xd(%rcx)
               	movl	$0x63, %eax
               	movb	%al, 0xe(%rdx)
               	movl	$0xba, %eax
               	movb	%al, 0xe(%rcx)
               	movl	$0x6a, %eax
               	movb	%al, 0xf(%rdx)
               	movl	$0xb9, %eax
               	movb	%al, 0xf(%rcx)
               	leaq	-0x78(%rbp), %rsi
               	movq	(%rdx), %rdi
               	movq	0x8(%rdx), %r8
               	leaq	-0x58(%rbp), %rax
               	movq	(%rcx), %r9
               	xorq	%r9, %rdi
               	movq	%rdi, (%rax)
               	movq	0x8(%rcx), %rdi
               	xorq	%r8, %rdi
               	movq	%rdi, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x78(%rbp), %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rsi
               	leaq	(%rdi,%rsi), %r8
               	movzbq	(%r8), %r8
               	leaq	(%rdx,%rsi), %r9
               	movzbq	(%r9), %r9
               	leaq	(%rcx,%rsi), %rbx
               	movzbq	(%rbx), %rbx
               	xorq	%rbx, %r9
               	andq	$0xff, %r9
               	cmpl	%r9d, %r8d
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
