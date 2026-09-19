
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
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	xorl	%eax, %eax
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
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	xorl	%eax, %eax
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
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	xorl	%r11d, %r11d
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
               	movsd	(%rdx), %xmm1
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
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	xorl	%r11d, %r11d
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
               	movsd	(%rcx), %xmm1
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
               	leaq	-0x20(%rbp), %rcx
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rcx)
               	leaq	0x1(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x1(%rcx)
               	leaq	0x2(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x2(%rcx)
               	leaq	0x3(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x3(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	addq	$0x4, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x4(%rcx)
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	leaq	0x5(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x5(%rcx)
               	leaq	0x6(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x6(%rcx)
               	leaq	0x7(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x7(%rcx)
               	leaq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	movb	%dl, 0x8(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	addq	$0x9, %rax
               	andq	$0xff, %rax
               	movb	%al, 0x9(%rcx)
               	movq	%rdi, %rdx
               	andq	$0xff, %rdx
               	leaq	0xa(%rdx), %rax
               	andq	$0xff, %rax
               	movb	%al, 0xa(%rcx)
               	leaq	0xb(%rdx), %rax
               	andq	$0xff, %rax
               	movb	%al, 0xb(%rcx)
               	leaq	0xc(%rdx), %rax
               	andq	$0xff, %rax
               	movb	%al, 0xc(%rcx)
               	leaq	0xd(%rdx), %rax
               	andq	$0xff, %rax
               	movb	%al, 0xd(%rcx)
               	leaq	-0x20(%rbp), %rax
               	leaq	0xe(%rdx), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xe(%rax)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	addq	$0xf, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0xf(%rax)
               	movq	%rax, %rcx
               	movups	(%rcx), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x2, %ebx
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r12
               	movl	$0x3, %edi
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %r9
               	movq	%r12, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	movq	%rbx, %rdi
               	movb	$0x2, %al
               	callq	<addr>
               	cmpq	$0x26, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xa, %ebx
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0xa0(%rbp), %r12
               	movl	$0x2, %edi
               	callq	<addr>
               	movups	%xmm0, -0x90(%rbp)
               	leaq	-0x90(%rbp), %r13
               	movl	$0x3, %edi
               	callq	<addr>
               	movups	%xmm0, -0x80(%rbp)
               	leaq	-0x80(%rbp), %r14
               	movl	$0x4, %edi
               	callq	<addr>
               	movups	%xmm0, -0x70(%rbp)
               	leaq	-0x70(%rbp), %r15
               	movl	$0x5, %edi
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x60(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movl	$0x6, %edi
               	callq	<addr>
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x50(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movl	$0x7, %edi
               	callq	<addr>
               	movups	%xmm0, -0x40(%rbp)
               	leaq	-0x40(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x8, %edi
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movl	$0x9, %edi
               	callq	<addr>
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
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
               	movups	(%r10), %xmm0
               	movq	%r13, %r10
               	movups	(%r10), %xmm1
               	movq	%r14, %r10
               	movups	(%r10), %xmm2
               	movq	%r15, %r10
               	movups	(%r10), %xmm3
               	movq	0x78(%rsp), %r10
               	movups	(%r10), %xmm4
               	movq	0x70(%rsp), %r10
               	movups	(%r10), %xmm5
               	movq	0x68(%rsp), %r10
               	movups	(%r10), %xmm6
               	movq	0x60(%rsp), %r10
               	movups	(%r10), %xmm7
               	movq	%rbx, %rdi
               	movb	$0x8, %al
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x104, %rax            # imm = 0x104
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movb	$0x5, (%rax)
               	movb	$0x6, 0x1(%rax)
               	movb	$0x7, 0x2(%rax)
               	movb	$0x8, 0x3(%rax)
               	movb	$0x9, 0x4(%rax)
               	movb	$0xa, 0x5(%rax)
               	movb	$0xb, 0x6(%rax)
               	leaq	-0x8(%rbp), %r9
               	movb	$0xc, 0x7(%r9)
               	movl	$0x1, %edi
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2, %ebx
               	movl	$0x7, %r12d
               	movabsq	$0x3fe0000000000000, %r13 # imm = 0x3FE0000000000000
               	movl	$0xa, %edi
               	callq	<addr>
               	movups	%xmm0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r14
               	movl	$0x9, %r15d
               	movabsq	$0x3fd0000000000000, %r10 # imm = 0x3FD0000000000000
               	movq	%r10, 0x58(%rsp)
               	movl	$0x14, %edi
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	leaq	-0x10(%rbp), %r9
               	movq	%r13, %xmm0
               	movsd	0x58(%rsp), %xmm2
               	movq	%r14, %r10
               	movups	(%r10), %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm3
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edx, %edx
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
               	movb	%cl, (%rax)
               	movb	%dl, 0x1(%rax)
               	movb	$0x3, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movb	$0x4, 0x3(%rax)
               	movb	$0x5, 0x4(%rax)
               	movb	$0x6, 0x5(%rax)
               	movb	$0x7, 0x6(%rax)
               	movb	$0x8, 0x7(%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x68(%rbp), %r9
               	movq	(%rax), %rcx
               	movq	%rcx, (%r9)
               	movabsq	$0x3fe0000000000000, %rdx # imm = 0x3FE0000000000000
               	movb	$0x2, (%rax)
               	movb	$0x3, 0x1(%rax)
               	movb	$0x4, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movb	$0x5, 0x3(%rax)
               	movb	$0x6, 0x4(%rax)
               	movb	$0x7, 0x5(%rax)
               	leaq	-0x8(%rbp), %rax
               	movb	$0x8, 0x6(%rax)
               	movb	$0x9, 0x7(%rax)
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	movabsq	$0x3fe8000000000000, %rax # imm = 0x3FE8000000000000
               	leaq	-0x8(%rbp), %r8
               	movb	$0x3, (%r8)
               	leaq	-0x8(%rbp), %r8
               	movb	$0x4, 0x1(%r8)
               	leaq	-0x8(%rbp), %r8
               	movb	$0x5, 0x2(%r8)
               	leaq	-0x8(%rbp), %r8
               	movb	$0x6, 0x3(%r8)
               	leaq	-0x8(%rbp), %r8
               	movb	$0x7, 0x4(%r8)
               	leaq	-0x8(%rbp), %r8
               	movb	$0x8, 0x5(%r8)
               	leaq	-0x8(%rbp), %r8
               	movb	$0x9, 0x6(%r8)
               	leaq	-0x8(%rbp), %r8
               	movb	$0xa, 0x7(%r8)
               	leaq	-0x8(%rbp), %r8
               	leaq	-0x48(%rbp), %rbx
               	movq	(%r8), %r8
               	movq	%r8, (%rbx)
               	leaq	-0x48(%rbp), %r8
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	leaq	-0x8(%rbp), %r12
               	movb	$0x4, (%r12)
               	leaq	-0x8(%rbp), %r12
               	movb	$0x5, 0x1(%r12)
               	leaq	-0x8(%rbp), %r12
               	movb	$0x6, 0x2(%r12)
               	leaq	-0x8(%rbp), %r12
               	movb	$0x7, 0x3(%r12)
               	leaq	-0x8(%rbp), %r12
               	movb	$0x8, 0x4(%r12)
               	leaq	-0x8(%rbp), %r12
               	movb	$0x9, 0x5(%r12)
               	leaq	-0x8(%rbp), %r12
               	movb	$0xa, 0x6(%r12)
               	leaq	-0x8(%rbp), %r12
               	movb	$0xb, 0x7(%r12)
               	leaq	-0x8(%rbp), %r12
               	leaq	-0x38(%rbp), %r13
               	movq	(%r12), %r12
               	movq	%r12, (%r13)
               	leaq	-0x38(%rbp), %r12
               	movabsq	$0x3ff4000000000000, %r13 # imm = 0x3FF4000000000000
               	leaq	-0x8(%rbp), %r14
               	movb	$0x5, (%r14)
               	leaq	-0x8(%rbp), %r14
               	movb	$0x6, 0x1(%r14)
               	leaq	-0x8(%rbp), %r14
               	movb	$0x7, 0x2(%r14)
               	leaq	-0x8(%rbp), %r14
               	movb	$0x8, 0x3(%r14)
               	leaq	-0x8(%rbp), %r14
               	movb	$0x9, 0x4(%r14)
               	leaq	-0x8(%rbp), %r14
               	movb	$0xa, 0x5(%r14)
               	leaq	-0x8(%rbp), %r14
               	movb	$0xb, 0x6(%r14)
               	leaq	-0x8(%rbp), %r14
               	movb	$0xc, 0x7(%r14)
               	leaq	-0x8(%rbp), %r14
               	leaq	-0x28(%rbp), %r15
               	movq	(%r14), %r14
               	movq	%r14, (%r15)
               	leaq	-0x28(%rbp), %r14
               	movabsq	$0x3ff8000000000000, %r15 # imm = 0x3FF8000000000000
               	leaq	-0x8(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movb	$0x6, (%r10)
               	leaq	-0x8(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movb	$0x7, 0x1(%r10)
               	leaq	-0x8(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movb	$0x8, 0x2(%r10)
               	leaq	-0x8(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movb	$0x9, 0x3(%r10)
               	leaq	-0x8(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movb	$0xa, 0x4(%r10)
               	leaq	-0x8(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movb	$0xb, 0x5(%r10)
               	leaq	-0x8(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movb	$0xc, 0x6(%r10)
               	leaq	-0x8(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x50(%rsp), %r10
               	movb	$0xd, 0x7(%r10)
               	leaq	-0x8(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	leaq	-0x18(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x50(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x48(%rsp), %r10
               	movq	0x50(%rsp), %r11
               	movq	%r11, (%r10)
               	leaq	-0x18(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movq	%r15, 0x10(%rsp)
               	movq	%r14, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x70(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rsi, %xmm0
               	movq	%rdx, %xmm2
               	movq	%rax, %xmm4
               	movq	%rbx, %xmm6
               	movq	%r9, %r10
               	movsd	(%r10), %xmm1
               	movq	%rcx, %r10
               	movsd	(%r10), %xmm3
               	movq	%r8, %r10
               	movsd	(%r10), %xmm5
               	movq	%r12, %r10
               	movsd	(%r10), %xmm7
               	movb	$0x8, %al
               	callq	<addr>
               	addq	$0x20, %rsp
               	movsd	0x58(%rsp), %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
