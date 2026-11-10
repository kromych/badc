
vector_abi_arg_return.x64:	file format elf64-x86-64

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

<vec_sub>:
               	movapd	%xmm1, %xmm15
               	psubb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	retq

<vec8_sub>:
               	movapd	%xmm1, %xmm15
               	psubb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	retq

<vecf_add>:
               	addps	%xmm1, %xmm0
               	retq

<wrap_double>:
               	movapd	%xmm0, %xmm15
               	paddb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	retq

<nine>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	paddb	%xmm1, %xmm0
               	paddb	%xmm2, %xmm0
               	paddb	%xmm3, %xmm0
               	paddb	%xmm4, %xmm0
               	paddb	%xmm5, %xmm0
               	paddb	%xmm6, %xmm0
               	paddb	%xmm7, %xmm0
               	movups	-0x10(%rbp), %xmm1
               	paddb	%xmm1, %xmm0
               	leave
               	retq

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movups	%xmm0, -0x20(%rbp)
               	movups	%xmm2, -0x10(%rbp)
               	movzbq	-0x20(%rbp), %rax
               	movzbq	-0x10(%rbp), %rcx
               	subq	%rcx, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vfmadd231sd	%xmm3, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm3) + xmm0
               	leave
               	retq

<wide_sub>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rax
               	vmovups	0x20(%rsp), %ymm0
               	vmovups	(%rsp), %ymm1
               	vpsubb	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, (%rax)
               	vzeroupper
               	leave
               	retq

<ramp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x10(%rbp)
               	leaq	0x1(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xf(%rbp)
               	leaq	0x2(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xe(%rbp)
               	leaq	0x3(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xd(%rbp)
               	addq	$0x4, %rax
               	andq	$0xff, %rax
               	movb	%al, -0xc(%rbp)
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	leaq	0x5(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xb(%rbp)
               	leaq	0x6(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0xa(%rbp)
               	leaq	0x7(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x9(%rbp)
               	leaq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x8(%rbp)
               	addq	$0x9, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x7(%rbp)
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	leaq	0xa(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x6(%rbp)
               	leaq	0xb(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x5(%rbp)
               	leaq	0xc(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x4(%rbp)
               	leaq	0xd(%rax), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x3(%rbp)
               	addq	$0xe, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x2(%rbp)
               	andq	$0xff, %rdi
               	leaq	0xf(%rdi), %rax
               	andq	$0xff, %rax
               	movb	%al, -0x1(%rbp)
               	movups	-0x10(%rbp), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, -0x20(%rbp)
               	movl	$0x64, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x20(%rbp), %xmm14
               	psubb	%xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	movzbq	0x20(%rsp), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	vzeroupper
               	leave
               	retq
               	movzbq	0x21(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x22(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x23(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x24(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x25(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x26(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x27(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x28(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x29(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x2a(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x2b(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x2c(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x2d(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x2e(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x2f(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movb	$0x1, -0x10(%rbp)
               	movb	$0x28, -0x8(%rbp)
               	movb	$0x2, -0xf(%rbp)
               	movb	$0x29, -0x7(%rbp)
               	movb	$0x3, -0xe(%rbp)
               	movb	$0x2a, -0x6(%rbp)
               	movb	$0x4, -0xd(%rbp)
               	movb	$0x2b, -0x5(%rbp)
               	movb	$0x5, -0xc(%rbp)
               	movb	$0x2c, -0x4(%rbp)
               	movb	$0x6, -0xb(%rbp)
               	movb	$0x2d, -0x3(%rbp)
               	movb	$0x7, -0xa(%rbp)
               	movb	$0x2e, -0x2(%rbp)
               	movb	$0x8, -0x9(%rbp)
               	movb	$0x2f, -0x1(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movsd	-0x10(%rbp), %xmm1
               	psubb	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	cmpl	$0x27, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	vzeroupper
               	leave
               	retq
               	movzbq	-0x7(%rbp), %rax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	movzbq	-0x6(%rbp), %rax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	movzbq	-0x4(%rbp), %rax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	movzbq	-0x3(%rbp), %rax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	movzbq	-0x2(%rbp), %rax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	movzbq	-0x1(%rbp), %rax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rsp), %xmm0
               	movups	0x20(%rsp), %xmm1
               	addps	%xmm1, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	movss	0x20(%rsp), %xmm0
               	movl	$0x41300000, %eax       # imm = 0x41300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x24(%rsp), %xmm0
               	movl	$0x41b00000, %eax       # imm = 0x41B00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x28(%rsp), %xmm0
               	movl	$0x42040000, %eax       # imm = 0x42040000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x2c(%rsp), %xmm0
               	movl	$0x42300000, %eax       # imm = 0x42300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x2, %edi
               	vzeroupper
               	callq	<addr>
               	movapd	%xmm0, %xmm15
               	paddb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	movzbq	0x20(%rsp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	vzeroupper
               	leave
               	retq
               	movzbq	0x21(%rsp), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movzbq	0x22(%rsp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	0x23(%rsp), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movzbq	0x24(%rsp), %rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movzbq	0x25(%rsp), %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	0x26(%rsp), %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	movzbq	0x27(%rsp), %rax
               	cmpl	$0x12, %eax
               	jne	<addr>
               	movzbq	0x28(%rsp), %rax
               	cmpl	$0x14, %eax
               	jne	<addr>
               	movzbq	0x29(%rsp), %rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	movzbq	0x2a(%rsp), %rax
               	cmpl	$0x18, %eax
               	jne	<addr>
               	movzbq	0x2b(%rsp), %rax
               	cmpl	$0x1a, %eax
               	jne	<addr>
               	movzbq	0x2c(%rsp), %rax
               	cmpl	$0x1c, %eax
               	jne	<addr>
               	movzbq	0x2d(%rsp), %rax
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	movzbq	0x2e(%rsp), %rax
               	cmpl	$0x20, %eax
               	jne	<addr>
               	movzbq	0x2f(%rsp), %rax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movapd	%xmm0, %xmm1
               	paddb	%xmm0, %xmm1
               	paddb	%xmm0, %xmm1
               	paddb	%xmm0, %xmm1
               	paddb	%xmm0, %xmm1
               	paddb	%xmm0, %xmm1
               	paddb	%xmm0, %xmm1
               	paddb	%xmm0, %xmm1
               	paddb	%xmm1, %xmm0
               	leaq	0x20(%rsp), %rcx
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	leaq	0x1(%rax), %rsi
               	leaq	(%rsi,%rsi,8), %rsi
               	andq	$0xff, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x32, %edi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, (%rsp)
               	movl	$0xa, %edi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0x20(%rsp)
               	movzbq	(%rsp), %rax
               	movzbq	0x20(%rsp), %rcx
               	subq	%rcx, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x4028000000000000, %rax # imm = 0x4028000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x404a000000000000, %rax # imm = 0x404A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	(%rsp), %rdx
               	leaq	0x1(%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	leaq	0x20(%rsp), %rdx
               	leaq	0x46(%rax), %rsi
               	movb	%sil, (%rdx,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpsubb	%ymm0, %ymm1, %ymm0
               	leaq	0x20(%rsp), %rcx
               	vmovups	%ymm0, 0x20(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	cmpl	$0x45, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x7, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x5, %eax
               	vzeroupper
               	leave
               	retq
