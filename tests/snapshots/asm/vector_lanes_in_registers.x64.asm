
vector_lanes_in_registers.x64:	file format elf64-x86-64

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

<put_c>:
               	movsbq	%dil, %rdi
               	vpinsrb	$0x3, %edi, %xmm0, %xmm0
               	leaq	-0x1(%rdi), %rax
               	movsbq	%al, %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movapd	%xmm0, %xmm15
               	paddb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	retq

<get_c>:
               	movapd	%xmm0, %xmm1
               	paddb	%xmm0, %xmm1
               	vpextrb	$0x5, %xmm1, %eax
               	movsbq	%al, %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	vpextrb	$0xf, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	addq	%rcx, %rax
               	retq

<get_uc>:
               	movapd	%xmm0, %xmm15
               	paddb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrb	$0x9, %xmm0, %eax
               	retq

<put_s>:
               	movswq	%di, %rdi
               	vpinsrw	$0x0, %edi, %xmm0, %xmm0
               	vpinsrw	$0x7, %edi, %xmm0, %xmm0
               	movapd	%xmm0, %xmm1
               	psubw	%xmm0, %xmm1
               	paddw	%xmm1, %xmm0
               	retq

<get_s>:
               	movapd	%xmm0, %xmm15
               	por	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrw	$0x6, %xmm0, %eax
               	movswq	%ax, %rax
               	retq

<get_us>:
               	movapd	%xmm0, %xmm15
               	por	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrw	$0x1, %xmm0, %eax
               	retq

<put_i>:
               	movslq	%edi, %rdi
               	vpinsrd	$0x2, %edi, %xmm0, %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	pxor	%xmm1, %xmm0
               	retq

<get_i>:
               	movapd	%xmm0, %xmm15
               	paddd	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	retq

<get_u>:
               	movapd	%xmm0, %xmm15
               	paddd	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpextrd	$0x3, %xmm0, %eax
               	retq

<mk_l>:
               	xorl	%eax, %eax
               	vmovq	%rdi, %xmm0
               	vpinsrq	$0x1, %rsi, %xmm0, %xmm0
               	movapd	%xmm0, %xmm15
               	paddq	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	retq

<get_l>:
               	movl	$0x3, %eax
               	vpextrq	$0x1, %xmm0, %rcx
               	imulq	%rcx, %rax
               	retq

<put_f>:
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	xorl	%ecx, %ecx
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm2
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	vmovd	%xmm1, %r11d
               	movapd	%xmm2, %xmm1
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpermilps	$0x2, %xmm0, %xmm2 # xmm2 = xmm0[2,0,0,0]
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	vmovd	%xmm2, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	retq

<get_f>:
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movq	%rax, %xmm15
               	addss	%xmm15, %xmm0
               	retq

<put_d>:
               	vmovq	%xmm1, %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%ecx, %ecx
               	vmovq	%xmm0, %r11
               	vmovq	%r11, %xmm0
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm1
               	vmovq	%xmm1, %r11
               	vpinsrq	$0x1, %r11, %xmm0, %xmm0
               	retq

<get_d>:
               	movapd	%xmm0, %xmm1
               	mulpd	%xmm0, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm1 # xmm1 = xmm1[0,0]
               	movapd	%xmm0, %xmm15
               	mulpd	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	vaddsd	%xmm0, %xmm1, %xmm0
               	retq

<put_i8>:
               	movslq	%edi, %rdi
               	vmovdqa	%xmm0, %xmm1
               	vpinsrd	$0x1, %edi, %xmm1, %xmm1
               	vinserti128	$0x0, %xmm1, %ymm0, %ymm0
               	movq	%rdi, %rax
               	negq	%rax
               	movslq	%eax, %rax
               	vextracti128	$0x1, %ymm0, %xmm1
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vpaddd	%ymm0, %ymm0, %ymm0
               	retq

<get_i8>:
               	vpaddd	%ymm0, %ymm0, %ymm1
               	vextracti128	$0x1, %ymm1, %xmm1
               	vpextrd	$0x3, %xmm1, %eax
               	movslq	%eax, %rax
               	vpaddd	%ymm0, %ymm0, %ymm0
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	subq	%rcx, %rax
               	vzeroupper
               	retq

<put_d4>:
               	vextracti128	$0x1, %ymm0, %xmm2
               	vmovq	%xmm1, %r11
               	movapd	%xmm2, %xmm1
               	vpinsrq	$0x1, %r11, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmulpd	%ymm0, %ymm0, %ymm0
               	retq

