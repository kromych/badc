
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	%xmm0, -0x8(%rbp)
               	movsd	%xmm1, -0x10(%rbp)
               	movzbq	-0x10(%rbp), %rax
               	movzbq	-0x8(%rbp), %rcx
               	subq	%rcx, %rax
               	movb	%al, -0x18(%rbp)
               	movzbq	-0xf(%rbp), %rax
               	movzbq	-0x7(%rbp), %rcx
               	subq	%rcx, %rax
               	movb	%al, -0x17(%rbp)
               	movzbq	-0xe(%rbp), %rax
               	movzbq	-0x6(%rbp), %rcx
               	subq	%rcx, %rax
               	movb	%al, -0x16(%rbp)
               	movzbq	-0xd(%rbp), %rax
               	movzbq	-0x5(%rbp), %rcx
               	subq	%rcx, %rax
               	movb	%al, -0x15(%rbp)
               	movzbq	-0xc(%rbp), %rax
               	movzbq	-0x4(%rbp), %rcx
               	subq	%rcx, %rax
               	movb	%al, -0x14(%rbp)
               	movzbq	-0xb(%rbp), %rax
               	movzbq	-0x3(%rbp), %rcx
               	subq	%rcx, %rax
               	movb	%al, -0x13(%rbp)
               	movzbq	-0xa(%rbp), %rax
               	movzbq	-0x2(%rbp), %rcx
               	subq	%rcx, %rax
               	movb	%al, -0x12(%rbp)
               	movzbq	-0x9(%rbp), %rax
               	movzbq	-0x1(%rbp), %rcx
               	subq	%rcx, %rax
               	movb	%al, -0x11(%rbp)
               	movsd	-0x18(%rbp), %xmm0
               	leave
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
               	subq	$0x60, %rsp
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
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x20(%rsp), %rdx
               	movzbq	(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	movzbq	0x1(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	movzbq	0x2(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	movzbq	0x3(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	movzbq	0x4(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	movzbq	0x5(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	movzbq	0x6(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	movzbq	0x7(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	movzbq	0x8(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	movzbq	0x9(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	movzbq	0xa(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	movzbq	0xb(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	movzbq	0xc(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	movzbq	0xd(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	movzbq	0xe(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	movzbq	0xf(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x4f(%rsp)
               	movzbq	0x30(%rsp), %rdx
               	movzbq	0x10(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x50(%rsp)
               	movzbq	0x31(%rsp), %rdx
               	movzbq	0x11(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x51(%rsp)
               	movzbq	0x32(%rsp), %rdx
               	movzbq	0x12(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x52(%rsp)
               	movzbq	0x33(%rsp), %rdx
               	movzbq	0x13(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x53(%rsp)
               	movzbq	0x34(%rsp), %rdx
               	movzbq	0x14(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x54(%rsp)
               	movzbq	0x35(%rsp), %rdx
               	movzbq	0x15(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x55(%rsp)
               	movzbq	0x36(%rsp), %rdx
               	movzbq	0x16(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x56(%rsp)
               	movzbq	0x37(%rsp), %rdx
               	movzbq	0x17(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x57(%rsp)
               	movzbq	0x38(%rsp), %rdx
               	movzbq	0x18(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x58(%rsp)
               	movzbq	0x39(%rsp), %rdx
               	movzbq	0x19(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x59(%rsp)
               	movzbq	0x3a(%rsp), %rdx
               	movzbq	0x1a(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5a(%rsp)
               	movzbq	0x3b(%rsp), %rdx
               	movzbq	0x1b(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5b(%rsp)
               	movzbq	0x3c(%rsp), %rdx
               	movzbq	0x1c(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5c(%rsp)
               	movzbq	0x3d(%rsp), %rdx
               	movzbq	0x1d(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5d(%rsp)
               	movzbq	0x3e(%rsp), %rdx
               	movzbq	0x1e(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5e(%rsp)
               	movzbq	0x3f(%rsp), %rdx
               	movzbq	0x1f(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x5f(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x1, %edi
               	callq	<addr>
               	movups	%xmm0, -0x20(%rbp)
               	movl	$0x64, %edi
               	callq	<addr>
               	movups	-0x20(%rbp), %xmm14
               	psubb	%xmm14, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movzbq	0x40(%rsp), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movzbq	0x41(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x42(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x43(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x44(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x45(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x46(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x47(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x48(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x49(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x4a(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x4b(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x4c(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x4d(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x4e(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movzbq	0x4f(%rsp), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movb	$0x27, -0x8(%rbp)
               	movb	$0x27, -0x7(%rbp)
               	movb	$0x27, -0x6(%rbp)
               	movb	$0x27, -0x5(%rbp)
               	movb	$0x27, -0x4(%rbp)
               	movb	$0x27, -0x3(%rbp)
               	movb	$0x27, -0x2(%rbp)
               	movb	$0x27, -0x1(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	cmpl	$0x27, %eax
               	je	<addr>
               	movl	$0x2, %eax
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
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x20(%rsp), %xmm0
               	movups	0x40(%rsp), %xmm1
               	addps	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movss	0x40(%rsp), %xmm0
               	movl	$0x41300000, %eax       # imm = 0x41300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x44(%rsp), %xmm0
               	movl	$0x41b00000, %eax       # imm = 0x41B00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x48(%rsp), %xmm0
               	movl	$0x42040000, %eax       # imm = 0x42040000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x4c(%rsp), %xmm0
               	movl	$0x42300000, %eax       # imm = 0x42300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movapd	%xmm0, %xmm15
               	paddb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movzbq	0x40(%rsp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzbq	0x41(%rsp), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movzbq	0x42(%rsp), %rax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	0x43(%rsp), %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movzbq	0x44(%rsp), %rax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movzbq	0x45(%rsp), %rax
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	0x46(%rsp), %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	movzbq	0x47(%rsp), %rax
               	cmpl	$0x12, %eax
               	jne	<addr>
               	movzbq	0x48(%rsp), %rax
               	cmpl	$0x14, %eax
               	jne	<addr>
               	movzbq	0x49(%rsp), %rax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	movzbq	0x4a(%rsp), %rax
               	cmpl	$0x18, %eax
               	jne	<addr>
               	movzbq	0x4b(%rsp), %rax
               	cmpl	$0x1a, %eax
               	jne	<addr>
               	movzbq	0x4c(%rsp), %rax
               	cmpl	$0x1c, %eax
               	jne	<addr>
               	movzbq	0x4d(%rsp), %rax
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	movzbq	0x4e(%rsp), %rax
               	cmpl	$0x20, %eax
               	jne	<addr>
               	movzbq	0x4f(%rsp), %rax
               	cmpl	$0x22, %eax
               	jne	<addr>
               	movl	$0x1, %edi
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
               	leaq	0x40(%rsp), %rcx
               	movups	%xmm0, 0x40(%rsp)
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
               	callq	<addr>
               	movups	%xmm0, 0x20(%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movups	%xmm0, 0x40(%rsp)
               	movzbq	0x20(%rsp), %rax
               	movzbq	0x40(%rsp), %rcx
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
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x40(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	cmpl	$0x45, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
