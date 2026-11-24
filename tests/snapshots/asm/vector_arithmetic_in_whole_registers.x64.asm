
vector_arithmetic_in_whole_registers.x64:	file format elf64-x86-64

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

<c_ops>:
               	vpaddb	%xmm1, %xmm0, %xmm2
               	vpsubb	%xmm1, %xmm0, %xmm3
               	vpxor	%xmm3, %xmm2, %xmm2
               	vpand	%xmm1, %xmm0, %xmm0
               	vpor	%xmm0, %xmm2, %xmm0
               	retq

<s_ops>:
               	vpmullw	%xmm1, %xmm0, %xmm2
               	vpsubw	%xmm1, %xmm0, %xmm0
               	vpaddw	%xmm0, %xmm2, %xmm0
               	retq

<i_ops>:
               	vpaddd	%xmm1, %xmm0, %xmm2
               	vpsubd	%xmm1, %xmm0, %xmm0
               	vmovd	%xmm2, %eax
               	movslq	%eax, %rax
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	imulq	%rcx, %rax
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
               	vpsubd	%xmm1, %xmm0, %xmm2
               	vpor	%xmm1, %xmm0, %xmm0
               	vpxor	%xmm0, %xmm2, %xmm0
               	retq

<l_ops>:
               	vpaddq	%xmm1, %xmm0, %xmm2
               	vpand	%xmm1, %xmm0, %xmm0
               	vpsubq	%xmm0, %xmm2, %xmm0
               	retq

<f_ops>:
               	vmulps	%xmm1, %xmm0, %xmm2
               	vaddps	%xmm0, %xmm2, %xmm2
               	vsubps	%xmm0, %xmm1, %xmm0
               	vdivps	%xmm0, %xmm2, %xmm0
               	retq

<d_ops>:
               	vsubpd	%xmm1, %xmm0, %xmm2
               	vaddpd	%xmm1, %xmm0, %xmm0
               	vmulpd	%xmm0, %xmm2, %xmm0
               	vdivpd	%xmm1, %xmm0, %xmm0
               	retq

<b8_ops>:
               	vpaddb	%xmm1, %xmm0, %xmm2
               	vmovq	%xmm0, %rax
               	vmovq	%xmm1, %rcx
               	orq	%rcx, %rax
               	vmovq	%xmm2, %rcx
               	xorq	%rcx, %rax
               	movq	%rax, %xmm0
               	retq

<h8_ops>:
               	vpmullw	%xmm1, %xmm0, %xmm1
               	vpsubw	%xmm0, %xmm1, %xmm0
               	retq

<i8_ops>:
               	vpsubd	%xmm1, %xmm0, %xmm2
               	vpaddd	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm2, %rax
               	vmovq	%xmm0, %rcx
               	andq	%rcx, %rax
               	movq	%rax, %xmm0
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
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	vpermilps	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0,0,0]
               	divss	%xmm1, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm2, %xmm0
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	retq

