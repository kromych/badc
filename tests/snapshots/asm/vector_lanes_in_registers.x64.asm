
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
               	vpaddb	%xmm0, %xmm0, %xmm0
               	retq

<get_c>:
               	vpaddb	%xmm0, %xmm0, %xmm1
               	vpextrb	$0x5, %xmm1, %eax
               	movsbq	%al, %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	vpextrb	$0xf, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	addq	%rcx, %rax
               	retq

<get_uc>:
               	vpaddb	%xmm0, %xmm0, %xmm0
               	vpextrb	$0x9, %xmm0, %eax
               	retq

<put_s>:
               	movswq	%di, %rdi
               	vpinsrw	$0x0, %edi, %xmm0, %xmm0
               	vpinsrw	$0x7, %edi, %xmm0, %xmm0
               	vpsubw	%xmm0, %xmm0, %xmm1
               	vpaddw	%xmm0, %xmm1, %xmm0
               	retq

<get_s>:
               	vpor	%xmm0, %xmm0, %xmm0
               	vpextrw	$0x6, %xmm0, %eax
               	movswq	%ax, %rax
               	retq

<get_us>:
               	vpor	%xmm0, %xmm0, %xmm0
               	vpextrw	$0x1, %xmm0, %eax
               	retq

<put_i>:
               	vpinsrd	$0x2, %edi, %xmm0, %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	retq

<get_i>:
               	vpaddd	%xmm0, %xmm0, %xmm0
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	retq

<get_u>:
               	vpaddd	%xmm0, %xmm0, %xmm0
               	vpextrd	$0x3, %xmm0, %eax
               	retq

<mk_l>:
               	vmovq	%rdi, %xmm0
               	vpinsrq	$0x1, %rsi, %xmm0, %xmm0
               	vpaddq	%xmm0, %xmm0, %xmm0
               	retq

<get_l>:
               	movl	$0x3, %eax
               	vpextrq	$0x1, %xmm0, %rcx
               	imulq	%rcx, %rax
               	retq

<put_f>:
               	movss	<rip>, %xmm2
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	mulss	%xmm2, %xmm3
               	vmovd	%xmm3, %r11d
               	vmovd	%r11d, %xmm3
               	mulss	%xmm2, %xmm1
               	vmovd	%xmm1, %r11d
               	movapd	%xmm3, %xmm1
               	vpinsrd	$0x1, %r11d, %xmm1, %xmm1
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	mulss	%xmm2, %xmm3
               	vmovd	%xmm3, %r11d
               	vpinsrd	$0x2, %r11d, %xmm1, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	mulss	%xmm2, %xmm0
               	vmovd	%xmm0, %r11d
               	movapd	%xmm1, %xmm0
               	vpinsrd	$0x3, %r11d, %xmm0, %xmm0
               	retq

<get_f>:
               	movss	<rip>, %xmm1
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	addss	%xmm1, %xmm0
               	retq

<put_d>:
               	movsd	<rip>, %xmm2
               	subsd	%xmm2, %xmm0
               	subsd	%xmm2, %xmm1
               	vunpcklpd	%xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0],xmm1[0]
               	retq

<get_d>:
               	vmulpd	%xmm0, %xmm0, %xmm1
               	vmulpd	%xmm0, %xmm0, %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	vaddsd	%xmm0, %xmm1, %xmm0
               	retq

<put_i8>:
               	vmovdqa	%xmm0, %xmm1
               	vpinsrd	$0x1, %edi, %xmm1, %xmm1
               	vinserti128	$0x0, %xmm1, %ymm0, %ymm1
               	movq	%rdi, %rax
               	negq	%rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
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
               	vunpcklpd	%xmm1, %xmm2, %xmm1 # xmm1 = xmm2[0],xmm1[0]
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmulpd	%ymm0, %ymm0, %ymm0
               	retq

<get_d4>:
               	vaddpd	%ymm0, %ymm0, %ymm0
               	vextracti128	$0x1, %ymm0, %xmm0
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

