
vector_arithmetic_in_ymm_registers.x64:	file format elf64-x86-64

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
               	vpaddb	%ymm1, %ymm0, %ymm2
               	vpsubb	%ymm1, %ymm0, %ymm3
               	vpxor	%ymm3, %ymm2, %ymm2
               	vpand	%ymm1, %ymm0, %ymm0
               	vpor	%ymm0, %ymm2, %ymm0
               	retq

<s_ops>:
               	vpmullw	%ymm1, %ymm0, %ymm2
               	vpsubw	%ymm1, %ymm0, %ymm0
               	vpaddw	%ymm0, %ymm2, %ymm0
               	retq

<i_ops>:
               	vpaddd	%ymm1, %ymm0, %ymm2
               	vpsubd	%ymm1, %ymm0, %ymm0
               	vpxor	%ymm0, %ymm2, %ymm0
               	retq

<u_ops>:
               	vpsubd	%ymm1, %ymm0, %ymm2
               	vpor	%ymm1, %ymm0, %ymm0
               	vpxor	%ymm0, %ymm2, %ymm0
               	retq

<l_ops>:
               	vpaddq	%ymm1, %ymm0, %ymm2
               	vpand	%ymm1, %ymm0, %ymm0
               	vpsubq	%ymm0, %ymm2, %ymm0
               	retq

<f_ops>:
               	vmulps	%ymm1, %ymm0, %ymm2
               	vaddps	%ymm0, %ymm2, %ymm2
               	vsubps	%ymm0, %ymm1, %ymm0
               	vdivps	%ymm0, %ymm2, %ymm0
               	retq

<d_ops>:
               	vsubpd	%ymm1, %ymm0, %ymm2
               	vaddpd	%ymm1, %ymm0, %ymm0
               	vmulpd	%ymm0, %ymm2, %ymm0
               	vdivpd	%ymm1, %ymm0, %ymm0
               	retq

