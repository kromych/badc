
vector_abi_variadic.x64:	file format elf64-x86-64

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

<lane_sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movups	%xmm1, -0x90(%rbp,%riz)
               	movups	%xmm2, -0x80(%rbp,%riz)
               	movups	%xmm3, -0x70(%rbp,%riz)
               	movups	%xmm4, -0x60(%rbp,%riz)
               	movups	%xmm5, -0x50(%rbp,%riz)
               	movups	%xmm6, -0x40(%rbp,%riz)
               	movups	%xmm7, -0x30(%rbp,%riz)
               	xorq	%rax, %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	movq	%rax, %rcx
               	movslq	-0xd0(%rbp), %rdx
               	cmpl	%edx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdx
               	movzbq	(%rdx), %rsi
               	movzbq	0xf(%rdx), %rdx
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	movslq	-0xd0(%rbp), %rdx
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	%ecx, %rax
               	leave
               	retq

<lane_sum8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movups	%xmm1, -0x90(%rbp,%riz)
               	movups	%xmm2, -0x80(%rbp,%riz)
               	movups	%xmm3, -0x70(%rbp,%riz)
               	movups	%xmm4, -0x60(%rbp,%riz)
               	movups	%xmm5, -0x50(%rbp,%riz)
               	movups	%xmm6, -0x40(%rbp,%riz)
               	movups	%xmm7, -0x30(%rbp,%riz)
               	xorq	%rax, %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	movq	%rax, %rcx
               	movslq	-0xd0(%rbp), %rdx
               	cmpl	%edx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movzbq	(%rdx), %rsi
               	movzbq	0x7(%rdx), %rdx
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	movslq	-0xd0(%rbp), %rdx
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	%ecx, %rax
               	leave
               	retq

