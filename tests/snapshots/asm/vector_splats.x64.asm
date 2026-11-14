
vector_splats.x64:	file format elf64-x86-64

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

<s8c>:
               	movsbq	%dil, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastb	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	retq

<s4s>:
               	movswq	%di, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	retq

<s2i>:
               	vmovd	%edi, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	retq

<s2f>:
               	vbroadcastss	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	retq

<s16c>:
               	movsbq	%dil, %rax
               	vmovd	%eax, %xmm0
               	vpbroadcastb	%xmm0, %xmm0
               	retq

<s8us>:
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	vmovd	%edi, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	retq

<s4i>:
               	vmovd	%edi, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	retq

<s2l>:
               	vmovq	%rdi, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	retq

<s4f>:
               	vbroadcastss	%xmm0, %xmm0
               	retq

<s2d>:
               	vmovddup	%xmm0, %xmm0            # xmm0 = xmm0[0,0]
               	retq

<s32uc>:
               	andq	$0xff, %rdi
               	vmovd	%edi, %xmm0
               	vpbroadcastb	%xmm0, %ymm0
               	retq

<s8i>:
               	vmovd	%edi, %xmm0
               	vpbroadcastd	%xmm0, %ymm0
               	retq

<s8f>:
               	vbroadcastss	%xmm0, %ymm0
               	retq

<s4d>:
               	vbroadcastsd	%xmm0, %ymm0
               	retq

<s16i>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movl	%esi, (%rax)
               	movl	%esi, 0x4(%rax)
               	movl	%esi, 0x8(%rax)
               	movl	%esi, 0xc(%rax)
               	movl	%esi, 0x10(%rax)
               	movl	%esi, 0x14(%rax)
               	movl	%esi, 0x18(%rax)
               	movl	%esi, 0x1c(%rax)
               	movl	%esi, 0x20(%rax)
               	movl	%esi, 0x24(%rax)
               	movl	%esi, 0x28(%rax)
               	movl	%esi, 0x2c(%rax)
               	movl	%esi, 0x30(%rax)
               	movl	%esi, 0x34(%rax)
               	movl	%esi, 0x38(%rax)
               	movl	%esi, 0x3c(%rax)
               	leave
               	retq

<s8l>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movq	%rsi, 0x20(%rax)
               	movq	%rsi, 0x28(%rax)
               	movq	%rsi, 0x30(%rax)
               	movq	%rsi, 0x38(%rax)
               	leave
               	retq

<k_byte>:
               	movl	$0x3, %r11d
               	vmovd	%r11d, %xmm0
               	vpbroadcastb	%xmm0, %xmm0
               	retq

<k_half>:
               	movl	$0x1200, %r11d          # imm = 0x1200
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	retq

<k_word>:
               	movl	$0x120000, %r11d        # imm = 0x120000
               	vmovd	%r11d, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	retq

<k_inv>:
               	movl	$0xffffedff, %r11d      # imm = 0xFFFFEDFF
               	vmovd	%r11d, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	retq

<k_bytes>:
               	movabsq	$-0xff00ffff00ff01, %r11 # imm = 0xFF00FF0000FF00FF
               	vmovq	%r11, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	retq

<k_other>:
               	movl	$0x12345, %r11d         # imm = 0x12345
               	vmovd	%r11d, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	retq

<k_zero>:
               	vpxor	%xmm0, %xmm0, %xmm0
               	retq

<k_ones>:
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	retq

<k_d8>:
               	movl	$0x12345, %r11d         # imm = 0x12345
               	vmovd	%r11d, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	retq

<k_y32>:
               	movl	$0x12345, %r11d         # imm = 0x12345
               	vmovd	%r11d, %xmm0
               	vpbroadcastd	%xmm0, %ymm0
               	retq

<k_y32_ones>:
               	vpcmpeqd	%ymm0, %ymm0, %ymm0
               	retq

<k_lanes>:
               	movabsq	$-0xf8f9fafbfcfdff, %r11 # imm = 0xFF07060504030201
               	vmovq	%r11, %xmm0
               	retq

<k_lane_read>:
               	movl	$0x155df3, %eax         # imm = 0x155DF3
               	retq

<add_k>:
               	vmovd	%edi, %xmm1
               	vpbroadcastd	%xmm1, %xmm1
               	vpaddd	%xmm1, %xmm0, %xmm0
               	retq

