
avx_halves_and_casts.x64:	file format elf64-x86-64

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

<half>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	testl	%edi, %edi
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	movups	%xmm0, -0x20(%rbp)
               	movups	(%rax), %xmm0
               	vzeroupper
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movups	%xmm0, -0x10(%rbp)
               	jmp	<addr>

<put>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	testl	%edi, %edi
               	je	<addr>
               	leaq	(%rsp), %rax
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	vmovups	(%rax), %ymm0
               	leave
               	retq
               	leaq	0x20(%rsp), %rax
               	vinserti128	$0x0, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	jmp	<addr>

<sum>:
               	vmovdqa	%xmm0, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpaddd	%xmm0, %xmm1, %xmm0
               	vpunpckhqdq	%xmm0, %xmm0, %xmm1 # xmm1 = xmm0[1,1]
               	vpaddd	%xmm1, %xmm0, %xmm0
               	pshufd	$0xb1, %xmm0, %xmm1     # xmm1 = xmm0[1,0,3,2]
               	vpaddd	%xmm1, %xmm0, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	vzeroupper
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movl	$0xffc2f700, -0xd0(%rbp) # imm = 0xFFC2F700
               	movl	$0xffd23943, -0xcc(%rbp) # imm = 0xFFD23943
               	movl	$0xffe17b86, -0xc8(%rbp) # imm = 0xFFE17B86
               	movl	$0xfff0bdc9, -0xc4(%rbp) # imm = 0xFFF0BDC9
               	movl	$0xc, -0xc0(%rbp)
               	movl	$0xf424f, -0xbc(%rbp)   # imm = 0xF424F
               	movl	$0x1e8492, -0xb8(%rbp)  # imm = 0x1E8492
               	movl	$0x2dc6d5, -0xb4(%rbp)  # imm = 0x2DC6D5
               	movl	$0xffffffff, -0x100(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xfffffff8, -0xfc(%rbp) # imm = 0xFFFFFFF8
               	movl	$0xfffffff1, -0xf8(%rbp) # imm = 0xFFFFFFF1
               	movl	$0xffffffea, -0xf4(%rbp) # imm = 0xFFFFFFEA
               	vmovups	-0xd0(%rbp), %ymm0
               	leaq	(%rsp), %r9
               	vmovups	%ymm0, (%rsp)
               	movups	-0x100(%rbp), %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	xorl	%edi, %edi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movups	%xmm0, -0xb0(%rbp)
               	leaq	-0xb0(%rbp), %rdi
               	leaq	-0xd0(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	(%rsp), %r9
               	movl	$0x1, %edi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	movups	%xmm0, -0xb0(%rbp)
               	leaq	-0xb0(%rbp), %rdi
               	leaq	-0xd0(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	vmovups	(%rsp), %ymm0
               	movups	%xmm0, -0xb0(%rbp)
               	leaq	-0xd0(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	xorl	%edi, %edi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovups	%ymm0, -0xb0(%rbp)
               	leaq	-0xb0(%rbp), %rdi
               	leaq	-0x100(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	leaq	-0xd0(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x1, %edi
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovups	%ymm0, -0xb0(%rbp)
               	leaq	-0xb0(%rbp), %rdi
               	leaq	-0xd0(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	leaq	-0x100(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	-0xf0(%rbp), %rax
               	vxorps	%ymm14, %ymm14, %ymm14
               	vmovups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rdi
               	movups	0x20(%rsp), %xmm0
               	vmovdqa	%xmm0, %xmm0
               	vmovups	%ymm0, -0xb0(%rbp)
               	leaq	-0x100(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	leaq	-0xf0(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	vmovups	(%rsp), %ymm0
               	movups	0x20(%rsp), %xmm1
               	vmovdqa	%xmm0, %xmm0
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, -0xb0(%rbp)
               	leaq	-0xd0(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	leaq	-0x100(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	-0xb0(%rbp), %rdi
               	movups	0x20(%rsp), %xmm0
               	vmovdqa	%xmm0, %xmm1
               	vinserti128	$0x1, %xmm0, %ymm1, %ymm0
               	vmovups	%ymm0, -0xb0(%rbp)
               	leaq	-0x100(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	leaq	-0x100(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	vzeroupper
               	leave
               	retq
               	movl	-0xd0(%rbp), %eax
               	movl	-0xcc(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xc8(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xc4(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xc0(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xbc(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xb8(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0xb4(%rbp), %ecx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, -0x108(%rbp)
               	leaq	(%rsp), %r9
               	movq	%r9, %r10
               	vmovups	(%r10), %ymm0
               	callq	<addr>
               	cmpl	-0x108(%rbp), %eax
               	je	<addr>
               	movl	$0x9, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xbfa00000, -0x30(%rbp) # imm = 0xBFA00000
               	movl	$0xbf400000, -0x2c(%rbp) # imm = 0xBF400000
               	movl	$0xbe800000, -0x28(%rbp) # imm = 0xBE800000
               	movl	$0x3e800000, -0x24(%rbp) # imm = 0x3E800000
               	movl	$0x3f400000, -0x20(%rbp) # imm = 0x3F400000
               	movl	$0x3fa00000, -0x1c(%rbp) # imm = 0x3FA00000
               	movl	$0x3fe00000, -0x18(%rbp) # imm = 0x3FE00000
               	leaq	-0x30(%rbp), %rax
               	movl	$0x40100000, -0x14(%rbp) # imm = 0x40100000
               	movl	$0x42c80000, -0xe0(%rbp) # imm = 0x42C80000
               	movl	$0x42ca0000, -0xdc(%rbp) # imm = 0x42CA0000
               	movl	$0x42cc0000, -0xd8(%rbp) # imm = 0x42CC0000
               	movl	$0x42ce0000, -0xd4(%rbp) # imm = 0x42CE0000
               	vmovups	-0x30(%rbp), %ymm14
               	vmovups	%ymm14, -0x120(%rbp)
               	leaq	-0x90(%rbp), %rdi
               	vmovups	-0x120(%rbp), %ymm14
               	vextracti128	$0x1, %ymm14, %xmm0
               	movups	%xmm0, -0x90(%rbp)
               	leaq	0x10(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0xe0(%rbp), %rsi
               	movups	-0xe0(%rbp), %xmm0
               	vmovups	-0x120(%rbp), %ymm14
               	vinserti128	$0x0, %xmm0, %ymm14, %ymm0
               	vmovups	%ymm0, -0x90(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	vzeroupper
               	leave
               	retq
               	vmovups	-0x120(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	vmovdqa	%xmm0, %xmm2
               	vaddps	%xmm2, %xmm1, %xmm1
               	vextracti128	$0x1, %ymm0, %xmm2
               	vextracti128	$0x1, %ymm0, %xmm3
               	vaddps	%xmm3, %xmm2, %xmm2
               	vmovdqa	%xmm1, %xmm1
               	vinserti128	$0x1, %xmm2, %ymm1, %ymm1
               	vmovups	%ymm1, -0x90(%rbp)
               	vpermilps	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0,0,0]
               	movss	-0x30(%rbp), %xmm2
               	addss	%xmm2, %xmm2
               	ucomiss	%xmm2, %xmm3
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	vzeroupper
               	leave
               	retq
               	vpermilps	$0x1, %xmm1, %xmm3 # xmm3 = xmm1[1,0,0,0]
               	movss	-0x2c(%rbp), %xmm2
               	addss	%xmm2, %xmm2
               	ucomiss	%xmm2, %xmm3
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x2, %xmm1, %xmm2 # xmm2 = xmm1[2,0,0,0]
               	movss	-0x28(%rbp), %xmm1
               	addss	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	-0x84(%rbp), %xmm2
               	movss	-0x24(%rbp), %xmm1
               	addss	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	-0x80(%rbp), %xmm2
               	movss	-0x20(%rbp), %xmm1
               	addss	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	-0x7c(%rbp), %xmm2
               	movss	-0x1c(%rbp), %xmm1
               	addss	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	leaq	-0x90(%rbp), %rdi
               	movss	-0x78(%rbp), %xmm2
               	leaq	-0x30(%rbp), %rsi
               	movss	-0x18(%rbp), %xmm1
               	addss	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	-0x74(%rbp), %xmm2
               	movss	-0x14(%rbp), %xmm1
               	addss	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movups	%xmm0, -0x90(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	vzeroupper
               	leave
               	retq
               	leaq	<rip>, %rax
               	vmovups	(%rax), %ymm1
               	vextracti128	$0x1, %ymm1, %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	movabsq	$0x7e37e43c8800759c, %rax # imm = 0x7E37E43C8800759C
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	vzeroupper
               	leave
               	retq
               	vmovdqa	%xmm1, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	vmovups	%ymm0, -0x70(%rbp)
               	vpermilpd	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0]
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilpd	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
               	movabsq	$-0x3ffc000000000000, %rax # imm = 0xC004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpermilpd	$0x0, %xmm15, %xmm1 # xmm1 = xmm15[0,0]
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vextracti128	$0x1, %ymm0, %xmm15
               	vpermilpd	$0x1, %xmm15, %xmm0 # xmm0 = xmm15[1,0]
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xf, %eax
               	vzeroupper
               	leave
               	retq
               	vzeroupper
               	leave
               	retq
