
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
               	movapd	%xmm0, %xmm2
               	paddd	%xmm1, %xmm2
               	psubd	%xmm1, %xmm0
               	vmovd	%xmm2, %eax
               	movslq	%eax, %rax
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	imulq	%rcx, %rax
               	xorl	%ecx, %ecx
               	vmovd	%eax, %xmm1
               	vpextrd	$0x1, %xmm2, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	imulq	%rcx, %rax
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vpextrd	$0x2, %xmm2, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	imulq	%rcx, %rax
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpextrd	$0x3, %xmm2, %eax
               	movslq	%eax, %rax
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	imulq	%rcx, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
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

<b8_ops>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	%xmm1, -0x10(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	movsd	-0x10(%rbp), %xmm1
               	paddb	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	orq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	xorq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq

<h8_ops>:
               	pmullw	%xmm0, %xmm1
               	movapd	%xmm1, %xmm15
               	psubw	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	retq

<i8_ops>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movapd	%xmm0, %xmm2
               	psubd	%xmm1, %xmm2
               	movsd	%xmm2, -0x10(%rbp)
               	paddd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	andq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq

<f8_ops>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	%xmm1, -0x10(%rbp)
               	movss	-0x8(%rbp), %xmm1
               	movss	-0x10(%rbp), %xmm0
               	vsubss	%xmm0, %xmm1, %xmm2
               	movss	-0x4(%rbp), %xmm3
               	movss	-0xc(%rbp), %xmm1
               	subss	%xmm1, %xmm3
               	divss	%xmm0, %xmm2
               	movss	%xmm2, -0x8(%rbp)
               	vdivss	%xmm1, %xmm3, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x148, %rsp            # imm = 0x148
               	pushq	%rbx
               	movb	$-0x64, -0x140(%rbp)
               	movb	$0x7f, -0x130(%rbp)
               	movb	$-0x3f, -0x13f(%rbp)
               	movb	$0x6c, -0x12f(%rbp)
               	movb	$-0x1a, -0x13e(%rbp)
               	movb	$0x59, -0x12e(%rbp)
               	movb	$0xb, -0x13d(%rbp)
               	movb	$0x46, -0x12d(%rbp)
               	movb	$0x30, -0x13c(%rbp)
               	movb	$0x33, -0x12c(%rbp)
               	movb	$0x55, -0x13b(%rbp)
               	movb	$0x20, -0x12b(%rbp)
               	movb	$0x7a, -0x13a(%rbp)
               	movb	$0xd, -0x12a(%rbp)
               	movb	$-0x61, -0x139(%rbp)
               	movb	$-0x6, -0x129(%rbp)
               	movb	$-0x3c, -0x138(%rbp)
               	movb	$-0x19, -0x128(%rbp)
               	movb	$-0x17, -0x137(%rbp)
               	movb	$-0x2c, -0x127(%rbp)
               	movb	$0xe, -0x136(%rbp)
               	movb	$-0x3f, -0x126(%rbp)
               	movb	$0x33, -0x135(%rbp)
               	movb	$-0x52, -0x125(%rbp)
               	movb	$0x58, -0x134(%rbp)
               	movb	$-0x65, -0x124(%rbp)
               	movb	$0x7d, -0x133(%rbp)
               	movb	$-0x78, -0x123(%rbp)
               	movb	$-0x5e, -0x132(%rbp)
               	movb	$0x75, -0x122(%rbp)
               	movb	$-0x39, -0x131(%rbp)
               	movb	$0x62, -0x121(%rbp)
               	movw	$0x8ad0, -0x120(%rbp)   # imm = 0x8AD0
               	movw	$0x3, -0x110(%rbp)
               	movw	$0xadf9, -0x11e(%rbp)   # imm = 0xADF9
               	movw	$0xa, -0x10e(%rbp)
               	movw	$0xd122, -0x11c(%rbp)   # imm = 0xD122
               	movw	$0x11, -0x10c(%rbp)
               	movw	$0xf44b, -0x11a(%rbp)   # imm = 0xF44B
               	movw	$0x18, -0x10a(%rbp)
               	movw	$0x1774, -0x118(%rbp)   # imm = 0x1774
               	movw	$0x1f, -0x108(%rbp)
               	movw	$0x3a9d, -0x116(%rbp)   # imm = 0x3A9D
               	movw	$0x26, -0x106(%rbp)
               	movw	$0x5dc6, -0x114(%rbp)   # imm = 0x5DC6
               	movw	$0x2d, -0x104(%rbp)
               	movw	$0x80ef, -0x112(%rbp)   # imm = 0x80EF
               	movw	$0x34, -0x102(%rbp)
               	movl	$0x88ca6c00, -0x100(%rbp) # imm = 0x88CA6C00
               	movl	$0x9c40, -0xf0(%rbp)    # imm = 0x9C40
               	movl	$0xf0000000, -0xe0(%rbp) # imm = 0xF0000000
               	movl	$0x12345678, -0xd0(%rbp) # imm = 0x12345678
               	movl	$0x3fc00000, -0xa0(%rbp) # imm = 0x3FC00000
               	movl	$0x3f000000, -0x90(%rbp) # imm = 0x3F000000
               	movl	$0x88d9ae43, -0xfc(%rbp) # imm = 0x88D9AE43
               	movl	$0x9c41, -0xec(%rbp)    # imm = 0x9C41
               	movl	$0xf0000001, -0xdc(%rbp) # imm = 0xF0000001
               	movl	$0x2468acf0, -0xcc(%rbp) # imm = 0x2468ACF0
               	movl	$0x40200000, -0x9c(%rbp) # imm = 0x40200000
               	movl	$0x3f400000, -0x8c(%rbp) # imm = 0x3F400000
               	movl	$0x88e8f086, -0xf8(%rbp) # imm = 0x88E8F086
               	movl	$0x9c42, -0xe8(%rbp)    # imm = 0x9C42
               	movl	$0xf0000002, -0xd8(%rbp) # imm = 0xF0000002
               	movl	$0x369d0368, -0xc8(%rbp) # imm = 0x369D0368
               	movl	$0x40600000, -0x98(%rbp) # imm = 0x40600000
               	movl	$0x3f800000, -0x88(%rbp) # imm = 0x3F800000
               	movl	$0x88f832c9, -0xf4(%rbp) # imm = 0x88F832C9
               	movl	$0x9c43, -0xe4(%rbp)    # imm = 0x9C43
               	movl	$0xf0000003, -0xd4(%rbp) # imm = 0xF0000003
               	movl	$0x48d159e0, -0xc4(%rbp) # imm = 0x48D159E0
               	movl	$0x40900000, -0x94(%rbp) # imm = 0x40900000
               	movl	$0x3fa00000, -0x84(%rbp) # imm = 0x3FA00000
               	movabsq	$0x7ffffffffffffff0, %rax # imm = 0x7FFFFFFFFFFFFFF0
               	movq	%rax, -0xc0(%rbp)
               	movq	$0x10, -0xb0(%rbp)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x80(%rbp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x70(%rbp)
               	movabsq	$0x7ffffffffffffff1, %rax # imm = 0x7FFFFFFFFFFFFFF1
               	movq	%rax, -0xb8(%rbp)
               	movq	$0x11, -0xa8(%rbp)
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x78(%rbp)
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x68(%rbp)
               	leaq	-0x140(%rbp), %rbx
               	leaq	-0x130(%rbp), %r9
               	movq	%rbx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x60(%rbp)
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rsi
               	leaq	-0x130(%rbp), %rcx
               	movsbq	(%rcx,%rax), %rdx
               	addq	%rdx, %rsi
               	movsbq	%sil, %rdi
               	leaq	-0x140(%rbp), %rsi
               	movsbq	(%rsi,%rax), %rsi
               	movq	%rsi, %r8
               	subq	%rdx, %r8
               	movsbq	%r8b, %rdx
               	xorq	%rdi, %rdx
               	movsbq	%dl, %rdx
               	movsbq	(%rcx,%rax), %rcx
               	andq	%rsi, %rcx
               	orq	%rdx, %rcx
               	leaq	-0x60(%rbp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x120(%rbp), %rbx
               	leaq	-0x110(%rbp), %r9
               	movq	%rbx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	-0x60(%rbp), %rdx
               	movups	%xmm0, -0x60(%rbp)
               	xorl	%eax, %eax
               	movswq	(%rdx,%rax,2), %rsi
               	movswq	(%rbx,%rax,2), %rdi
               	leaq	-0x110(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	imulq	%rcx, %rdi
               	movswq	%di, %rdi
               	leaq	-0x120(%rbp), %r8
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
               	leaq	-0x100(%rbp), %r9
               	leaq	-0xf0(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	movl	-0x100(%rbp), %eax
               	movl	-0xf0(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	movl	-0xfc(%rbp), %eax
               	movl	-0xec(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %edx
               	movslq	%edx, %rdx
               	movl	-0xf8(%rbp), %eax
               	movl	-0xe8(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %edx
               	movslq	%edx, %rdx
               	movl	-0xf4(%rbp), %eax
               	movl	-0xe4(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	-0xe0(%rbp), %r9
               	leaq	-0xd0(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovd	%xmm0, %edx
               	movl	-0xe0(%rbp), %eax
               	movl	-0xd0(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	vpextrd	$0x1, %xmm0, %edx
               	movl	-0xdc(%rbp), %eax
               	movl	-0xcc(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %edx
               	movl	-0xd8(%rbp), %eax
               	movl	-0xc8(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %edx
               	movl	-0xd4(%rbp), %eax
               	movl	-0xc4(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	-0xc0(%rbp), %r9
               	leaq	-0xb0(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovq	%xmm0, %rdx
               	movq	-0xc0(%rbp), %rax
               	movq	-0xb0(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	vpextrq	$0x1, %xmm0, %rdx
               	movq	-0xb8(%rbp), %rax
               	movq	-0xa8(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	-0xa0(%rbp), %r9
               	leaq	-0x90(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movss	-0xa0(%rbp), %xmm1
               	movss	-0x90(%rbp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm2
               	vaddss	%xmm1, %xmm2, %xmm1
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	movss	-0x90(%rbp), %xmm3
               	movss	-0xa0(%rbp), %xmm4
               	subss	%xmm4, %xmm3
               	divss	%xmm3, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movss	-0x9c(%rbp), %xmm1
               	movss	-0x8c(%rbp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm2
               	vaddss	%xmm1, %xmm2, %xmm1
               	vpermilps	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0,0,0]
               	movss	-0x8c(%rbp), %xmm3
               	movss	-0x9c(%rbp), %xmm4
               	subss	%xmm4, %xmm3
               	divss	%xmm3, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	-0x98(%rbp), %xmm1
               	movss	-0x88(%rbp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm2
               	vaddss	%xmm1, %xmm2, %xmm1
               	vpermilps	$0x2, %xmm0, %xmm2 # xmm2 = xmm0[2,0,0,0]
               	movss	-0x88(%rbp), %xmm3
               	movss	-0x98(%rbp), %xmm4
               	subss	%xmm4, %xmm3
               	divss	%xmm3, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	-0x94(%rbp), %xmm1
               	movss	-0x84(%rbp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm2
               	vaddss	%xmm1, %xmm2, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movss	-0x84(%rbp), %xmm2
               	movss	-0x94(%rbp), %xmm3
               	subss	%xmm3, %xmm2
               	divss	%xmm2, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x80(%rbp), %r9
               	leaq	-0x70(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movsd	-0x80(%rbp), %xmm1
               	movsd	-0x70(%rbp), %xmm2
               	vsubsd	%xmm2, %xmm1, %xmm3
               	addsd	%xmm2, %xmm1
               	vmulsd	%xmm1, %xmm3, %xmm1
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movsd	-0x70(%rbp), %xmm3
               	divsd	%xmm3, %xmm1
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movsd	-0x78(%rbp), %xmm1
               	movsd	-0x68(%rbp), %xmm2
               	vsubsd	%xmm2, %xmm1, %xmm3
               	addsd	%xmm2, %xmm1
               	vmulsd	%xmm1, %xmm3, %xmm1
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movsd	-0x68(%rbp), %xmm2
               	divsd	%xmm2, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movb	$-0x38, -0x48(%rbp)
               	movb	$0x63, -0x40(%rbp)
               	movb	$-0xf, -0x47(%rbp)
               	movb	$0x70, -0x3f(%rbp)
               	movb	$0x1a, -0x46(%rbp)
               	movb	$0x7d, -0x3e(%rbp)
               	movb	$0x43, -0x45(%rbp)
               	movb	$-0x76, -0x3d(%rbp)
               	movb	$0x6c, -0x44(%rbp)
               	movb	$-0x69, -0x3c(%rbp)
               	movb	$-0x6b, -0x43(%rbp)
               	movb	$-0x5c, -0x3b(%rbp)
               	movb	$-0x42, -0x42(%rbp)
               	movb	$-0x4f, -0x3a(%rbp)
               	movb	$-0x19, -0x41(%rbp)
               	movb	$-0x42, -0x39(%rbp)
               	movw	$0xb1e0, -0x38(%rbp)    # imm = 0xB1E0
               	movw	$0x7, -0x30(%rbp)
               	movw	$0xe219, -0x36(%rbp)    # imm = 0xE219
               	movw	$0x8, -0x2e(%rbp)
               	movw	$0x1252, -0x34(%rbp)    # imm = 0x1252
               	movw	$0x9, -0x2c(%rbp)
               	movw	$0x428b, -0x32(%rbp)    # imm = 0x428B
               	movw	$0xa, -0x2a(%rbp)
               	movl	$0x77359400, -0x28(%rbp) # imm = 0x77359400
               	movl	$0x88ca6c00, -0x20(%rbp) # imm = 0x88CA6C00
               	movl	$0x40200000, -0x18(%rbp) # imm = 0x40200000
               	movl	$0x3f000000, -0x10(%rbp) # imm = 0x3F000000
               	movl	$0x77359401, -0x24(%rbp) # imm = 0x77359401
               	movl	$0x88ca6bff, -0x1c(%rbp) # imm = 0x88CA6BFF
               	movl	$0x40600000, -0x14(%rbp) # imm = 0x40600000
               	movl	$0x3fc00000, -0xc(%rbp) # imm = 0x3FC00000
               	leaq	-0x48(%rbp), %r9
               	leaq	-0x40(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	movzbq	-0x48(%rbp), %rax
               	movzbq	-0x40(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movzbq	-0x7(%rbp), %rdx
               	movzbq	-0x47(%rbp), %rax
               	movzbq	-0x3f(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movzbq	-0x6(%rbp), %rdx
               	movzbq	-0x46(%rbp), %rax
               	movzbq	-0x3e(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rdx
               	movzbq	-0x45(%rbp), %rax
               	movzbq	-0x3d(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movzbq	-0x4(%rbp), %rdx
               	movzbq	-0x44(%rbp), %rax
               	movzbq	-0x3c(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movzbq	-0x3(%rbp), %rdx
               	movzbq	-0x43(%rbp), %rax
               	movzbq	-0x3b(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movzbq	-0x2(%rbp), %rdx
               	movzbq	-0x42(%rbp), %rax
               	movzbq	-0x3a(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	movzbq	-0x1(%rbp), %rdx
               	movzbq	-0x41(%rbp), %rax
               	movzbq	-0x39(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	-0x38(%rbp), %r9
               	leaq	-0x30(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	movswq	-0x8(%rbp), %rcx
               	movswq	-0x38(%rbp), %rax
               	movswq	-0x30(%rbp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movswq	-0x6(%rbp), %rcx
               	movswq	-0x36(%rbp), %rax
               	movswq	-0x2e(%rbp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpl	%eax, %ecx
               	jne	<addr>
               	movswq	-0x4(%rbp), %rcx
               	movswq	-0x34(%rbp), %rax
               	movswq	-0x2c(%rbp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpl	%eax, %ecx
               	jne	<addr>
               	movswq	-0x2(%rbp), %rcx
               	movswq	-0x32(%rbp), %rax
               	movswq	-0x2a(%rbp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpl	%eax, %ecx
               	jne	<addr>
               	leaq	-0x28(%rbp), %r9
               	leaq	-0x20(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %edx
               	movl	-0x28(%rbp), %eax
               	movl	-0x20(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	addq	%rcx, %rax
               	andq	%rsi, %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	-0x4(%rbp), %edx
               	movl	-0x24(%rbp), %eax
               	movl	-0x1c(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	addq	%rcx, %rax
               	andq	%rsi, %rax
               	cmpl	%eax, %edx
               	jne	<addr>
               	leaq	-0x18(%rbp), %r9
               	leaq	-0x10(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	movss	-0x18(%rbp), %xmm1
               	movss	-0x10(%rbp), %xmm0
               	subss	%xmm0, %xmm1
               	movss	-0x8(%rbp), %xmm2
               	divss	%xmm0, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movss	-0x14(%rbp), %xmm1
               	movss	-0xc(%rbp), %xmm0
               	subss	%xmm0, %xmm1
               	movss	-0x4(%rbp), %xmm2
               	divss	%xmm0, %xmm1
               	ucomiss	%xmm1, %xmm2
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