<main>:
               	subq	$0x140, %rsp            # imm = 0x140
               	pushq	%rbx
               	movw	$0xc19c, 0x10(%rsp)     # imm = 0xC19C
               	movw	$0x6c7f, 0x20(%rsp)     # imm = 0x6C7F
               	movw	$0xbe6, 0x12(%rsp)      # imm = 0xBE6
               	movw	$0x4659, 0x22(%rsp)     # imm = 0x4659
               	movw	$0x5530, 0x14(%rsp)     # imm = 0x5530
               	movw	$0x2033, 0x24(%rsp)     # imm = 0x2033
               	movw	$0x9f7a, 0x16(%rsp)     # imm = 0x9F7A
               	movw	$0xfa0d, 0x26(%rsp)     # imm = 0xFA0D
               	movw	$0xe9c4, 0x18(%rsp)     # imm = 0xE9C4
               	movw	$0xd4e7, 0x28(%rsp)     # imm = 0xD4E7
               	movw	$0x330e, 0x1a(%rsp)     # imm = 0x330E
               	movw	$0xaec1, 0x2a(%rsp)     # imm = 0xAEC1
               	movw	$0x7d58, 0x1c(%rsp)     # imm = 0x7D58
               	movw	$0x889b, 0x2c(%rsp)     # imm = 0x889B
               	movw	$0xc7a2, 0x1e(%rsp)     # imm = 0xC7A2
               	movw	$0x6275, 0x2e(%rsp)     # imm = 0x6275
               	movl	$0xadf98ad0, 0x30(%rsp) # imm = 0xADF98AD0
               	movl	$0xa0003, 0x40(%rsp)    # imm = 0xA0003
               	movl	$0xf44bd122, 0x34(%rsp) # imm = 0xF44BD122
               	movl	$0x180011, 0x44(%rsp)   # imm = 0x180011
               	movl	$0x3a9d1774, 0x38(%rsp) # imm = 0x3A9D1774
               	movl	$0x26001f, 0x48(%rsp)   # imm = 0x26001F
               	movl	$0x80ef5dc6, 0x3c(%rsp) # imm = 0x80EF5DC6
               	movl	$0x34002d, 0x4c(%rsp)   # imm = 0x34002D
               	movl	$0x88ca6c00, 0x50(%rsp) # imm = 0x88CA6C00
               	movl	$0x9c40, 0x60(%rsp)     # imm = 0x9C40
               	movl	$0xf0000000, 0x70(%rsp) # imm = 0xF0000000
               	movl	$0x12345678, 0x80(%rsp) # imm = 0x12345678
               	movl	$0x3fc00000, 0xb0(%rsp) # imm = 0x3FC00000
               	movl	$0x3f000000, 0xc0(%rsp) # imm = 0x3F000000
               	movl	$0x88d9ae43, 0x54(%rsp) # imm = 0x88D9AE43
               	movl	$0x9c41, 0x64(%rsp)     # imm = 0x9C41
               	movl	$0xf0000001, 0x74(%rsp) # imm = 0xF0000001
               	movl	$0x2468acf0, 0x84(%rsp) # imm = 0x2468ACF0
               	movl	$0x40200000, 0xb4(%rsp) # imm = 0x40200000
               	movl	$0x3f400000, 0xc4(%rsp) # imm = 0x3F400000
               	movl	$0x88e8f086, 0x58(%rsp) # imm = 0x88E8F086
               	movl	$0x9c42, 0x68(%rsp)     # imm = 0x9C42
               	movl	$0xf0000002, 0x78(%rsp) # imm = 0xF0000002
               	movl	$0x369d0368, 0x88(%rsp) # imm = 0x369D0368
               	movl	$0x40600000, 0xb8(%rsp) # imm = 0x40600000
               	movl	$0x3f800000, 0xc8(%rsp) # imm = 0x3F800000
               	movl	$0x88f832c9, 0x5c(%rsp) # imm = 0x88F832C9
               	movl	$0x9c43, 0x6c(%rsp)     # imm = 0x9C43
               	movl	$0xf0000003, 0x7c(%rsp) # imm = 0xF0000003
               	movl	$0x48d159e0, 0x8c(%rsp) # imm = 0x48D159E0
               	movl	$0x40900000, 0xbc(%rsp) # imm = 0x40900000
               	movl	$0x3fa00000, 0xcc(%rsp) # imm = 0x3FA00000
               	movabsq	$0x7ffffffffffffff0, %rax # imm = 0x7FFFFFFFFFFFFFF0
               	movq	%rax, 0x90(%rsp)
               	movq	$0x10, 0xa0(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xd0(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xe0(%rsp)
               	movabsq	$0x7ffffffffffffff1, %rax # imm = 0x7FFFFFFFFFFFFFF1
               	movq	%rax, 0x98(%rsp)
               	movq	$0x11, 0xa8(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xd8(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0xe8(%rsp)
               	leaq	0x10(%rsp), %rbx
               	leaq	0x20(%rsp), %r9
               	movq	%rbx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, 0xf0(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x10(%rsp,%rax), %rdx
               	movsbq	0x20(%rsp,%rax), %rcx
               	addq	%rcx, %rdx
               	movsbq	%dl, %rsi
               	movsbq	0x10(%rsp,%rax), %rdx
               	movq	%rdx, %rdi
               	subq	%rcx, %rdi
               	movsbq	%dil, %rdi
               	xorq	%rdi, %rsi
               	andq	%rdx, %rcx
               	orq	%rsi, %rcx
               	movsbq	0xf0(%rsp,%rax), %rdx
               	movsbq	%cl, %rcx
               	nopl	(%rax)
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x30(%rsp), %rbx
               	leaq	0x40(%rsp), %r9
               	movq	%rbx, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, 0xf0(%rsp)
               	xorl	%eax, %eax
               	movswq	0xf0(%rsp,%rax,2), %rsi
               	movswq	0x30(%rsp,%rax,2), %rdi
               	movswq	0x40(%rsp,%rax,2), %rcx
               	imulq	%rcx, %rdi
               	movswq	%di, %rdi
               	movswq	0x30(%rsp,%rax,2), %r8
               	subq	%rcx, %r8
               	movswq	%r8w, %rcx
               	addq	%rdi, %rcx
               	movswq	%cx, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x50(%rsp), %r9
               	leaq	0x60(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	movl	0x50(%rsp), %eax
               	movl	0x60(%rsp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	movl	0x54(%rsp), %eax
               	movl	0x64(%rsp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %edx
               	movslq	%edx, %rdx
               	movl	0x58(%rsp), %eax
               	movl	0x68(%rsp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %edx
               	movslq	%edx, %rdx
               	movl	0x5c(%rsp), %eax
               	movl	0x6c(%rsp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	subq	%rcx, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	0x70(%rsp), %r9
               	leaq	0x80(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovd	%xmm0, %edx
               	movl	0x70(%rsp), %eax
               	movl	0x80(%rsp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	vpextrd	$0x1, %xmm0, %edx
               	movl	0x74(%rsp), %eax
               	movl	0x84(%rsp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %edx
               	movl	0x78(%rsp), %eax
               	movl	0x88(%rsp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %edx
               	movl	0x7c(%rsp), %eax
               	movl	0x8c(%rsp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movl	%esi, %esi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	0x90(%rsp), %r9
               	leaq	0xa0(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovq	%xmm0, %rdx
               	movq	0x90(%rsp), %rax
               	movq	0xa0(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	vpextrq	$0x1, %xmm0, %rdx
               	movq	0x98(%rsp), %rax
               	movq	0xa8(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0xb0(%rsp), %r9
               	leaq	0xc0(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movss	0xb0(%rsp), %xmm1
               	movss	0xc0(%rsp), %xmm2
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
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	movss	0xb4(%rsp), %xmm1
               	movss	0xc4(%rsp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm3
               	addss	%xmm1, %xmm3
               	vpermilps	$0x1, %xmm0, %xmm4 # xmm4 = xmm0[1,0,0,0]
               	subss	%xmm1, %xmm2
               	vdivss	%xmm2, %xmm3, %xmm1
               	ucomiss	%xmm1, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movss	0xb8(%rsp), %xmm1
               	movss	0xc8(%rsp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm3
               	addss	%xmm1, %xmm3
               	vpermilps	$0x2, %xmm0, %xmm4 # xmm4 = xmm0[2,0,0,0]
               	subss	%xmm1, %xmm2
               	vdivss	%xmm2, %xmm3, %xmm1
               	ucomiss	%xmm1, %xmm4
               	jp	<addr>
               	jne	<addr>
               	movss	0xbc(%rsp), %xmm1
               	movss	0xcc(%rsp), %xmm2
               	vmulss	%xmm2, %xmm1, %xmm3
               	addss	%xmm1, %xmm3
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	subss	%xmm1, %xmm2
               	vdivss	%xmm2, %xmm3, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	0xd0(%rsp), %r9
               	leaq	0xe0(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movsd	0xd0(%rsp), %xmm2
               	movsd	0xe0(%rsp), %xmm1
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
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	movsd	0xd8(%rsp), %xmm2
               	movsd	0xe8(%rsp), %xmm1
               	vsubsd	%xmm1, %xmm2, %xmm3
               	addsd	%xmm1, %xmm2
               	vmulsd	%xmm2, %xmm3, %xmm2
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	divsd	%xmm1, %xmm2
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movw	$0xf1c8, 0x100(%rsp)    # imm = 0xF1C8
               	movw	$0x7063, 0x108(%rsp)    # imm = 0x7063
               	movw	$0x431a, 0x102(%rsp)    # imm = 0x431A
               	movw	$0x8a7d, 0x10a(%rsp)    # imm = 0x8A7D
               	movw	$0x956c, 0x104(%rsp)    # imm = 0x956C
               	movw	$0xa497, 0x10c(%rsp)    # imm = 0xA497
               	movw	$0xe7be, 0x106(%rsp)    # imm = 0xE7BE
               	movw	$0xbeb1, 0x10e(%rsp)    # imm = 0xBEB1
               	movl	$0xe219b1e0, 0x110(%rsp) # imm = 0xE219B1E0
               	movl	$0x80007, 0x118(%rsp)   # imm = 0x80007
               	movl	$0x428b1252, 0x114(%rsp) # imm = 0x428B1252
               	movl	$0xa0009, 0x11c(%rsp)   # imm = 0xA0009
               	movl	$0x77359400, 0x120(%rsp) # imm = 0x77359400
               	movl	$0x88ca6c00, 0x128(%rsp) # imm = 0x88CA6C00
               	movl	$0x40200000, 0x130(%rsp) # imm = 0x40200000
               	movl	$0x3f000000, 0x138(%rsp) # imm = 0x3F000000
               	movl	$0x77359401, 0x124(%rsp) # imm = 0x77359401
               	movl	$0x88ca6bff, 0x12c(%rsp) # imm = 0x88CA6BFF
               	movl	$0x40600000, 0x134(%rsp) # imm = 0x40600000
               	movl	$0x3fc00000, 0x13c(%rsp) # imm = 0x3FC00000
               	leaq	0x100(%rsp), %r9
               	leaq	0x108(%rsp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	vpextrb	$0x0, %xmm0, %edx
               	movzbq	0x100(%rsp), %rax
               	movzbq	0x108(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	vpextrb	$0x1, %xmm0, %edx
               	movzbq	0x101(%rsp), %rax
               	movzbq	0x109(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %edx
               	movzbq	0x102(%rsp), %rax
               	movzbq	0x10a(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %edx
               	movzbq	0x103(%rsp), %rax
               	movzbq	0x10b(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %edx
               	movzbq	0x104(%rsp), %rax
               	movzbq	0x10c(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %edx
               	movzbq	0x105(%rsp), %rax
               	movzbq	0x10d(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %edx
               	movzbq	0x106(%rsp), %rax
               	movzbq	0x10e(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %edx
               	movzbq	0x107(%rsp), %rax
               	movzbq	0x10f(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	$0xff, %rsi
               	orq	%rcx, %rax
               	xorq	%rsi, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	0x110(%rsp), %r9
               	leaq	0x118(%rsp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	vpextrw	$0x0, %xmm0, %ecx
               	movswq	%cx, %rcx
               	movswq	0x110(%rsp), %rax
               	movswq	0x118(%rsp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	vpextrw	$0x1, %xmm0, %ecx
               	movswq	%cx, %rcx
               	movswq	0x112(%rsp), %rax
               	movswq	0x11a(%rsp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x2, %xmm0, %ecx
               	movswq	%cx, %rcx
               	movswq	0x114(%rsp), %rax
               	movswq	0x11c(%rsp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x3, %xmm0, %ecx
               	movswq	%cx, %rcx
               	movswq	0x116(%rsp), %rax
               	movswq	0x11e(%rsp), %rdx
               	imulq	%rax, %rdx
               	movswq	%dx, %rdx
               	subq	%rax, %rdx
               	movswq	%dx, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	0x128(%rsp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	vmovd	%xmm0, %edx
               	movslq	%edx, %rdx
               	movl	0x120(%rsp), %eax
               	movl	0x128(%rsp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	addq	%rcx, %rax
               	andq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	vpextrd	$0x1, %xmm0, %edx
               	movslq	%edx, %rdx
               	movl	0x124(%rsp), %eax
               	movl	0x12c(%rsp), %ecx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	addq	%rcx, %rax
               	andq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	0x130(%rsp), %r9
               	leaq	0x138(%rsp), %rax
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	movq	%rax, %r10
               	movsd	(%r10), %xmm1
               	callq	<addr>
               	movss	0x130(%rsp), %xmm2
               	movss	0x138(%rsp), %xmm1
               	subss	%xmm1, %xmm2
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	divss	%xmm1, %xmm2
               	ucomiss	%xmm2, %xmm3
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	movss	0x134(%rsp), %xmm2
               	movss	0x13c(%rsp), %xmm1
               	subss	%xmm1, %xmm2
               	vpermilps	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0,0,0]
               	divss	%xmm1, %xmm2
               	ucomiss	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x140, %rsp            # imm = 0x140
               	retq
