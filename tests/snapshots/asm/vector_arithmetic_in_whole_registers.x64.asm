
vector_arithmetic_in_whole_registers.x64:	file format elf64-x86-64

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

<c_ops>:
               	movapd	%xmm0, %xmm2
               	paddb	%xmm1, %xmm2
               	movapd	%xmm0, %xmm3
               	psubb	%xmm1, %xmm3
               	pxor	%xmm3, %xmm2
               	pand	%xmm1, %xmm0
               	por	%xmm2, %xmm0
               	retq

<s_ops>:
               	movapd	%xmm0, %xmm2
               	pmullw	%xmm1, %xmm2
               	psubw	%xmm1, %xmm0
               	paddw	%xmm2, %xmm0
               	retq

<i_ops>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movapd	%xmm0, %xmm2
               	paddd	%xmm1, %xmm2
               	movups	%xmm2, -0x30(%rbp)
               	psubd	%xmm1, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	movl	-0x30(%rbp), %eax
               	movl	-0x20(%rbp), %ecx
               	imulq	%rcx, %rax
               	movl	%eax, -0x10(%rbp)
               	movl	-0x2c(%rbp), %eax
               	movl	-0x1c(%rbp), %ecx
               	imulq	%rcx, %rax
               	movl	%eax, -0xc(%rbp)
               	movl	-0x28(%rbp), %eax
               	movl	-0x18(%rbp), %ecx
               	imulq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x24(%rbp), %eax
               	movl	-0x14(%rbp), %ecx
               	imulq	%rcx, %rax
               	movl	%eax, -0x4(%rbp)
               	movups	-0x10(%rbp), %xmm0
               	leave
               	retq

<u_ops>:
               	movapd	%xmm0, %xmm2
               	psubd	%xmm1, %xmm2
               	por	%xmm1, %xmm0
               	pxor	%xmm2, %xmm0
               	retq

<l_ops>:
               	movapd	%xmm0, %xmm2
               	paddq	%xmm1, %xmm2
               	pand	%xmm1, %xmm0
               	movapd	%xmm2, %xmm15
               	psubq	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	retq

<f_ops>:
               	movapd	%xmm0, %xmm2
               	mulps	%xmm1, %xmm2
               	addps	%xmm0, %xmm2
               	movapd	%xmm1, %xmm15
               	subps	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	movapd	%xmm2, %xmm15
               	divps	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	retq