<lane_of>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	vmovd	%edi, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	andq	$0x3, %rsi
               	movl	-0x10(%rbp,%rsi,4), %eax
               	movq	%rdi, %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<dlane_of>:
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	movl	$0x12345681, -0x20(%rbp) # imm = 0x12345681
               	movabsq	$0x7fedcba987654321, %rax # imm = 0x7FEDCBA987654321
               	movq	%rax, -0x18(%rbp)
               	movl	$0xc0300000, -0x10(%rbp) # imm = 0xC0300000
               	movabsq	$0x7e37e43c8800759c, %rax # imm = 0x7E37E43C8800759C
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movslq	-0x20(%rbp), %rbx
               	movq	-0x18(%rbp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	vpextrb	$0x0, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	movsbq	%bl, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrb	$0x1, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	vpextrw	$0x0, %xmm0, %ecx
               	movswq	%cx, %rcx
               	movswq	%bx, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrw	$0x1, %xmm0, %ecx
               	movswq	%cx, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x2, %xmm0, %ecx
               	movswq	%cx, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x3, %xmm0, %ecx
               	movswq	%cx, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	-0x68(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	movsd	%xmm0, -0x70(%rbp)
               	movapd	%xmm0, %xmm14
               	vmovd	%xmm14, %ecx
               	movslq	%ecx, %rcx
               	movq	-0x68(%rbp), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movsd	-0x70(%rbp), %xmm14
               	vpextrd	$0x1, %xmm14, %ecx
               	movslq	%ecx, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movss	-0x10(%rbp), %xmm0
               	vzeroupper
               	callq	<addr>
               	leaq	-0x28(%rbp), %rcx
               	movsd	%xmm0, -0x28(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movss	(%rdx), %xmm1
               	movss	-0x10(%rbp), %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	vpextrb	$0x0, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	movsbq	%bl, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrb	$0x1, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0xa, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0xb, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0xc, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0xd, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	vpextrw	$0x0, %xmm0, %ecx
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrw	$0x1, %xmm0, %ecx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x2, %xmm0, %ecx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x3, %xmm0, %ecx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x4, %xmm0, %ecx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x5, %xmm0, %ecx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x6, %xmm0, %ecx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrw	$0x7, %xmm0, %eax
               	movq	%rbx, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x68(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %ecx
               	movslq	%ecx, %rcx
               	movq	-0x68(%rbp), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrd	$0x1, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %ecx
               	movslq	%ecx, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	-0x68(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %rax
               	cmpq	-0x68(%rbp), %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrq	$0x1, %xmm0, %rax
               	cmpq	-0x68(%rbp), %rax
               	jne	<addr>
               	movss	-0x10(%rbp), %xmm0
               	vzeroupper
               	callq	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movups	%xmm0, -0x30(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movss	(%rdx), %xmm1
               	movss	-0x10(%rbp), %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	vzeroupper
               	callq	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movups	%xmm0, -0x30(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx), %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	vmovups	%ymm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movzbq	-0x40(%rbp,%rax), %rsi
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jb	<addr>
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm1
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm1
               	vpextrd	$0x1, %xmm1, %eax
               	movslq	%eax, %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm1
               	vpextrd	$0x2, %xmm1, %eax
               	movslq	%eax, %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movss	-0x10(%rbp), %xmm0
               	vzeroupper
               	callq	<addr>
               	leaq	-0x40(%rbp), %rcx
               	vmovups	%ymm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rcx, %rdx
               	movss	(%rdx), %xmm1
               	movss	-0x10(%rbp), %xmm2
               	ucomiss	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	vzeroupper
               	callq	<addr>
               	leaq	-0x40(%rbp), %rcx
               	vmovups	%ymm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rcx, %rdx
               	movsd	(%rdx), %xmm1
               	movsd	-0x8(%rbp), %xmm2
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	leaq	0x40(%rsp), %rdi
               	movq	%rbx, %rsi
               	vzeroupper
               	callq	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	(%rsp), %rax
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	vmovups	0x20(%rcx), %ymm14
               	vmovups	%ymm14, 0x20(%rax)
               	leaq	-0x60(%rbp), %rcx
               	vmovups	(%rax), %ymm14
               	vmovups	%ymm14, (%rcx)
               	vmovups	0x20(%rax), %ymm14
               	vmovups	%ymm14, 0x20(%rcx)
               	movl	(%rsp), %eax
               	cmpl	%ebx, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	0x4(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x8(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0xc(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x10(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x14(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x18(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x1c(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x20(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x24(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x28(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x2c(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x30(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x34(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x38(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	movl	0x3c(%rsp), %eax
               	cmpl	%ebx, %eax
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	movq	-0x68(%rbp), %rsi
               	vzeroupper
               	callq	<addr>
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rdx
               	movq	0x58(%rsp), %rsi
               	movq	0x60(%rsp), %rdi
               	movq	0x68(%rsp), %r8
               	movq	0x70(%rsp), %r9
               	movq	0x78(%rsp), %r10
               	movq	%r10, -0x78(%rbp)
               	cmpq	-0x68(%rbp), %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movq	-0x68(%rbp), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	cmpq	%rax, %rdx
               	jne	<addr>
               	cmpq	%rax, %rsi
               	jne	<addr>
               	cmpq	%rax, %rdi
               	jne	<addr>
               	cmpq	%rax, %r8
               	jne	<addr>
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	-0x78(%rbp), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movsd	-0x70(%rbp), %xmm14
               	vmovq	%xmm14, %rcx
               	movl	%eax, %edx
               	shlq	$0x20, %rax
               	orq	%rdx, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	leaq	0x40(%rsp), %r9
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r9)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	movl	0x40(%rsp), %ecx
               	addq	%rbx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	movl	0x44(%rsp), %ecx
               	addq	%rbx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	movl	0x48(%rsp), %ecx
               	addq	%rbx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	movl	0x4c(%rsp), %ecx
               	addq	%rbx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x5, %esi
               	movq	%rbx, %rdi
               	vzeroupper
               	callq	<addr>
               	shlq	%rbx
               	cmpl	%ebx, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movsd	-0x8(%rbp), %xmm0
               	vzeroupper
               	callq	<addr>
               	movsd	-0x8(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vzeroupper
               	callq	<addr>
               	vpextrb	$0x0, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrb	$0x1, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0xa, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0xb, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0xc, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0xd, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	movsbq	%al, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vzeroupper
               	callq	<addr>
               	vpextrw	$0x0, %xmm0, %eax
               	cmpq	$0x1200, %rax           # imm = 0x1200
               	je	<addr>
               	movl	$0x16, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrw	$0x1, %xmm0, %eax
               	cmpq	$0x1200, %rax           # imm = 0x1200
               	jne	<addr>
               	vpextrw	$0x2, %xmm0, %eax
               	cmpq	$0x1200, %rax           # imm = 0x1200
               	jne	<addr>
               	vpextrw	$0x3, %xmm0, %eax
               	cmpq	$0x1200, %rax           # imm = 0x1200
               	jne	<addr>
               	vpextrw	$0x4, %xmm0, %eax
               	cmpq	$0x1200, %rax           # imm = 0x1200
               	jne	<addr>
               	vpextrw	$0x5, %xmm0, %eax
               	cmpq	$0x1200, %rax           # imm = 0x1200
               	jne	<addr>
               	vpextrw	$0x6, %xmm0, %eax
               	cmpq	$0x1200, %rax           # imm = 0x1200
               	jne	<addr>
               	vpextrw	$0x7, %xmm0, %eax
               	cmpq	$0x1200, %rax           # imm = 0x1200
               	jne	<addr>
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x120000, %rax         # imm = 0x120000
               	je	<addr>
               	movl	$0x17, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x120000, %rax         # imm = 0x120000
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x120000, %rax         # imm = 0x120000
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x120000, %rax         # imm = 0x120000
               	jne	<addr>
               	vzeroupper
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$-0x1201, %rax          # imm = 0xEDFF
               	je	<addr>
               	movl	$0x18, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$-0x1201, %rax          # imm = 0xEDFF
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$-0x1201, %rax          # imm = 0xEDFF
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$-0x1201, %rax          # imm = 0xEDFF
               	jne	<addr>
               	vzeroupper
               	callq	<addr>
               	vmovq	%xmm0, %rax
               	movabsq	$-0xff00ffff00ff01, %r11 # imm = 0xFF00FF0000FF00FF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vpextrq	$0x1, %xmm0, %rax
               	movabsq	$-0xff00ffff00ff01, %r11 # imm = 0xFF00FF0000FF00FF
               	cmpq	%r11, %rax
               	jne	<addr>
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	xorl	%eax, %eax
               	movl	-0x30(%rbp,%rax,4), %edx
               	cmpl	$0x12345, %edx          # imm = 0x12345
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	xorl	%eax, %eax
               	cmpl	$0x0, -0x30(%rbp,%rax,4)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	vzeroupper
               	callq	<addr>
               	movups	%xmm0, -0x30(%rbp)
               	xorl	%eax, %eax
               	movl	-0x30(%rbp,%rax,4), %edx
               	cmpl	$-0x1, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jb	<addr>
               	vzeroupper
               	callq	<addr>
               	movsd	%xmm0, -0x28(%rbp)
               	xorl	%eax, %eax
               	movl	-0x28(%rbp,%rax,4), %edx
               	cmpl	$0x12345, %edx          # imm = 0x12345
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	vzeroupper
               	callq	<addr>
               	vmovups	%ymm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movl	-0x40(%rbp,%rax,4), %edx
               	cmpl	$0x12345, %edx          # imm = 0x12345
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	vzeroupper
               	callq	<addr>
               	vmovups	%ymm0, -0x40(%rbp)
               	xorl	%eax, %eax
               	movl	-0x40(%rbp,%rax,4), %edx
               	cmpl	$-0x1, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jb	<addr>
               	vzeroupper
               	callq	<addr>
               	movsd	%xmm0, -0x28(%rbp)
               	xorl	%eax, %eax
               	movsbq	-0x28(%rbp,%rax), %rdx
               	leaq	0x1(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	movsbq	-0x21(%rbp), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	vzeroupper
               	callq	<addr>
               	cmpl	$0x155df3, %eax         # imm = 0x155DF3
               	je	<addr>
               	movl	$0x22, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x20, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x1f, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x1e, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x1d, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x1c, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x1b, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x1a, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0xe, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0xd, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0xb, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0xa, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x9, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	vzeroupper
               	leave
               	retq
