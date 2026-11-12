
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
               	subq	$0x10, %rsp
               	movapd	%xmm0, %xmm2
               	paddb	%xmm1, %xmm2
               	vmovq	%xmm0, %rax
               	vmovq	%xmm1, %rcx
               	orq	%rcx, %rax
               	vmovq	%xmm2, %rcx
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
               	paddd	%xmm1, %xmm0
               	vmovq	%xmm2, %rax
               	vmovq	%xmm0, %rcx
               	andq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	leave
               	retq

<f8_ops>:
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vpermilps	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0,0,0]
               	subss	%xmm3, %xmm2
               	vpermilps	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm3 # xmm3 = xmm1[1,0,0,0]
               	subss	%xmm3, %xmm0
               	vpermilps	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0,0,0]
               	divss	%xmm3, %xmm2
               	xorl	%eax, %eax
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0,0,0]
               	divss	%xmm1, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x138, %rsp            # imm = 0x138
               	pushq	%rbx
               	movb	$-0x64, -0x130(%rbp)
               	movb	$0x7f, -0x120(%rbp)
               	movb	$-0x3f, -0x12f(%rbp)
               	movb	$0x6c, -0x11f(%rbp)
               	movb	$-0x1a, -0x12e(%rbp)
               	movb	$0x59, -0x11e(%rbp)
               	movb	$0xb, -0x12d(%rbp)
               	movb	$0x46, -0x11d(%rbp)
               	movb	$0x30, -0x12c(%rbp)
               	movb	$0x33, -0x11c(%rbp)
               	movb	$0x55, -0x12b(%rbp)
               	movb	$0x20, -0x11b(%rbp)
               	movb	$0x7a, -0x12a(%rbp)
               	movb	$0xd, -0x11a(%rbp)
               	movb	$-0x61, -0x129(%rbp)
               	movb	$-0x6, -0x119(%rbp)
               	movb	$-0x3c, -0x128(%rbp)
               	movb	$-0x19, -0x118(%rbp)
               	movb	$-0x17, -0x127(%rbp)
               	movb	$-0x2c, -0x117(%rbp)
               	movb	$0xe, -0x126(%rbp)
               	movb	$-0x3f, -0x116(%rbp)
               	movb	$0x33, -0x125(%rbp)
               	movb	$-0x52, -0x115(%rbp)
               	movb	$0x58, -0x124(%rbp)
               	movb	$-0x65, -0x114(%rbp)
               	movb	$0x7d, -0x123(%rbp)
               	movb	$-0x78, -0x113(%rbp)
               	movb	$-0x5e, -0x122(%rbp)
               	movb	$0x75, -0x112(%rbp)
               	movb	$-0x39, -0x121(%rbp)
               	movb	$0x62, -0x111(%rbp)
               	movw	$0x8ad0, -0x110(%rbp)   # imm = 0x8AD0
               	movw	$0x3, -0x100(%rbp)
               	movw	$0xadf9, -0x10e(%rbp)   # imm = 0xADF9
               	movw	$0xa, -0xfe(%rbp)
               	movw	$0xd122, -0x10c(%rbp)   # imm = 0xD122
               	movw	$0x11, -0xfc(%rbp)
               	movw	$0xf44b, -0x10a(%rbp)   # imm = 0xF44B
               	movw	$0x18, -0xfa(%rbp)
               	movw	$0x1774, -0x108(%rbp)   # imm = 0x1774
               	movw	$0x1f, -0xf8(%rbp)
               	movw	$0x3a9d, -0x106(%rbp)   # imm = 0x3A9D
               	movw	$0x26, -0xf6(%rbp)
               	movw	$0x5dc6, -0x104(%rbp)   # imm = 0x5DC6
               	movw	$0x2d, -0xf4(%rbp)
               	movw	$0x80ef, -0x102(%rbp)   # imm = 0x80EF
               	movw	$0x34, -0xf2(%rbp)
               	movl	$0x88ca6c00, -0xf0(%rbp) # imm = 0x88CA6C00
               	movl	$0x9c40, -0xe0(%rbp)    # imm = 0x9C40
               	movl	$0xf0000000, -0xd0(%rbp) # imm = 0xF0000000
               	movl	$0x12345678, -0xc0(%rbp) # imm = 0x12345678
               	movl	$0x3fc00000, -0x90(%rbp) # imm = 0x3FC00000
               	movl	$0x3f000000, -0x80(%rbp) # imm = 0x3F000000
               	movl	$0x88d9ae43, -0xec(%rbp) # imm = 0x88D9AE43
               	movl	$0x9c41, -0xdc(%rbp)    # imm = 0x9C41
               	movl	$0xf0000001, -0xcc(%rbp) # imm = 0xF0000001
               	movl	$0x2468acf0, -0xbc(%rbp) # imm = 0x2468ACF0
               	movl	$0x40200000, -0x8c(%rbp) # imm = 0x40200000
               	movl	$0x3f400000, -0x7c(%rbp) # imm = 0x3F400000
               	movl	$0x88e8f086, -0xe8(%rbp) # imm = 0x88E8F086
               	movl	$0x9c42, -0xd8(%rbp)    # imm = 0x9C42
               	movl	$0xf0000002, -0xc8(%rbp) # imm = 0xF0000002
               	movl	$0x369d0368, -0xb8(%rbp) # imm = 0x369D0368
               	movl	$0x40600000, -0x88(%rbp) # imm = 0x40600000
               	movl	$0x3f800000, -0x78(%rbp) # imm = 0x3F800000
               	movl	$0x88f832c9, -0xe4(%rbp) # imm = 0x88F832C9
               	movl	$0x9c43, -0xd4(%rbp)    # imm = 0x9C43
               	movl	$0xf0000003, -0xc4(%rbp) # imm = 0xF0000003
               	movl	$0x48d159e0, -0xb4(%rbp) # imm = 0x48D159E0
               	movl	$0x40900000, -0x84(%rbp) # imm = 0x40900000
               	movl	$0x3fa00000, -0x74(%rbp) # imm = 0x3FA00000
               	movabsq	$0x7ffffffffffffff0, %rax # imm = 0x7FFFFFFFFFFFFFF0
               	movq	%rax, -0xb0(%rbp)
               	movq	$0x10, -0xa0(%rbp)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x70(%rbp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x60(%rbp)
               	movabsq	$0x7ffffffffffffff1, %rax # imm = 0x7FFFFFFFFFFFFFF1
               	movq	%rax, -0xa8(%rbp)
               	movq	$0x11, -0x98(%rbp)
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x68(%rbp)
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp)
               	leaq	-0x130(%rbp), %rbx
               	leaq	-0x120(%rbp), %r9
               	movq	%rbx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rdx
               	leaq	-0x120(%rbp), %rcx
               	movsbq	(%rcx,%rax), %rcx
               	addq	%rcx, %rdx
               	movsbq	%dl, %rsi
               	leaq	-0x130(%rbp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	movq	%rdx, %rdi
               	subq	%rcx, %rdi
               	movsbq	%dil, %rdi
               	xorq	%rdi, %rsi
               	movsbq	%sil, %rsi
               	andq	%rdx, %rcx
               	orq	%rsi, %rcx
               	leaq	-0x50(%rbp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %rbx
               	leaq	-0x100(%rbp), %r9
               	movq	%rbx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movswq	(%rdx,%rax,2), %rsi
               	movswq	(%rbx,%rax,2), %rdi
               	leaq	-0x100(%rbp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	imulq	%rcx, %rdi
               	movswq	%di, %rdi
               	leaq	-0x110(%rbp), %r8
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
               	leaq	-0xf0(%rbp), %r9
               	leaq	-0xe0(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	movl	-0xf0(%rbp), %eax
               	movl	-0xe0(%rbp), %ecx
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
               	movl	-0xec(%rbp), %eax
               	movl	-0xdc(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %edx
               	movslq	%edx, %rdx
               	movl	-0xe8(%rbp), %eax
               	movl	-0xd8(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %edx
               	movslq	%edx, %rdx
               	movl	-0xe4(%rbp), %eax
               	movl	-0xd4(%rbp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	-0xd0(%rbp), %r9
               	leaq	-0xc0(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovd	%xmm0, %edx
               	movl	-0xd0(%rbp), %eax
               	movl	-0xc0(%rbp), %ecx
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
               	movl	-0xcc(%rbp), %eax
               	movl	-0xbc(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %edx
               	movl	-0xc8(%rbp), %eax
               	movl	-0xb8(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %edx
               	movl	-0xc4(%rbp), %eax
               	movl	-0xb4(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	-0xb0(%rbp), %r9
               	leaq	-0xa0(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovq	%xmm0, %rdx
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa0(%rbp), %rcx
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
               	movq	-0xa8(%rbp), %rax
               	movq	-0x98(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	-0x90(%rbp), %r9
               	leaq	-0x80(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movss	-0x90(%rbp), %xmm1
               	movss	-0x80(%rbp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm3
               	addss	%xmm1, %xmm3
               	vpermilps	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0,0,0]
               	subss	%xmm1, %xmm2
               	vdivss	%xmm2, %xmm3, %xmm1
               	ucomiss	%xmm1, %xmm4
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movss	-0x8c(%rbp), %xmm1
               	movss	-0x7c(%rbp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm3
               	addss	%xmm1, %xmm3
               	vpermilps	$0x1, %xmm0, %xmm4 # xmm4 = xmm0[1,0,0,0]
               	subss	%xmm1, %xmm2
               	vdivss	%xmm2, %xmm3, %xmm1
               	ucomiss	%xmm1, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movss	-0x88(%rbp), %xmm1
               	movss	-0x78(%rbp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm3
               	addss	%xmm1, %xmm3
               	vpermilps	$0x2, %xmm0, %xmm4 # xmm4 = xmm0[2,0,0,0]
               	subss	%xmm1, %xmm2
               	vdivss	%xmm2, %xmm3, %xmm1
               	ucomiss	%xmm1, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movss	-0x84(%rbp), %xmm1
               	movss	-0x74(%rbp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm3
               	addss	%xmm1, %xmm3
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	subss	%xmm1, %xmm2
               	vdivss	%xmm2, %xmm3, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x70(%rbp), %r9
               	leaq	-0x60(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movsd	-0x70(%rbp), %xmm2
               	movsd	-0x60(%rbp), %xmm1
               	vsubsd	%xmm1, %xmm2, %xmm3
               	addsd	%xmm1, %xmm2
               	vmulsd	%xmm2, %xmm3, %xmm2
               	vpermilpd	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0]
               	divsd	%xmm1, %xmm2
               	ucomisd	%xmm2, %xmm3
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movsd	-0x68(%rbp), %xmm2
               	movsd	-0x58(%rbp), %xmm1
               	vsubsd	%xmm1, %xmm2, %xmm3
               	addsd	%xmm1, %xmm2
               	vmulsd	%xmm2, %xmm3, %xmm2
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	divsd	%xmm1, %xmm2
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movb	$-0x38, -0x40(%rbp)
               	movb	$0x63, -0x38(%rbp)
               	movb	$-0xf, -0x3f(%rbp)
               	movb	$0x70, -0x37(%rbp)
               	movb	$0x1a, -0x3e(%rbp)
               	movb	$0x7d, -0x36(%rbp)
               	movb	$0x43, -0x3d(%rbp)
               	movb	$-0x76, -0x35(%rbp)
               	movb	$0x6c, -0x3c(%rbp)
               	movb	$-0x69, -0x34(%rbp)
               	movb	$-0x6b, -0x3b(%rbp)
               	movb	$-0x5c, -0x33(%rbp)
               	movb	$-0x42, -0x3a(%rbp)
               	movb	$-0x4f, -0x32(%rbp)
               	movb	$-0x19, -0x39(%rbp)
               	movb	$-0x42, -0x31(%rbp)
               	movw	$0xb1e0, -0x30(%rbp)    # imm = 0xB1E0
               	movw	$0x7, -0x28(%rbp)
               	movw	$0xe219, -0x2e(%rbp)    # imm = 0xE219
               	movw	$0x8, -0x26(%rbp)
               	movw	$0x1252, -0x2c(%rbp)    # imm = 0x1252
               	movw	$0x9, -0x24(%rbp)
               	movw	$0x428b, -0x2a(%rbp)    # imm = 0x428B
               	movw	$0xa, -0x22(%rbp)
               	movl	$0x77359400, -0x20(%rbp) # imm = 0x77359400
               	movl	$0x88ca6c00, -0x18(%rbp) # imm = 0x88CA6C00
               	movl	$0x40200000, -0x10(%rbp) # imm = 0x40200000
               	movl	$0x3f000000, -0x8(%rbp) # imm = 0x3F000000
               	movl	$0x77359401, -0x1c(%rbp) # imm = 0x77359401
               	movl	$0x88ca6bff, -0x14(%rbp) # imm = 0x88CA6BFF
               	movl	$0x40600000, -0xc(%rbp) # imm = 0x40600000
               	movl	$0x3fc00000, -0x4(%rbp) # imm = 0x3FC00000
               	leaq	-0x40(%rbp), %r9
               	leaq	-0x38(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	vpextrb	$0x0, %xmm0, %edx
               	movzbq	-0x40(%rbp), %rax
               	movzbq	-0x38(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	vpextrb	$0x1, %xmm0, %edx
               	movzbq	-0x3f(%rbp), %rax
               	movzbq	-0x37(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %edx
               	movzbq	-0x3e(%rbp), %rax
               	movzbq	-0x36(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %edx
               	movzbq	-0x3d(%rbp), %rax
               	movzbq	-0x35(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %edx
               	movzbq	-0x3c(%rbp), %rax
               	movzbq	-0x34(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %edx
               	movzbq	-0x3b(%rbp), %rax
               	movzbq	-0x33(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %edx
               	movzbq	-0x3a(%rbp), %rax
               	movzbq	-0x32(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %edx
               	movzbq	-0x39(%rbp), %rax
               	movzbq	-0x31(%rbp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	-0x30(%rbp), %r9
               	leaq	-0x28(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	vpextrw	$0x0, %xmm0, %ecx
               	movswq	%cx, %rcx
               	movswq	-0x30(%rbp), %rax
               	movswq	-0x28(%rbp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	vpextrw	$0x1, %xmm0, %ecx
               	movswq	%cx, %rcx
               	movswq	-0x2e(%rbp), %rax
               	movswq	-0x26(%rbp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x2, %xmm0, %ecx
               	movswq	%cx, %rcx
               	movswq	-0x2c(%rbp), %rax
               	movswq	-0x24(%rbp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x3, %xmm0, %ecx
               	movswq	%cx, %rcx
               	movswq	-0x2a(%rbp), %rax
               	movswq	-0x22(%rbp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %r9
               	leaq	-0x18(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	movl	-0x20(%rbp), %eax
               	movl	-0x18(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	addq	%rcx, %rax
               	andq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	movl	-0x1c(%rbp), %eax
               	movl	-0x14(%rbp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	addq	%rcx, %rax
               	andq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	-0x10(%rbp), %r9
               	leaq	-0x8(%rbp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	movss	-0x10(%rbp), %xmm2
               	movss	-0x8(%rbp), %xmm1
               	subss	%xmm1, %xmm2
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	divss	%xmm1, %xmm2
               	ucomiss	%xmm2, %xmm3
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movss	-0xc(%rbp), %xmm2
               	movss	-0x4(%rbp), %xmm1
               	subss	%xmm1, %xmm2
               	vpermilps	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0,0,0]
               	divss	%xmm1, %xmm2
               	ucomiss	%xmm2, %xmm0
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