<touch>:
               	movl	<rip>, %eax # <addr>
               	addq	%rdi, %rax
               	movl	%eax, <rip> # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x480, %rsp            # imm = 0x480
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x400, %rsp            # imm = 0x400
               	andq	$-0x20, %rsp
               	xorl	%eax, %eax
               	leaq	(%rsp), %rcx
               	imulq	$0x25, %rax, %rdx
               	subq	$0x64, %rdx
               	movb	%dl, (%rcx,%rax)
               	leaq	0x20(%rsp), %rcx
               	movl	$0x7f, %edx
               	imulq	$0x13, %rax, %rsi
               	subq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movw	$0x8ad0, 0x40(%rsp)     # imm = 0x8AD0
               	movw	$0x3, 0x60(%rsp)
               	movw	$0xadf9, 0x42(%rsp)     # imm = 0xADF9
               	movw	$0xa, 0x62(%rsp)
               	movw	$0xd122, 0x44(%rsp)     # imm = 0xD122
               	movw	$0x11, 0x64(%rsp)
               	movw	$0xf44b, 0x46(%rsp)     # imm = 0xF44B
               	movw	$0x18, 0x66(%rsp)
               	movw	$0x1774, 0x48(%rsp)     # imm = 0x1774
               	movw	$0x1f, 0x68(%rsp)
               	movw	$0x3a9d, 0x4a(%rsp)     # imm = 0x3A9D
               	movw	$0x26, 0x6a(%rsp)
               	movw	$0x5dc6, 0x4c(%rsp)     # imm = 0x5DC6
               	movw	$0x2d, 0x6c(%rsp)
               	movw	$0x80ef, 0x4e(%rsp)     # imm = 0x80EF
               	movw	$0x34, 0x6e(%rsp)
               	movw	$0xa418, 0x50(%rsp)     # imm = 0xA418
               	movw	$0x3b, 0x70(%rsp)
               	movw	$0xc741, 0x52(%rsp)     # imm = 0xC741
               	movw	$0x42, 0x72(%rsp)
               	movw	$0xea6a, 0x54(%rsp)     # imm = 0xEA6A
               	movw	$0x49, 0x74(%rsp)
               	movw	$0xd93, 0x56(%rsp)      # imm = 0xD93
               	movw	$0x50, 0x76(%rsp)
               	movw	$0x30bc, 0x58(%rsp)     # imm = 0x30BC
               	movw	$0x57, 0x78(%rsp)
               	movw	$0x53e5, 0x5a(%rsp)     # imm = 0x53E5
               	movw	$0x5e, 0x7a(%rsp)
               	movw	$0x770e, 0x5c(%rsp)     # imm = 0x770E
               	movw	$0x65, 0x7c(%rsp)
               	movw	$0x9a37, 0x5e(%rsp)     # imm = 0x9A37
               	movw	$0x6c, 0x7e(%rsp)
               	movl	$0x88ca6c00, 0x80(%rsp) # imm = 0x88CA6C00
               	movl	$0x9c40, 0xa0(%rsp)     # imm = 0x9C40
               	movl	$0xf0000000, 0xc0(%rsp) # imm = 0xF0000000
               	movl	$0x12345678, 0xe0(%rsp) # imm = 0x12345678
               	movl	$0x3fc00000, 0x140(%rsp) # imm = 0x3FC00000
               	movl	$0x3f000000, 0x160(%rsp) # imm = 0x3F000000
               	movl	$0x88d9ae43, 0x84(%rsp) # imm = 0x88D9AE43
               	movl	$0x9c41, 0xa4(%rsp)     # imm = 0x9C41
               	movl	$0xf0000001, 0xc4(%rsp) # imm = 0xF0000001
               	movl	$0x2468acf0, 0xe4(%rsp) # imm = 0x2468ACF0
               	movl	$0x40200000, 0x144(%rsp) # imm = 0x40200000
               	movl	$0x3f400000, 0x164(%rsp) # imm = 0x3F400000
               	movl	$0x88e8f086, 0x88(%rsp) # imm = 0x88E8F086
               	movl	$0x9c42, 0xa8(%rsp)     # imm = 0x9C42
               	movl	$0xf0000002, 0xc8(%rsp) # imm = 0xF0000002
               	movl	$0x369d0368, 0xe8(%rsp) # imm = 0x369D0368
               	movl	$0x40600000, 0x148(%rsp) # imm = 0x40600000
               	movl	$0x3f800000, 0x168(%rsp) # imm = 0x3F800000
               	movl	$0x88f832c9, 0x8c(%rsp) # imm = 0x88F832C9
               	movl	$0x9c43, 0xac(%rsp)     # imm = 0x9C43
               	movl	$0xf0000003, 0xcc(%rsp) # imm = 0xF0000003
               	movl	$0x48d159e0, 0xec(%rsp) # imm = 0x48D159E0
               	movl	$0x40900000, 0x14c(%rsp) # imm = 0x40900000
               	movl	$0x3fa00000, 0x16c(%rsp) # imm = 0x3FA00000
               	movl	$0x8907750c, 0x90(%rsp) # imm = 0x8907750C
               	movl	$0x9c44, 0xb0(%rsp)     # imm = 0x9C44
               	movl	$0xf0000004, 0xd0(%rsp) # imm = 0xF0000004
               	movl	$0x5b05b058, 0xf0(%rsp) # imm = 0x5B05B058
               	movl	$0x40b00000, 0x150(%rsp) # imm = 0x40B00000
               	movl	$0x3fc00000, 0x170(%rsp) # imm = 0x3FC00000
               	movl	$0x8916b74f, 0x94(%rsp) # imm = 0x8916B74F
               	movl	$0x9c45, 0xb4(%rsp)     # imm = 0x9C45
               	movl	$0xf0000005, 0xd4(%rsp) # imm = 0xF0000005
               	movl	$0x6d3a06d0, 0xf4(%rsp) # imm = 0x6D3A06D0
               	movl	$0x40d00000, 0x154(%rsp) # imm = 0x40D00000
               	movl	$0x3fe00000, 0x174(%rsp) # imm = 0x3FE00000
               	movl	$0x8925f992, 0x98(%rsp) # imm = 0x8925F992
               	movl	$0x9c46, 0xb8(%rsp)     # imm = 0x9C46
               	movl	$0xf0000006, 0xd8(%rsp) # imm = 0xF0000006
               	movl	$0x7f6e5d48, 0xf8(%rsp) # imm = 0x7F6E5D48
               	movl	$0x40f00000, 0x158(%rsp) # imm = 0x40F00000
               	movl	$0x40000000, 0x178(%rsp) # imm = 0x40000000
               	movl	$0x89353bd5, 0x9c(%rsp) # imm = 0x89353BD5
               	movl	$0x9c47, 0xbc(%rsp)     # imm = 0x9C47
               	movl	$0xf0000007, 0xdc(%rsp) # imm = 0xF0000007
               	movl	$0x91a2b3c0, 0xfc(%rsp) # imm = 0x91A2B3C0
               	movl	$0x41080000, 0x15c(%rsp) # imm = 0x41080000
               	movl	$0x40100000, 0x17c(%rsp) # imm = 0x40100000
               	movabsq	$0x7ffffffffffffff0, %rax # imm = 0x7FFFFFFFFFFFFFF0
               	movq	%rax, 0x100(%rsp)
               	movq	$0x10, 0x120(%rsp)
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x180(%rsp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x1a0(%rsp)
               	movabsq	$0x7ffffffffffffff1, %rax # imm = 0x7FFFFFFFFFFFFFF1
               	movq	%rax, 0x108(%rsp)
               	movq	$0x11, 0x128(%rsp)
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x188(%rsp)
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x1a8(%rsp)
               	movabsq	$0x7ffffffffffffff2, %rax # imm = 0x7FFFFFFFFFFFFFF2
               	movq	%rax, 0x110(%rsp)
               	movq	$0x12, 0x130(%rsp)
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x190(%rsp)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x1b0(%rsp)
               	movabsq	$0x7ffffffffffffff3, %rax # imm = 0x7FFFFFFFFFFFFFF3
               	movq	%rax, 0x118(%rsp)
               	movq	$0x13, 0x138(%rsp)
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x198(%rsp)
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x1b8(%rsp)
               	leaq	(%rsp), %rbx
               	leaq	0x20(%rsp), %r9
               	movq	%rbx, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	leaq	0x1c0(%rsp), %rsi
               	vmovups	%ymm0, 0x1c0(%rsp)
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	leaq	0x20(%rsp), %rdx
               	movsbq	(%rdx,%rax), %rdx
               	movsbq	(%rsi,%rax), %rdi
               	leaq	(%rcx,%rdx), %r8
               	movsbq	%r8b, %r8
               	movq	%rcx, %r9
               	subq	%rdx, %r9
               	movsbq	%r9b, %r9
               	xorq	%r9, %r8
               	andq	%rdx, %rcx
               	orq	%r8, %rcx
               	movsbq	%cl, %rcx
               	cmpl	%ecx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rbx
               	leaq	0x60(%rsp), %r9
               	movq	%rbx, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	leaq	0x1c0(%rsp), %rdx
               	vmovups	%ymm0, 0x1c0(%rsp)
               	xorl	%eax, %eax
               	movswq	(%rdx,%rax,2), %rsi
               	movswq	(%rbx,%rax,2), %rdi
               	leaq	0x60(%rsp), %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	imulq	%rcx, %rdi
               	movswq	%di, %rdi
               	leaq	0x40(%rsp), %r8
               	movswq	(%r8,%rax,2), %r8
               	subq	%rcx, %r8
               	movswq	%r8w, %rcx
               	addq	%rdi, %rcx
               	movswq	%cx, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rbx
               	leaq	0xa0(%rsp), %r9
               	movq	%rbx, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	leaq	0x1c0(%rsp), %rdx
               	vmovups	%ymm0, 0x1c0(%rsp)
               	xorl	%eax, %eax
               	movslq	(%rdx,%rax,4), %rsi
               	movl	(%rbx,%rax,4), %edi
               	leaq	0xa0(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	addq	%rcx, %rdi
               	movslq	%edi, %rdi
               	leaq	0x80(%rsp), %r8
               	movl	(%r8,%rax,4), %r8d
               	subq	%rcx, %r8
               	movslq	%r8d, %rcx
               	xorq	%rdi, %rcx
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %rbx
               	leaq	0xe0(%rsp), %r9
               	movq	%rbx, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	leaq	0x1c0(%rsp), %rdx
               	vmovups	%ymm0, 0x1c0(%rsp)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	movl	(%rbx,%rax,4), %edi
               	leaq	0xe0(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	subq	%rcx, %rdi
               	leaq	0xc0(%rsp), %r8
               	movl	(%r8,%rax,4), %r8d
               	orq	%r8, %rcx
               	xorq	%rdi, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r9
               	leaq	0x120(%rsp), %rax
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	vmovq	%xmm0, %rdx
               	movq	0x100(%rsp), %rax
               	movq	0x120(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x490(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	vpextrq	$0x1, %xmm0, %rdx
               	movq	0x108(%rsp), %rax
               	movq	0x128(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm1
               	vmovq	%xmm1, %rdx
               	movq	0x110(%rsp), %rax
               	movq	0x130(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rdx
               	movq	0x118(%rsp), %rax
               	movq	0x138(%rsp), %rcx
               	leaq	(%rax,%rcx), %rsi
               	andq	%rcx, %rax
               	subq	%rax, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x140(%rsp), %rbx
               	leaq	0x160(%rsp), %r9
               	movq	%rbx, %r10
               	vmovups	(%r10), %ymm0
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	leaq	0x1c0(%rsp), %rdx
               	vmovups	%ymm0, 0x1c0(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	shlq	$0x2, %rax
               	leaq	(%rbx,%rax), %rsi
               	movss	(%rsi), %xmm0
               	leaq	0x160(%rsp), %rsi
               	addq	%rax, %rsi
               	movss	(%rsi), %xmm1
               	mulss	%xmm1, %xmm0
               	leaq	0x140(%rsp), %rsi
               	addq	%rax, %rsi
               	movss	(%rsi), %xmm1
               	addss	%xmm1, %xmm0
               	leaq	(%rdx,%rax), %rsi
               	movss	(%rsi), %xmm1
               	leaq	0x160(%rsp), %rsi
               	addq	%rax, %rsi
               	movss	(%rsi), %xmm2
               	leaq	0x140(%rsp), %rsi
               	addq	%rsi, %rax
               	movss	(%rax), %xmm3
               	subss	%xmm3, %xmm2
               	divss	%xmm2, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	leaq	0x180(%rsp), %r9
               	leaq	0x1a0(%rsp), %rax
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	vmovups	(%r10), %ymm1
               	callq	<addr>
               	movsd	0x180(%rsp), %xmm2
               	movsd	0x1a0(%rsp), %xmm1
               	vsubsd	%xmm1, %xmm2, %xmm3
               	addsd	%xmm1, %xmm2
               	vmulsd	%xmm2, %xmm3, %xmm2
               	vpermilpd	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0]
               	divsd	%xmm1, %xmm2
               	ucomisd	%xmm2, %xmm3
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	-0x490(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	movsd	0x188(%rsp), %xmm2
               	movsd	0x1a8(%rsp), %xmm1
               	vsubsd	%xmm1, %xmm2, %xmm3
               	addsd	%xmm1, %xmm2
               	vmulsd	%xmm2, %xmm3, %xmm2
               	vpermilpd	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0]
               	divsd	%xmm1, %xmm2
               	ucomisd	%xmm2, %xmm3
               	jp	<addr>
               	jne	<addr>
               	movsd	0x190(%rsp), %xmm2
               	movsd	0x1b0(%rsp), %xmm1
               	vsubsd	%xmm1, %xmm2, %xmm3
               	addsd	%xmm1, %xmm2
               	vmulsd	%xmm2, %xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm3
               	divsd	%xmm1, %xmm2
               	ucomisd	%xmm2, %xmm3
               	jp	<addr>
               	jne	<addr>
               	movsd	0x198(%rsp), %xmm2
               	movsd	0x1b8(%rsp), %xmm1
               	vsubsd	%xmm1, %xmm2, %xmm3
               	addsd	%xmm1, %xmm2
               	vmulsd	%xmm2, %xmm3, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	divsd	%xmm1, %xmm2
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	0x1c0(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x5, %rdx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rcx
               	movl	%ecx, 0x4(%rdx)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	0x2(%rcx), %rsi
               	movl	%esi, 0x8(%rdx)
               	leaq	0x1c0(%rsp), %rsi
               	movq	%rax, %rdx
               	shlq	$0x5, %rdx
               	addq	%rdx, %rsi
               	leaq	0x3(%rcx), %rdi
               	movl	%edi, 0xc(%rsi)
               	leaq	0x4(%rcx), %rdi
               	movl	%edi, 0x10(%rsi)
               	leaq	0x1c0(%rsp), %rsi
               	addq	%rsi, %rdx
               	addq	$0x5, %rcx
               	movl	%ecx, 0x14(%rdx)
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	addq	%rsi, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	0x6(%rdx), %rsi
               	movl	%esi, 0x18(%rcx)
               	addq	$0x7, %rdx
               	movl	%edx, 0x1c(%rcx)
               	incq	%rax
               	cmpl	$0x12, %eax
               	jl	<addr>
               	xorl	%ebx, %ebx
               	vmovups	0x1c0(%rsp), %ymm14
               	vmovups	%ymm14, -0x460(%rbp)
               	vmovups	0x1e0(%rsp), %ymm14
               	vmovups	%ymm14, -0x440(%rbp)
               	vmovups	0x200(%rsp), %ymm14
               	vmovups	%ymm14, -0x420(%rbp)
               	vmovups	0x220(%rsp), %ymm14
               	vmovups	%ymm14, -0x400(%rbp)
               	vmovups	0x240(%rsp), %ymm14
               	vmovups	%ymm14, -0x3e0(%rbp)
               	vmovups	0x260(%rsp), %ymm14
               	vmovups	%ymm14, -0x3c0(%rbp)
               	vmovups	0x280(%rsp), %ymm14
               	vmovups	%ymm14, -0x3a0(%rbp)
               	vmovups	0x2a0(%rsp), %ymm14
               	vmovups	%ymm14, -0x380(%rbp)
               	vmovups	0x2c0(%rsp), %ymm14
               	vmovups	%ymm14, -0x360(%rbp)
               	vmovups	0x2e0(%rsp), %ymm14
               	vmovups	%ymm14, -0x340(%rbp)
               	vmovups	0x300(%rsp), %ymm14
               	vmovups	%ymm14, -0x320(%rbp)
               	vmovups	0x320(%rsp), %ymm14
               	vmovups	%ymm14, -0x300(%rbp)
               	vmovups	0x340(%rsp), %ymm14
               	vmovups	%ymm14, -0x2e0(%rbp)
               	vmovups	0x360(%rsp), %ymm14
               	vmovups	%ymm14, -0x2c0(%rbp)
               	vmovups	0x380(%rsp), %ymm14
               	vmovups	%ymm14, -0x2a0(%rbp)
               	vmovups	0x3a0(%rsp), %ymm14
               	vmovups	%ymm14, -0x280(%rbp)
               	vmovups	0x3c0(%rsp), %ymm14
               	vmovups	%ymm14, -0x260(%rbp)
               	vmovups	0x3e0(%rsp), %ymm14
               	vmovups	%ymm14, -0x480(%rbp)
               	vmovups	0xa0(%rsp), %ymm0
               	vmovups	-0x460(%rbp), %ymm14
               	vpaddd	%ymm0, %ymm14, %ymm14
               	vmovups	%ymm14, -0x460(%rbp)
               	vmovups	-0x440(%rbp), %ymm14
               	vmovups	-0x460(%rbp), %ymm15
               	vpxor	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x440(%rbp)
               	vmovups	-0x420(%rbp), %ymm14
               	vmovups	-0x440(%rbp), %ymm15
               	vpaddd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x420(%rbp)
               	vmovups	-0x400(%rbp), %ymm14
               	vmovups	-0x420(%rbp), %ymm15
               	vpsubd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x400(%rbp)
               	vmovups	-0x3e0(%rbp), %ymm14
               	vmovups	-0x400(%rbp), %ymm15
               	vpaddd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x3e0(%rbp)
               	vmovups	-0x3c0(%rbp), %ymm14
               	vmovups	-0x3e0(%rbp), %ymm15
               	vpxor	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x3c0(%rbp)
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	vmovups	-0x3a0(%rbp), %ymm14
               	vmovups	-0x3c0(%rbp), %ymm15
               	vpaddd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x3a0(%rbp)
               	vmovups	-0x380(%rbp), %ymm14
               	vmovups	-0x3a0(%rbp), %ymm15
               	vpsubd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x380(%rbp)
               	vmovups	-0x360(%rbp), %ymm14
               	vmovups	-0x380(%rbp), %ymm15
               	vpaddd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x360(%rbp)
               	vmovups	-0x340(%rbp), %ymm14
               	vmovups	-0x360(%rbp), %ymm15
               	vpxor	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x340(%rbp)
               	vmovups	-0x320(%rbp), %ymm14
               	vmovups	-0x340(%rbp), %ymm15
               	vpaddd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x320(%rbp)
               	vmovups	-0x300(%rbp), %ymm14
               	vmovups	-0x320(%rbp), %ymm15
               	vpsubd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x300(%rbp)
               	vmovups	-0x2e0(%rbp), %ymm14
               	vmovups	-0x300(%rbp), %ymm15
               	vpaddd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x2e0(%rbp)
               	vmovups	-0x2c0(%rbp), %ymm14
               	vmovups	-0x2e0(%rbp), %ymm15
               	vpxor	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x2c0(%rbp)
               	vmovups	-0x2a0(%rbp), %ymm14
               	vmovups	-0x2c0(%rbp), %ymm15
               	vpaddd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x2a0(%rbp)
               	vmovups	-0x280(%rbp), %ymm14
               	vmovups	-0x2a0(%rbp), %ymm15
               	vpsubd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x280(%rbp)
               	vmovups	-0x260(%rbp), %ymm14
               	vmovups	-0x280(%rbp), %ymm15
               	vpaddd	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x260(%rbp)
               	vmovups	-0x480(%rbp), %ymm14
               	vmovups	-0x260(%rbp), %ymm15
               	vpxor	%ymm15, %ymm14, %ymm14
               	vmovups	%ymm14, -0x480(%rbp)
               	incq	%rbx
               	cmpl	$0xa, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x240(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x5, %rdx
               	addq	%rcx, %rdx
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rcx
               	movl	%ecx, 0x4(%rdx)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	0x2(%rcx), %rsi
               	movl	%esi, 0x8(%rdx)
               	leaq	-0x240(%rbp), %rsi
               	movq	%rax, %rdx
               	shlq	$0x5, %rdx
               	addq	%rdx, %rsi
               	leaq	0x3(%rcx), %rdi
               	movl	%edi, 0xc(%rsi)
               	leaq	0x4(%rcx), %rdi
               	movl	%edi, 0x10(%rsi)
               	leaq	-0x240(%rbp), %rsi
               	addq	%rsi, %rdx
               	addq	$0x5, %rcx
               	movl	%ecx, 0x14(%rdx)
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	addq	%rsi, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	0x6(%rdx), %rsi
               	movl	%esi, 0x18(%rcx)
               	addq	$0x7, %rdx
               	movl	%edx, 0x1c(%rcx)
               	incq	%rax
               	cmpl	$0x12, %eax
               	jl	<addr>
               	xorl	%r12d, %r12d
               	xorl	%edx, %edx
               	leaq	-0x240(%rbp), %r9
               	movl	(%r9,%rdx,4), %eax
               	leaq	0xa0(%rsp), %rcx
               	movl	(%rcx,%rdx,4), %ecx
               	addq	%rcx, %rax
               	movl	%eax, (%r9,%rdx,4)
               	movl	$0x1, %eax
               	movq	%rax, %rdi
               	shlq	$0x5, %rdi
               	leaq	(%r9,%rdi), %rcx
               	movl	(%rcx,%rdx,4), %ecx
               	leaq	-0x240(%rbp), %rsi
               	leaq	-0x1(%rax), %r8
               	shlq	$0x5, %r8
               	addq	%r8, %rsi
               	movl	(%rsi,%rdx,4), %esi
               	movq	%rax, %r8
               	andq	$0x3, %r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	subq	%rsi, %rcx
               	jmp	<addr>
               	cmpl	$0x1, %r8d
               	je	<addr>
               	addq	%rsi, %rcx
               	jmp	<addr>
               	xorq	%rsi, %rcx
               	leaq	-0x240(%rbp), %rsi
               	addq	%rdi, %rsi
               	movl	%ecx, (%rsi,%rdx,4)
               	incq	%rax
               	cmpl	$0x12, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	incq	%r12
               	cmpl	$0xa, %r12d
               	jl	<addr>
               	leaq	0x1c0(%rsp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	%ymm14, 0x20(%rax)
               	vmovups	%ymm14, 0x40(%rax)
               	vmovups	%ymm14, 0x60(%rax)
               	vmovups	%ymm14, 0x80(%rax)
               	vmovups	%ymm14, 0xa0(%rax)
               	vmovups	%ymm14, 0xc0(%rax)
               	vmovups	%ymm14, 0xe0(%rax)
               	vmovups	%ymm14, 0x100(%rax)
               	vmovups	%ymm14, 0x120(%rax)
               	vmovups	%ymm14, 0x140(%rax)
               	vmovups	%ymm14, 0x160(%rax)
               	vmovups	%ymm14, 0x180(%rax)
               	vmovups	%ymm14, 0x1a0(%rax)
               	vmovups	%ymm14, 0x1c0(%rax)
               	vmovups	%ymm14, 0x1e0(%rax)
               	vmovups	%ymm14, 0x200(%rax)
               	vmovups	%ymm14, 0x220(%rax)
               	vmovups	-0x460(%rbp), %ymm14
               	vmovups	%ymm14, 0x1c0(%rsp)
               	vmovups	-0x440(%rbp), %ymm14
               	vmovups	%ymm14, 0x1e0(%rsp)
               	vmovups	-0x420(%rbp), %ymm14
               	vmovups	%ymm14, 0x200(%rsp)
               	vmovups	-0x400(%rbp), %ymm14
               	vmovups	%ymm14, 0x220(%rsp)
               	vmovups	-0x3e0(%rbp), %ymm14
               	vmovups	%ymm14, 0x240(%rsp)
               	vmovups	-0x3c0(%rbp), %ymm14
               	vmovups	%ymm14, 0x260(%rsp)
               	vmovups	-0x3a0(%rbp), %ymm14
               	vmovups	%ymm14, 0x280(%rsp)
               	vmovups	-0x380(%rbp), %ymm14
               	vmovups	%ymm14, 0x2a0(%rsp)
               	vmovups	-0x360(%rbp), %ymm14
               	vmovups	%ymm14, 0x2c0(%rsp)
               	vmovups	-0x340(%rbp), %ymm14
               	vmovups	%ymm14, 0x2e0(%rsp)
               	vmovups	-0x320(%rbp), %ymm14
               	vmovups	%ymm14, 0x300(%rsp)
               	vmovups	-0x300(%rbp), %ymm14
               	vmovups	%ymm14, 0x320(%rsp)
               	vmovups	-0x2e0(%rbp), %ymm14
               	vmovups	%ymm14, 0x340(%rsp)
               	vmovups	-0x2c0(%rbp), %ymm14
               	vmovups	%ymm14, 0x360(%rsp)
               	vmovups	-0x2a0(%rbp), %ymm14
               	vmovups	%ymm14, 0x380(%rsp)
               	leaq	0x1c0(%rsp), %rdi
               	vmovups	-0x280(%rbp), %ymm14
               	vmovups	%ymm14, 0x3a0(%rsp)
               	vmovups	-0x260(%rbp), %ymm14
               	vmovups	%ymm14, 0x3c0(%rsp)
               	vmovups	-0x480(%rbp), %ymm14
               	vmovups	%ymm14, 0x3e0(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rdi,%rcx), %rdx
               	movl	(%rdx), %esi
               	leaq	-0x240(%rbp), %r8
               	addq	%rcx, %r8
               	movl	(%r8), %r8d
               	cmpl	%r8d, %esi
               	jne	<addr>
               	movl	0x4(%rdx), %esi
               	leaq	-0x240(%rbp), %rdx
               	addq	%rdx, %rcx
               	movl	0x4(%rcx), %ecx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	leaq	0x1c0(%rsp), %rsi
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rsi
               	movl	0x8(%rsi), %r8d
               	addq	%rdx, %rcx
               	movl	0x8(%rcx), %ecx
               	cmpl	%ecx, %r8d
               	jne	<addr>
               	movl	0xc(%rsi), %esi
               	leaq	-0x240(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rdx
               	movl	0xc(%rdx), %r8d
               	cmpl	%r8d, %esi
               	jne	<addr>
               	leaq	0x1c0(%rsp), %rsi
               	addq	%rsi, %rcx
               	movl	0x10(%rcx), %ecx
               	movl	0x10(%rdx), %edx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	leaq	0x1c0(%rsp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rdx
               	movl	0x14(%rdx), %esi
               	leaq	-0x240(%rbp), %r8
               	addq	%r8, %rcx
               	movl	0x14(%rcx), %ecx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	movl	0x18(%rdx), %esi
               	leaq	-0x240(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rdx
               	movl	0x18(%rdx), %r8d
               	cmpl	%r8d, %esi
               	jne	<addr>
               	leaq	0x1c0(%rsp), %rsi
               	addq	%rsi, %rcx
               	movl	0x1c(%rcx), %ecx
               	movl	0x1c(%rdx), %edx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x12, %eax
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1e, %edx
               	cmpl	$0x2d, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	leaq	-0x490(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	addq	$0xa, %rax
               	leaq	-0x490(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	movl	$0x6, %eax
               	leaq	-0x490(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0x490(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	movl	$0x3, %eax
               	leaq	-0x490(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	movl	$0x2, %eax
               	leaq	-0x490(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x490(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