<get_d4>:
               	vaddpd	%ymm0, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilpd	$0x0, %xmm0, %xmm0 # xmm0 = xmm0[0,0]
               	vzeroupper
               	retq

<get_s16>:
               	vpaddw	%ymm0, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrw	$0x5, %xmm0, %eax
               	movswq	%ax, %rax
               	vzeroupper
               	retq

<put_i16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	movq	%rdi, -0x20(%rbp)
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
               	movl	%esi, 0x34(%rsp)
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rdx
               	movl	(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x40(%rsp)
               	movl	0x4(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x44(%rsp)
               	movl	0x8(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x48(%rsp)
               	movl	0xc(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x4c(%rsp)
               	movl	0x10(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x50(%rsp)
               	movl	0x14(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x54(%rsp)
               	movl	0x18(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x58(%rsp)
               	movl	0x1c(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x5c(%rsp)
               	movl	0x20(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x60(%rsp)
               	movl	0x24(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x64(%rsp)
               	movl	0x28(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x68(%rsp)
               	movl	0x2c(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x6c(%rsp)
               	movl	0x30(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x70(%rsp)
               	leaq	(%rsi,%rsi), %rcx
               	movl	%ecx, 0x74(%rsp)
               	movl	0x38(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x78(%rsp)
               	movl	0x3c(%rsp), %ecx
               	addq	%rcx, %rcx
               	movl	%ecx, 0x7c(%rsp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rdx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rdx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	leave
               	retq

<get_i16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
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
               	movl	0x38(%rsp), %eax
               	addq	%rax, %rax
               	movslq	%eax, %rax
               	leave
               	retq

<get_l8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
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
               	movq	0x28(%rsp), %rax
               	decq	%rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xc0, %rsp
               	andq	$-0x40, %rsp
               	movb	$0x32, 0x40(%rsp)
               	movb	$0x2b, 0x41(%rsp)
               	movb	$0x24, 0x42(%rsp)
               	movb	$0x1d, 0x43(%rsp)
               	movb	$0x16, 0x44(%rsp)
               	movb	$0xf, 0x45(%rsp)
               	movb	$0x8, 0x46(%rsp)
               	movb	$0x1, 0x47(%rsp)
               	movb	$-0x6, 0x48(%rsp)
               	movb	$-0xd, 0x49(%rsp)
               	movb	$-0x14, 0x4a(%rsp)
               	movb	$-0x1b, 0x4b(%rsp)
               	movb	$-0x22, 0x4c(%rsp)
               	movb	$-0x29, 0x4d(%rsp)
               	leaq	0x40(%rsp), %r9
               	movb	$-0x30, 0x4e(%rsp)
               	movb	$-0x37, 0x4f(%rsp)
               	movq	$-0x3c, %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdx
               	movups	%xmm0, 0x80(%rsp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	0x40(%rsp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movb	$-0x3c, -0xd(%rbp)
               	movb	$-0x3d, -0x1(%rbp)
               	xorl	%eax, %eax
               	movsbq	(%rdx,%rax), %rsi
               	movsbq	(%rcx,%rax), %rdi
               	shlq	%rdi
               	movsbq	%dil, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpq	$0x74f9, %rax           # imm = 0x74F9
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movb	$-0x38, 0x80(%rsp)
               	movb	$-0x37, 0x81(%rsp)
               	movb	$-0x36, 0x82(%rsp)
               	movb	$-0x35, 0x83(%rsp)
               	movb	$-0x34, 0x84(%rsp)
               	movb	$-0x33, 0x85(%rsp)
               	movb	$-0x32, 0x86(%rsp)
               	movb	$-0x31, 0x87(%rsp)
               	movb	$-0x30, 0x88(%rsp)
               	movb	$-0x2f, 0x89(%rsp)
               	movb	$-0x2e, 0x8a(%rsp)
               	movb	$-0x2d, 0x8b(%rsp)
               	movb	$-0x2c, 0x8c(%rsp)
               	movb	$-0x2b, 0x8d(%rsp)
               	leaq	0x80(%rsp), %r9
               	movb	$-0x2a, 0x8e(%rsp)
               	movb	$-0x29, 0x8f(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpq	$0xa2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movw	$0x8ad0, 0x40(%rsp)     # imm = 0x8AD0
               	movw	$0xa628, 0x42(%rsp)     # imm = 0xA628
               	movw	$0xc180, 0x44(%rsp)     # imm = 0xC180
               	movw	$0xdcd8, 0x46(%rsp)     # imm = 0xDCD8
               	movw	$0xf830, 0x48(%rsp)     # imm = 0xF830
               	movw	$0x1388, 0x4a(%rsp)     # imm = 0x1388
               	movw	$0x2ee0, 0x4c(%rsp)     # imm = 0x2EE0
               	leaq	0x40(%rsp), %rbx
               	movw	$0x4a38, 0x4e(%rsp)     # imm = 0x4A38
               	movq	$-0x3039, %rdi          # imm = 0xCFC7
               	movq	%rbx, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %rdx
               	movups	%xmm0, 0x80(%rsp)
               	xorl	%eax, %eax
               	movswq	(%rdx,%rax,2), %rsi
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movq	$-0x3039, %rcx          # imm = 0xCFC7
               	cmpl	%ecx, %esi
               	je	<addr>
               	jmp	<addr>
               	movswq	(%rbx,%rax,2), %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movswq	0x4c(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movw	$0xffff, 0x80(%rsp)     # imm = 0xFFFF
               	movw	$0xfffe, 0x82(%rsp)     # imm = 0xFFFE
               	movw	$0xfffd, 0x84(%rsp)     # imm = 0xFFFD
               	movw	$0xfffc, 0x86(%rsp)     # imm = 0xFFFC
               	movw	$0xfffb, 0x88(%rsp)     # imm = 0xFFFB
               	movw	$0xfffa, 0x8a(%rsp)     # imm = 0xFFFA
               	movw	$0xfff9, 0x8c(%rsp)     # imm = 0xFFF9
               	leaq	0x80(%rsp), %r9
               	movw	$0xfff8, 0x8e(%rsp)     # imm = 0xFFF8
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpq	$0xfffe, %rax           # imm = 0xFFFE
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	movl	$0x75bcd15, %edi        # imm = 0x75BCD15
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$-0x7, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x75bcd15, %rax        # imm = 0x75BCD15
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$-0x3b9aca08, %rax      # imm = 0xC46535F8
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpq	$-0x7735940e, %rax      # imm = 0x88CA6BF2
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movl	$0x80000002, %r11d      # imm = 0x80000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movq	$-0x5, %rdi
               	movabsq	$0x123456789a, %rsi     # imm = 0x123456789A
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %r9
               	movups	%xmm0, 0x80(%rsp)
               	movq	0x80(%rsp), %rax
               	cmpq	$-0xa, %rax
               	jne	<addr>
               	movq	0x88(%rsp), %rax
               	movabsq	$0x2468acf134, %r11     # imm = 0x2468ACF134
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movabsq	$0x6d3a06d39c, %r11     # imm = 0x6D3A06D39C
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	movl	$0x41200000, %eax       # imm = 0x41200000
               	movq	%rax, %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0,0,0]
               	movl	$0x41a00000, %eax       # imm = 0x41A00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x2, %xmm0, %xmm1 # xmm1 = xmm0[2,0,0,0]
               	movl	$0xc0e00000, %eax       # imm = 0xC0E00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movl	$0x41080000, %eax       # imm = 0x41080000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movl	$0x40a80000, %eax       # imm = 0x40A80000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	movabsq	$0x4020800000000000, %rax # imm = 0x4020800000000000
               	movq	%rax, %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movabsq	$0x401f000000000000, %rax # imm = 0x401F000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movabsq	$0x4039000000000000, %rax # imm = 0x4039000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0xffc2f700, 0x40(%rsp) # imm = 0xFFC2F700
               	movl	$0xffd23943, 0x44(%rsp) # imm = 0xFFD23943
               	movl	$0xffe17b86, 0x48(%rsp) # imm = 0xFFE17B86
               	movl	$0xfff0bdc9, 0x4c(%rsp) # imm = 0xFFF0BDC9
               	movl	$0xc, 0x50(%rsp)
               	movl	$0xf424f, 0x54(%rsp)    # imm = 0xF424F
               	movl	$0x1e8492, 0x58(%rsp)   # imm = 0x1E8492
               	leaq	0x40(%rsp), %r9
               	movl	$0x2dc6d5, 0x5c(%rsp)   # imm = 0x2DC6D5
               	movl	$0x4d, %ebx
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x80(%rsp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	cmpl	%ecx, %esi
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movq	$-0x4d, %rcx
               	jmp	<addr>
               	leaq	0x40(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	shlq	%rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %r9
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movl	0x5c(%rsp), %ecx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	movl	0x48(%rsp), %edx
               	shlq	%rdx
               	movslq	%edx, %rdx
               	subq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r9)
               	movabsq	$-0x3fe8000000000000, %rax # imm = 0xC018000000000000
               	movq	%rax, %xmm1
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm1 # xmm1 = xmm1[0,0]
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movabsq	$0x4042000000000000, %rax # imm = 0x4042000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movw	$0x0, 0x80(%rsp)
               	movw	$0xfc18, 0x82(%rsp)     # imm = 0xFC18
               	movw	$0xf830, 0x84(%rsp)     # imm = 0xF830
               	movw	$0xf448, 0x86(%rsp)     # imm = 0xF448
               	movw	$0xf060, 0x88(%rsp)     # imm = 0xF060
               	movw	$0xec78, 0x8a(%rsp)     # imm = 0xEC78
               	movw	$0xe890, 0x8c(%rsp)     # imm = 0xE890
               	movw	$0xe4a8, 0x8e(%rsp)     # imm = 0xE4A8
               	movw	$0xe0c0, 0x90(%rsp)     # imm = 0xE0C0
               	movw	$0xdcd8, 0x92(%rsp)     # imm = 0xDCD8
               	movw	$0xd8f0, 0x94(%rsp)     # imm = 0xD8F0
               	movw	$0xd508, 0x96(%rsp)     # imm = 0xD508
               	movw	$0xd120, 0x98(%rsp)     # imm = 0xD120
               	movw	$0xcd38, 0x9a(%rsp)     # imm = 0xCD38
               	leaq	0x80(%rsp), %r9
               	movw	$0xc950, 0x9c(%rsp)     # imm = 0xC950
               	movw	$0xc568, 0x9e(%rsp)     # imm = 0xC568
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	cmpq	$-0x6590, %rax          # imm = 0x9A70
               	je	<addr>
               	movl	$0x14, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0xffffffce, (%rsp)     # imm = 0xFFFFFFCE
               	movl	$0xffffffcf, 0x4(%rsp)  # imm = 0xFFFFFFCF
               	movl	$0xffffffd2, 0x8(%rsp)  # imm = 0xFFFFFFD2
               	movl	$0xffffffd7, 0xc(%rsp)  # imm = 0xFFFFFFD7
               	movl	$0xffffffde, 0x10(%rsp) # imm = 0xFFFFFFDE
               	movl	$0xffffffe7, 0x14(%rsp) # imm = 0xFFFFFFE7
               	movl	$0xfffffff2, 0x18(%rsp) # imm = 0xFFFFFFF2
               	movl	$0xffffffff, 0x1c(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xe, 0x20(%rsp)
               	movl	$0x1f, 0x24(%rsp)
               	movl	$0x32, 0x28(%rsp)
               	movl	$0x47, 0x2c(%rsp)
               	movl	$0x5e, 0x30(%rsp)
               	movl	$0x77, 0x34(%rsp)
               	leaq	(%rsp), %r9
               	movl	$0x92, 0x38(%rsp)
               	movl	$0xaf, 0x3c(%rsp)
               	leaq	0x80(%rsp), %rdi
               	movq	$-0x1f, %rbx
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
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rbx, %rsi
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rdx)
               	vmovups	0x20(%rax), %ymm14
               	vmovups	%ymm14, 0x20(%rdx)
               	xorl	%eax, %eax
               	movl	(%rdx,%rax,4), %esi
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	cmpl	%ecx, %esi
               	je	<addr>
               	jmp	<addr>
               	leaq	(%rsp), %rcx
               	movl	(%rcx,%rax,4), %ecx
               	shlq	%rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	(%rsp), %r9
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
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x124, %rax            # imm = 0x124
               	je	<addr>
               	movl	$0x16, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movq	$0x0, 0x80(%rsp)
               	movabsq	$-0x100000000, %rax     # imm = 0xFFFFFFFF00000000
               	movq	%rax, 0x88(%rsp)
               	movabsq	$-0x200000000, %rax     # imm = 0xFFFFFFFE00000000
               	movq	%rax, 0x90(%rsp)
               	movabsq	$-0x300000000, %rax     # imm = 0xFFFFFFFD00000000
               	movq	%rax, 0x98(%rsp)
               	movabsq	$-0x400000000, %rax     # imm = 0xFFFFFFFC00000000
               	movq	%rax, 0xa0(%rsp)
               	movabsq	$-0x500000000, %rax     # imm = 0xFFFFFFFB00000000
               	movq	%rax, 0xa8(%rsp)
               	movabsq	$-0x600000000, %rax     # imm = 0xFFFFFFFA00000000
               	movq	%rax, 0xb0(%rsp)
               	leaq	0x80(%rsp), %r9
               	movabsq	$-0x700000000, %rax     # imm = 0xFFFFFFF900000000
               	movq	%rax, 0xb8(%rsp)
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
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	movabsq	$-0x500000001, %r11     # imm = 0xFFFFFFFAFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x15, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x10, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