<interleaved>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movups	%xmm1, -0x90(%rbp,%riz)
               	movups	%xmm2, -0x80(%rbp,%riz)
               	movups	%xmm3, -0x70(%rbp,%riz)
               	movups	%xmm4, -0x60(%rbp,%riz)
               	movups	%xmm5, -0x50(%rbp,%riz)
               	movups	%xmm6, -0x40(%rbp,%riz)
               	movups	%xmm7, -0x30(%rbp,%riz)
               	xorq	%rax, %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	xorq	%r11, %r11
               	movq	%r11, %xmm0
               	movslq	-0xd0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movslq	(%rcx), %rcx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movsd	(%rdx,%riz), %xmm1
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	movq	%r10, 0x8(%r11)
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdx
               	movzbq	0x3(%rdx), %rdx
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rcx, %xmm2
               	movapd	%xmm1, %xmm15
               	movapd	%xmm2, %xmm1
               	addsd	%xmm15, %xmm1
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rdx, %xmm2
               	addsd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xd0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<bank_edge>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	movups	%xmm1, -0x90(%rbp,%riz)
               	movups	%xmm2, -0x80(%rbp,%riz)
               	movups	%xmm3, -0x70(%rbp,%riz)
               	movups	%xmm4, -0x60(%rbp,%riz)
               	movups	%xmm5, -0x50(%rbp,%riz)
               	movups	%xmm6, -0x40(%rbp,%riz)
               	movups	%xmm7, -0x30(%rbp,%riz)
               	xorq	%rax, %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	xorq	%r11, %r11
               	movq	%r11, %xmm0
               	movslq	-0xd0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movsd	(%rcx,%riz), %xmm1
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movzbq	(%rcx), %rdx
               	movzbq	0x7(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rcx, %xmm2
               	addsd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	incq	%rax
               	movslq	-0xd0(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leave
               	retq

<ramp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	(%rax), %rsi
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	leaq	(%rcx), %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x1(%rax)
               	leaq	0x2(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x2(%rax)
               	leaq	0x3(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x3(%rax)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x4, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x4(%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	leaq	0x5(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x5(%rax)
               	leaq	0x6(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x6(%rax)
               	leaq	0x7(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x7(%rax)
               	leaq	0x8(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x9, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x9(%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	leaq	0xa(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0xa(%rax)
               	leaq	0xb(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0xb(%rax)
               	leaq	0xc(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0xc(%rax)
               	leaq	0xd(%rcx), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0xd(%rax)
               	leaq	-0x20(%rbp), %rax
               	addq	$0xe, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xe(%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	addq	$0xf, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xf(%rax)
               	movq	%rax, %rcx
               	movups	(%rcx,%riz), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0x2, %ebx
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, -0x20(%rbp,%riz)
               	leaq	-0x20(%rbp), %r12
               	movl	$0x3, %edi
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp,%riz)
               	leaq	-0x10(%rbp), %r9
               	movq	%r12, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm1
               	movq	%rbx, %rdi
               	movb	$0x2, %al
               	callq	<addr>
               	cmpq	$0x26, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0xa, %ebx
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, -0xa0(%rbp,%riz)
               	leaq	-0xa0(%rbp), %r12
               	movl	$0x2, %edi
               	callq	<addr>
               	movups	%xmm0, -0x90(%rbp,%riz)
               	leaq	-0x90(%rbp), %r13
               	movl	$0x3, %edi
               	callq	<addr>
               	movups	%xmm0, -0x80(%rbp,%riz)
               	leaq	-0x80(%rbp), %r14
               	movl	$0x4, %edi
               	callq	<addr>
               	movups	%xmm0, -0x70(%rbp,%riz)
               	leaq	-0x70(%rbp), %r15
               	movl	$0x5, %edi
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp,%riz)
               	leaq	-0x60(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movl	$0x6, %edi
               	callq	<addr>
               	movups	%xmm0, -0x50(%rbp,%riz)
               	leaq	-0x50(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movl	$0x7, %edi
               	callq	<addr>
               	movups	%xmm0, -0x40(%rbp,%riz)
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x8, %edi
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp,%riz)
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movl	$0x9, %edi
               	callq	<addr>
               	movups	%xmm0, -0x20(%rbp,%riz)
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp,%riz)
               	leaq	-0x10(%rbp), %r9
               	subq	$0x20, %rsp
               	movq	0x58(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%r12, %r10
               	movups	(%r10,%riz), %xmm0
               	movq	%r13, %r10
               	movups	(%r10,%riz), %xmm1
               	movq	%r14, %r10
               	movups	(%r10,%riz), %xmm2
               	movq	%r15, %r10
               	movups	(%r10,%riz), %xmm3
               	movq	0x78(%rsp), %r10
               	movups	(%r10,%riz), %xmm4
               	movq	0x70(%rsp), %r10
               	movups	(%r10,%riz), %xmm5
               	movq	0x68(%rsp), %r10
               	movups	(%r10,%riz), %xmm6
               	movq	0x60(%rsp), %r10
               	movups	(%r10,%riz), %xmm7
               	movq	%rbx, %rdi
               	movb	$0x8, %al
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x104, %rax            # imm = 0x104
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x5, %edx
               	movb	%dl, (%rcx)
               	movl	$0x6, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x2(%rax)
               	movl	$0x8, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x9, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0xa, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0xb, %ecx
               	movb	%cl, 0x6(%rax)
               	leaq	-0x8(%rbp), %r9
               	movl	$0xc, %eax
               	movb	%al, 0x7(%r9)
               	movl	$0x1, %edi
               	movq	%r9, %r10
               	movsd	(%r10,%riz), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x2, %ebx
               	movl	$0x7, %r12d
               	movabsq	$0x3fe0000000000000, %r13 # imm = 0x3FE0000000000000
               	movl	$0xa, %edi
               	callq	<addr>
               	movups	%xmm0, -0x20(%rbp,%riz)
               	leaq	-0x20(%rbp), %r14
               	movl	$0x9, %r15d
               	movabsq	$0x3fd0000000000000, %r10 # imm = 0x3FD0000000000000
               	movq	%r10, 0x58(%rsp)
               	movl	$0x14, %edi
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp,%riz)
               	leaq	-0x10(%rbp), %r9
               	movq	%r13, %xmm0
               	movsd	0x58(%rsp), %xmm2
               	movq	%r14, %r10
               	movups	(%r10,%riz), %xmm1
               	movq	%r9, %r10
               	movups	(%r10,%riz), %xmm3
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x4, %al
               	callq	<addr>
               	movabsq	$0x404a600000000000, %rax # imm = 0x404A600000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rdx, %rdx
               	movl	$0x1, %ecx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movl	$0x9, %esi
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rsi, %xmm1
               	addsd	%xmm1, %xmm0
               	movapd	%xmm0, %xmm15
               	movq	%rdx, %xmm0
               	addsd	%xmm15, %xmm0
               	movl	$0x2, %edx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdx, %xmm1
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movl	$0xb, %esi
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rsi, %xmm2
               	addsd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	movl	$0x3, %esi
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rsi, %xmm1
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movl	$0xd, %esi
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rsi, %xmm2
               	addsd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	movl	$0x4, %esi
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rsi, %xmm1
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movl	$0xf, %esi
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rsi, %xmm2
               	addsd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	movl	$0x5, %esi
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rsi, %xmm1
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movl	$0x11, %esi
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rsi, %xmm2
               	addsd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	movl	$0x6, %edi
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdi, %xmm1
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	movl	$0x13, %eax
               	xorps	%xmm2, %xmm2
               	cvtsi2sd	%rax, %xmm2
               	addsd	%xmm2, %xmm1
               	movapd	%xmm0, %xmm14
               	addsd	%xmm1, %xmm14
               	movsd	%xmm14, 0x58(%rsp)
               	movabsq	$0x3fd0000000000000, %rsi # imm = 0x3FD0000000000000
               	leaq	-0x8(%rbp), %rax
               	leaq	(%rax), %r8
               	movb	%cl, (%r8)
               	movb	%dl, 0x1(%rax)
               	movl	$0x3, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x4, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x6(%rax)
               	movl	$0x8, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x68(%rbp), %r9
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	leaq	(%rax), %rcx
               	movl	$0x2, %r8d
               	movb	%r8b, (%rcx)
               	movl	$0x3, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x4, %ecx
               	movb	%cl, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x7, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, 0x6(%rax)
               	movl	$0x9, %ecx
               	movb	%cl, 0x7(%rax)
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	movabsq	$0x3fe8000000000000, %r8 # imm = 0x3FE8000000000000
               	leaq	-0x8(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x3, %ebx
               	movb	%bl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x4, %ebx
               	movb	%bl, 0x1(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ebx
               	movb	%bl, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x6, %ebx
               	movb	%bl, 0x3(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %ebx
               	movb	%bl, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x8, %ebx
               	movb	%bl, 0x5(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x9, %ebx
               	movb	%bl, 0x6(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xa, %ebx
               	movb	%bl, 0x7(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x48(%rbp), %rbx
               	movq	(%rax), %rax
               	movq	%rax, (%rbx)
               	leaq	-0x48(%rbp), %rbx
               	movabsq	$0x3ff0000000000000, %r12 # imm = 0x3FF0000000000000
               	leaq	-0x8(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x4, %r13d
               	movb	%r13b, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %r13d
               	movb	%r13b, 0x1(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x6, %r13d
               	movb	%r13b, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %r13d
               	movb	%r13b, 0x3(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x8, %r13d
               	movb	%r13b, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x9, %r13d
               	movb	%r13b, 0x5(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xa, %r13d
               	movb	%r13b, 0x6(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xb, %r13d
               	movb	%r13b, 0x7(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x38(%rbp), %r13
               	movq	(%rax), %rax
               	movq	%rax, (%r13)
               	leaq	-0x38(%rbp), %r13
               	movabsq	$0x3ff4000000000000, %r14 # imm = 0x3FF4000000000000
               	leaq	-0x8(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x5, %r15d
               	movb	%r15b, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x6, %r15d
               	movb	%r15b, 0x1(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %r15d
               	movb	%r15b, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x8, %r15d
               	movb	%r15b, 0x3(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x9, %r15d
               	movb	%r15b, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xa, %r15d
               	movb	%r15b, 0x5(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xb, %r15d
               	movb	%r15b, 0x6(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xc, %r15d
               	movb	%r15b, 0x7(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x28(%rbp), %r15
               	movq	(%rax), %rax
               	movq	%rax, (%r15)
               	leaq	-0x28(%rbp), %r15
               	movabsq	$0x3ff8000000000000, %r10 # imm = 0x3FF8000000000000
               	movq	%r10, 0x50(%rsp)
               	leaq	-0x8(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x6, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r11
               	movb	%r11b, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r11
               	movb	%r11b, 0x1(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x8, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r11
               	movb	%r11b, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x9, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r11
               	movb	%r11b, 0x3(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xa, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r11
               	movb	%r11b, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xb, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r11
               	movb	%r11b, 0x5(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xc, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r11
               	movb	%r11b, 0x6(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xd, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r11
               	movb	%r11b, 0x7(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x18(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	(%rax), %rax
               	movq	0x48(%rsp), %r10
               	movq	%rax, (%r10)
               	leaq	-0x18(%rbp), %rax
               	subq	$0x20, %rsp
               	movq	%r14, (%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	%r15, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rsi, %xmm0
               	movq	%rdx, %xmm2
               	movq	%r8, %xmm4
               	movq	%r12, %xmm6
               	movq	%r9, %r10
               	movsd	(%r10,%riz), %xmm1
               	movq	%rcx, %r10
               	movsd	(%r10,%riz), %xmm3
               	movq	%rbx, %r10
               	movsd	(%r10,%riz), %xmm5
               	movq	%r13, %r10
               	movsd	(%r10,%riz), %xmm7
               	movb	$0x8, %al
               	callq	<addr>
               	addq	$0x20, %rsp
               	movsd	0x58(%rsp), %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