<d_ops>:
               	movapd	%xmm0, %xmm2
               	subpd	%xmm1, %xmm2
               	addpd	%xmm1, %xmm0
               	movapd	%xmm2, %xmm15
               	mulpd	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	divpd	%xmm1, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf8, %rsp
               	pushq	%rbx
               	movb	$-0x64, -0xf0(%rbp)
               	movb	$0x7f, -0xe0(%rbp)
               	movb	$-0x3f, -0xef(%rbp)
               	movb	$0x6c, -0xdf(%rbp)
               	movb	$-0x1a, -0xee(%rbp)
               	movb	$0x59, -0xde(%rbp)
               	movb	$0xb, -0xed(%rbp)
               	movb	$0x46, -0xdd(%rbp)
               	movb	$0x30, -0xec(%rbp)
               	movb	$0x33, -0xdc(%rbp)
               	movb	$0x55, -0xeb(%rbp)
               	movb	$0x20, -0xdb(%rbp)
               	movb	$0x7a, -0xea(%rbp)
               	movb	$0xd, -0xda(%rbp)
               	movb	$-0x61, -0xe9(%rbp)
               	movb	$-0x6, -0xd9(%rbp)
               	movb	$-0x3c, -0xe8(%rbp)
               	movb	$-0x19, -0xd8(%rbp)
               	movb	$-0x17, -0xe7(%rbp)
               	movb	$-0x2c, -0xd7(%rbp)
               	movb	$0xe, -0xe6(%rbp)
               	movb	$-0x3f, -0xd6(%rbp)
               	movb	$0x33, -0xe5(%rbp)
               	movb	$-0x52, -0xd5(%rbp)
               	movb	$0x58, -0xe4(%rbp)
               	movb	$-0x65, -0xd4(%rbp)
               	movb	$0x7d, -0xe3(%rbp)
               	movb	$-0x78, -0xd3(%rbp)
               	movb	$-0x5e, -0xe2(%rbp)
               	movb	$0x75, -0xd2(%rbp)
               	movb	$-0x39, -0xe1(%rbp)
               	movb	$0x62, -0xd1(%rbp)
               	movw	$0x8ad0, -0xd0(%rbp)    # imm = 0x8AD0
               	movw	$0x3, -0xc0(%rbp)
               	movw	$0xadf9, -0xce(%rbp)    # imm = 0xADF9
               	movw	$0xa, -0xbe(%rbp)
               	movw	$0xd122, -0xcc(%rbp)    # imm = 0xD122
               	movw	$0x11, -0xbc(%rbp)
               	movw	$0xf44b, -0xca(%rbp)    # imm = 0xF44B
               	movw	$0x18, -0xba(%rbp)
               	movw	$0x1774, -0xc8(%rbp)    # imm = 0x1774
               	movw	$0x1f, -0xb8(%rbp)
               	movw	$0x3a9d, -0xc6(%rbp)    # imm = 0x3A9D
               	movw	$0x26, -0xb6(%rbp)
               	movw	$0x5dc6, -0xc4(%rbp)    # imm = 0x5DC6
               	movw	$0x2d, -0xb4(%rbp)
               	movw	$0x80ef, -0xc2(%rbp)    # imm = 0x80EF
               	movw	$0x34, -0xb2(%rbp)
               	movl	$0x88ca6c00, -0xb0(%rbp) # imm = 0x88CA6C00
               	movl	$0x9c40, -0xa0(%rbp)    # imm = 0x9C40
               	movl	$0xf0000000, -0x90(%rbp) # imm = 0xF0000000
               	movl	$0x12345678, -0x80(%rbp) # imm = 0x12345678
               	movl	$0x3fc00000, -0x50(%rbp) # imm = 0x3FC00000
               	movl	$0x3f000000, -0x40(%rbp) # imm = 0x3F000000
               	movl	$0x88d9ae43, -0xac(%rbp) # imm = 0x88D9AE43
               	movl	$0x9c41, -0x9c(%rbp)    # imm = 0x9C41
               	movl	$0xf0000001, -0x8c(%rbp) # imm = 0xF0000001
               	movl	$0x2468acf0, -0x7c(%rbp) # imm = 0x2468ACF0
               	movl	$0x40200000, -0x4c(%rbp) # imm = 0x40200000
               	movl	$0x3f400000, -0x3c(%rbp) # imm = 0x3F400000
               	movl	$0x88e8f086, -0xa8(%rbp) # imm = 0x88E8F086
               	movl	$0x9c42, -0x98(%rbp)    # imm = 0x9C42
               	movl	$0xf0000002, -0x88(%rbp) # imm = 0xF0000002
               	movl	$0x369d0368, -0x78(%rbp) # imm = 0x369D0368
               	movl	$0x40600000, -0x48(%rbp) # imm = 0x40600000
               	movl	$0x3f800000, -0x38(%rbp) # imm = 0x3F800000
               	movl	$0x88f832c9, -0xa4(%rbp) # imm = 0x88F832C9
               	movl	$0x9c43, -0x94(%rbp)    # imm = 0x9C43
               	movl	$0xf0000003, -0x84(%rbp) # imm = 0xF0000003
               	movl	$0x48d159e0, -0x74(%rbp) # imm = 0x48D159E0
               	movl	$0x40900000, -0x44(%rbp) # imm = 0x40900000
               	movl	$0x3fa00000, -0x34(%rbp) # imm = 0x3FA00000
               	movabsq	$0x7ffffffffffffff0, %rax # imm = 0x7FFFFFFFFFFFFFF0
               	movq	%rax, -0x70(%rbp)
               	movq	$0x10, -0x60(%rbp)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x30(%rbp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x20(%rbp)
               	movabsq	$0x7ffffffffffffff1, %rax # imm = 0x7FFFFFFFFFFFFFF1
               	movq	%rax, -0x68(%rbp)
               	movq	$0x11, -0x58(%rbp)
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x28(%rbp)
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	leaq	-0xf0(%rbp), %rbx
               	leaq	-0xe0(%rbp), %r9
               	movq	%rbx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rsi
               	leaq	-0xe0(%rbp), %rcx
               	movsbq	(%rcx,%rax), %rdx
               	addq	%rdx, %rsi
               	movsbq	%sil, %rdi
               	leaq	-0xf0(%rbp), %rsi
               	movsbq	(%rsi,%rax), %rsi
               	movq	%rsi, %r8
               	subq	%rdx, %r8
               	movsbq	%r8b, %rdx
               	xorq	%rdi, %rdx
               	movsbq	%dl, %rdx
               	movsbq	(%rcx,%rax), %rcx
               	andq	%rsi, %rcx
               	orq	%rdx, %rcx
               	leaq	-0x10(%rbp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xd0(%rbp), %rbx
               	leaq	-0xc0(%rbp), %r9
               	movq	%rbx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movups	%xmm0, -0x10(%rbp)
               	xorl	%eax, %eax
               	movswq	(%rdx,%rax,2), %rsi
               	movswq	(%rbx,%rax,2), %rdi
               	leaq	-0xc0(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	imulq	%rcx, %rdi
               	movswq	%di, %rdi
               	leaq	-0xd0(%rbp), %r8
               	movswq	(%r8,%rax,2), %r8
               	subq	%rcx, %r8
               	movswq	%r8w, %rcx
               	addq	%rdi, %rcx
               	movswq	%cx, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %r9
               	leaq	-0xa0(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	movl	-0x10(%rbp), %edx
               	movl	-0xb0(%rbp), %eax
               	movl	-0xa0(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	-0xc(%rbp), %edx
               	movl	-0xac(%rbp), %eax
               	movl	-0x9c(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movl	-0x8(%rbp), %edx
               	movl	-0xa8(%rbp), %eax
               	movl	-0x98(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movl	-0x4(%rbp), %edx
               	movl	-0xa4(%rbp), %eax
               	movl	-0x94(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	-0x90(%rbp), %r9
               	leaq	-0x80(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	movl	-0x10(%rbp), %edx
               	movl	-0x90(%rbp), %eax
               	movl	-0x80(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	-0xc(%rbp), %edx
               	movl	-0x8c(%rbp), %eax
               	movl	-0x7c(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movl	-0x8(%rbp), %edx
               	movl	-0x88(%rbp), %eax
               	movl	-0x78(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movl	-0x4(%rbp), %edx
               	movl	-0x84(%rbp), %eax
               	movl	-0x74(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	-0x70(%rbp), %r9
               	leaq	-0x60(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rdx
               	movq	-0x70(%rbp), %rax
               	movq	-0x60(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x8(%rbp), %rdx
               	movq	-0x68(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	-0x50(%rbp), %r9
               	leaq	-0x40(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	movss	-0x50(%rbp), %xmm0
               	movss	-0x40(%rbp), %xmm1
               	vmulss	%xmm1, %xmm0, %xmm1
               	vaddss	%xmm0, %xmm1, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	movss	-0x40(%rbp), %xmm2
               	movss	-0x50(%rbp), %xmm3
               	subss	%xmm3, %xmm2
               	divss	%xmm2, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movss	-0x4c(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	vmulss	%xmm1, %xmm0, %xmm1
               	vaddss	%xmm0, %xmm1, %xmm0
               	movss	-0xc(%rbp), %xmm1
               	movss	-0x3c(%rbp), %xmm2
               	movss	-0x4c(%rbp), %xmm3
               	subss	%xmm3, %xmm2
               	divss	%xmm2, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	-0x48(%rbp), %xmm0
               	movss	-0x38(%rbp), %xmm1
               	vmulss	%xmm1, %xmm0, %xmm1
               	vaddss	%xmm0, %xmm1, %xmm0
               	movss	-0x8(%rbp), %xmm1
               	movss	-0x38(%rbp), %xmm2
               	movss	-0x48(%rbp), %xmm3
               	subss	%xmm3, %xmm2
               	divss	%xmm2, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	-0x44(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	vmulss	%xmm1, %xmm0, %xmm1
               	vaddss	%xmm0, %xmm1, %xmm0
               	movss	-0x4(%rbp), %xmm1
               	movss	-0x34(%rbp), %xmm2
               	movss	-0x44(%rbp), %xmm3
               	subss	%xmm3, %xmm2
               	divss	%xmm2, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x30(%rbp), %r9
               	leaq	-0x20(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x20(%rbp), %xmm1
               	vsubsd	%xmm1, %xmm0, %xmm2
               	addsd	%xmm1, %xmm0
               	vmulsd	%xmm0, %xmm2, %xmm0
               	movsd	-0x10(%rbp), %xmm1
               	movsd	-0x20(%rbp), %xmm2
               	divsd	%xmm2, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movsd	-0x28(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	vsubsd	%xmm1, %xmm0, %xmm2
               	addsd	%xmm1, %xmm0
               	vmulsd	%xmm0, %xmm2, %xmm0
               	movsd	-0x8(%rbp), %xmm1
               	movsd	-0x18(%rbp), %xmm2
               	divsd	%xmm2, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
