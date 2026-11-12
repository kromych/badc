
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
               	vpextrb	$0x0, %xmm0, %eax
               	vpextrb	$0x0, %xmm2, %ecx
               	subq	%rcx, %rax
               	movslq	%eax, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	vfmadd231sd	%xmm3, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm3) + xmm0
               	retq

<wide_sub>:
               	vpsubb	%ymm0, %ymm1, %ymm0
               	retq

<ramp>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	leaq	0x1(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	leaq	0x2(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	leaq	0x3(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	leaq	0x4(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	leaq	0x5(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	leaq	0x6(%rax), %rcx
               	andq	$0xff, %rcx
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	addq	$0x7, %rax
               	andq	$0xff, %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	andq	$0xff, %rdi
               	leaq	0x8(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	leaq	0x9(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	leaq	0xa(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	leaq	0xb(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	leaq	0xc(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	leaq	0xd(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	leaq	0xe(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	leaq	0xf(%rdi), %rax
               	andq	$0xff, %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x1, %edi
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x64, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x10(%rbp), %xmm14
               	psubb	%xmm14, %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	vzeroupper
               	leave
               	retq
               	vpextrb	$0x1, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0xa, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0xb, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0xc, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0xd, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movabsq	$0x807060504030201, %r11 # imm = 0x807060504030201
               	vmovq	%r11, %xmm0
               	movabsq	$0x2f2e2d2c2b2a2928, %r11 # imm = 0x2F2E2D2C2B2A2928
               	vmovq	%r11, %xmm1
               	movapd	%xmm1, %xmm15
               	psubb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	cmpl	$0x27, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	vzeroupper
               	leave
               	retq
               	vpextrb	$0x1, %xmm0, %eax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %eax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %eax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %eax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %eax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %eax
               	cmpl	$0x27, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	addps	%xmm1, %xmm0
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	movl	$0x41300000, %eax       # imm = 0x41300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0,0,0]
               	movl	$0x41b00000, %eax       # imm = 0x41B00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x2, %xmm0, %xmm1 # xmm1 = xmm0[2,0,0,0]
               	movl	$0x42040000, %eax       # imm = 0x42040000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
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
               	vpextrb	$0x0, %xmm0, %eax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	vzeroupper
               	leave
               	retq
               	vpextrb	$0x1, %xmm0, %eax
               	cmpq	$0x6, %rax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %eax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %eax
               	cmpq	$0xc, %rax
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %eax
               	cmpq	$0xe, %rax
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %eax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %eax
               	cmpq	$0x12, %rax
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %eax
               	cmpq	$0x14, %rax
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %eax
               	cmpq	$0x16, %rax
               	jne	<addr>
               	vpextrb	$0xa, %xmm0, %eax
               	cmpq	$0x18, %rax
               	jne	<addr>
               	vpextrb	$0xb, %xmm0, %eax
               	cmpq	$0x1a, %rax
               	jne	<addr>
               	vpextrb	$0xc, %xmm0, %eax
               	cmpq	$0x1c, %rax
               	jne	<addr>
               	vpextrb	$0xd, %xmm0, %eax
               	cmpq	$0x1e, %rax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	cmpq	$0x20, %rax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	cmpq	$0x22, %rax
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
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0xa, %edi
               	vzeroupper
               	callq	<addr>
               	movups	-0x10(%rbp), %xmm14
               	vpextrb	$0x0, %xmm14, %eax
               	vpextrb	$0x0, %xmm0, %ecx
               	subq	%rcx, %rax
               	movslq	%eax, %rax
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
               	vmovups	0x20(%rsp), %ymm0
               	vmovups	(%rsp), %ymm1
               	vpsubb	%ymm1, %ymm0, %ymm0
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