<three>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rdi, -0x60(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	vmovd	%xmm0, %r11d
               	vmovd	%r11d, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vmovd	%r11d, %xmm0
               	vmovd	%xmm1, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	vmovd	%xmm2, %r11d
               	vmovd	%r11d, %xmm0
               	movq	%rax, %xmm15
               	vmovd	%xmm15, %r11d
               	vpinsrd	$0x1, %r11d, %xmm0, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x60(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	subq	$0xc0, %rsp
               	andq	$-0x40, %rsp
               	movw	$0x2b32, 0x40(%rsp)     # imm = 0x2B32
               	movw	$0x1d24, 0x42(%rsp)     # imm = 0x1D24
               	movw	$0xf16, 0x44(%rsp)      # imm = 0xF16
               	movw	$0x108, 0x46(%rsp)      # imm = 0x108
               	movw	$0xf3fa, 0x48(%rsp)     # imm = 0xF3FA
               	movw	$0xe5ec, 0x4a(%rsp)     # imm = 0xE5EC
               	movw	$0xd7de, 0x4c(%rsp)     # imm = 0xD7DE
               	leaq	0x40(%rsp), %r9
               	movw	$0xc9d0, 0x4e(%rsp)     # imm = 0xC9D0
               	movq	$-0x3c, %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, 0x80(%rsp)
               	leaq	-0x10(%rbp), %rcx
               	leaq	0x40(%rsp), %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movb	$-0x3c, -0xd(%rbp)
               	movb	$-0x3d, -0x1(%rbp)
               	xorl	%eax, %eax
               	movsbq	0x80(%rsp,%rax), %rsi
               	movsbq	-0x10(%rbp,%rax), %rdi
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
               	vzeroupper
               	leave
               	retq
               	movw	$0xc9c8, 0x80(%rsp)     # imm = 0xC9C8
               	movw	$0xcbca, 0x82(%rsp)     # imm = 0xCBCA
               	movw	$0xcdcc, 0x84(%rsp)     # imm = 0xCDCC
               	movw	$0xcfce, 0x86(%rsp)     # imm = 0xCFCE
               	movw	$0xd1d0, 0x88(%rsp)     # imm = 0xD1D0
               	movw	$0xd3d2, 0x8a(%rsp)     # imm = 0xD3D2
               	movw	$0xd5d4, 0x8c(%rsp)     # imm = 0xD5D4
               	leaq	0x80(%rsp), %r9
               	movw	$0xd7d6, 0x8e(%rsp)     # imm = 0xD7D6
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpq	$0xa2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xa6288ad0, 0x40(%rsp) # imm = 0xA6288AD0
               	movl	$0xdcd8c180, 0x44(%rsp) # imm = 0xDCD8C180
               	movl	$0x1388f830, 0x48(%rsp) # imm = 0x1388F830
               	leaq	0x40(%rsp), %rdx
               	movl	$0x4a382ee0, 0x4c(%rsp) # imm = 0x4A382EE0
               	movq	$-0x3039, %rdi          # imm = 0xCFC7
               	movq	%rdx, -0x28(%rbp)
               	movq	%rdx, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movq	-0x28(%rbp), %rdx
               	movups	%xmm0, 0x80(%rsp)
               	xorl	%eax, %eax
               	movswq	0x80(%rsp,%rax,2), %rdi
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movq	$-0x3039, %rcx          # imm = 0xCFC7
               	cmpl	%ecx, %edi
               	je	<addr>
               	jmp	<addr>
               	movswq	0x40(%rsp,%rax,2), %rcx
               	cmpl	%ecx, %edi
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
               	vzeroupper
               	leave
               	retq
               	movl	$0xfffeffff, 0x80(%rsp) # imm = 0xFFFEFFFF
               	movl	$0xfffcfffd, 0x84(%rsp) # imm = 0xFFFCFFFD
               	movl	$0xfffafffb, 0x88(%rsp) # imm = 0xFFFAFFFB
               	leaq	0x80(%rsp), %r9
               	movl	$0xfff8fff9, 0x8c(%rsp) # imm = 0xFFF8FFF9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	cmpq	$0xfffe, %rax           # imm = 0xFFFE
               	je	<addr>
               	movl	$0x6, %eax
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
               	vzeroupper
               	leave
               	retq
               	movq	$-0x5, %rdi
               	movabsq	$0x123456789a, %rsi     # imm = 0x123456789A
               	vzeroupper
               	callq	<addr>
               	leaq	0x80(%rsp), %r9
               	movups	%xmm0, 0x80(%rsp)
               	vmovq	%xmm0, %rax
               	cmpq	$-0xa, %rax
               	jne	<addr>
               	vpextrq	$0x1, %xmm0, %rax
               	movabsq	$0x2468acf134, %r11     # imm = 0x2468ACF134
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
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
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	movss	<rip>, %xmm0
               	movapd	%xmm0, %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	movss	<rip>, %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0,0,0]
               	movss	<rip>, %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x2, %xmm0, %xmm1 # xmm1 = xmm0[2,0,0,0]
               	movss	<rip>, %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	movsd	<rip>, %xmm0
               	movapd	%xmm0, %xmm1
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	vzeroupper
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	vzeroupper
               	leave
               	retq
               	movabsq	$-0x2dc6bc003d0900, %rax # imm = 0xFFD23943FFC2F700
               	movq	%rax, 0x40(%rsp)
               	movabsq	$-0xf4236001e847a, %rax # imm = 0xFFF0BDC9FFE17B86
               	movq	%rax, 0x48(%rsp)
               	movabsq	$0xf424f0000000c, %rax  # imm = 0xF424F0000000C
               	movq	%rax, 0x50(%rsp)
               	movabsq	$0x2dc6d5001e8492, %rax # imm = 0x2DC6D5001E8492
               	leaq	0x40(%rsp), %r9
               	movq	%rax, 0x58(%rsp)
               	movl	$0x4d, %edx
               	movq	%rdx, -0x30(%rbp)
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rdx, %rdi
               	callq	<addr>
               	movq	-0x30(%rbp), %rdx
               	vmovups	%ymm0, 0x80(%rsp)
               	xorl	%eax, %eax
               	movl	0x80(%rsp,%rax,4), %edi
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	%rdx, %rcx
               	shlq	%rcx
               	cmpl	%ecx, %edi
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movq	$-0x4d, %rcx
               	jmp	<addr>
               	movl	0x40(%rsp,%rax,4), %ecx
               	shlq	%rcx
               	cmpl	%ecx, %edi
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
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%r9)
               	movsd	<rip>, %xmm0
               	movapd	%xmm0, %xmm1
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm1
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	0x80(%rsp), %r9
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xfc180000, 0x80(%rsp) # imm = 0xFC180000
               	movl	$0xf448f830, 0x84(%rsp) # imm = 0xF448F830
               	movl	$0xec78f060, 0x88(%rsp) # imm = 0xEC78F060
               	movl	$0xe4a8e890, 0x8c(%rsp) # imm = 0xE4A8E890
               	movl	$0xdcd8e0c0, 0x90(%rsp) # imm = 0xDCD8E0C0
               	movl	$0xd508d8f0, 0x94(%rsp) # imm = 0xD508D8F0
               	movl	$0xcd38d120, 0x98(%rsp) # imm = 0xCD38D120
               	leaq	0x80(%rsp), %r9
               	movl	$0xc568c950, 0x9c(%rsp) # imm = 0xC568C950
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	cmpq	$-0x6590, %rax          # imm = 0x9A70
               	je	<addr>
               	movl	$0x14, %eax
               	vzeroupper
               	leave
               	retq
               	movabsq	$-0x3000000032, %rax    # imm = 0xFFFFFFCFFFFFFFCE
               	movq	%rax, (%rsp)
               	movabsq	$-0x280000002e, %rax    # imm = 0xFFFFFFD7FFFFFFD2
               	movq	%rax, 0x8(%rsp)
               	movabsq	$-0x1800000022, %rax    # imm = 0xFFFFFFE7FFFFFFDE
               	movq	%rax, 0x10(%rsp)
               	movq	$-0xe, 0x18(%rsp)
               	movabsq	$0x1f0000000e, %rax     # imm = 0x1F0000000E
               	movq	%rax, 0x20(%rsp)
               	movabsq	$0x4700000032, %rax     # imm = 0x4700000032
               	movq	%rax, 0x28(%rsp)
               	movabsq	$0x770000005e, %rax     # imm = 0x770000005E
               	movq	%rax, 0x30(%rsp)
               	leaq	(%rsp), %r9
               	movabsq	$0xaf00000092, %rax     # imm = 0xAF00000092
               	movq	%rax, 0x38(%rsp)
               	leaq	0x80(%rsp), %rdi
               	movq	$-0x1f, %rdx
               	movq	%rdx, -0x38(%rbp)
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
               	movq	%rdx, %rsi
               	vzeroupper
               	callq	<addr>
               	addq	$0x40, %rsp
               	movq	-0x38(%rbp), %rdx
               	leaq	0x80(%rsp), %rax
               	leaq	0x40(%rsp), %rsi
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rsi)
               	vmovups	0x20(%rax), %ymm14
               	vmovups	%ymm14, 0x20(%rsi)
               	xorl	%eax, %eax
               	movl	0x40(%rsp,%rax,4), %edi
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movq	%rdx, %rcx
               	shlq	%rcx
               	cmpl	%ecx, %edi
               	je	<addr>
               	jmp	<addr>
               	movl	(%rsp,%rax,4), %ecx
               	shlq	%rcx
               	cmpl	%ecx, %edi
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
               	vzeroupper
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	movss	<rip>, %xmm2
               	vzeroupper
               	callq	<addr>
               	movss	-0x18(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x14(%rbp), %xmm1
               	xorps	%xmm0, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	-0x10(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	-0xc(%rbp), %xmm1
               	movss	<rip>, %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	-0x8(%rbp), %xmm1
               	movss	<rip>, %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movss	-0x4(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x18, %eax
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x15, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x10, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x4, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	vzeroupper
               	leave
               	retq
