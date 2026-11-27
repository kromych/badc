
mmx_sse3_and_mm_malloc_intrinsics.x64:	file format elf64-x86-64

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

<mmx>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x64, %r11d
               	vmovd	%r11d, %xmm0
               	vpbroadcastb	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	vpaddb	%xmm0, %xmm0, %xmm1
               	vmovq	%xmm1, %rax
               	movabsq	$-0x3737373737373738, %r11 # imm = 0xC8C8C8C8C8C8C8C8
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpaddsb	%xmm0, %xmm0, %xmm1
               	vmovq	%xmm1, %rax
               	movabsq	$0x7f7f7f7f7f7f7f7f, %r11 # imm = 0x7F7F7F7F7F7F7F7F
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0xc8, %r11d
               	vmovd	%r11d, %xmm1
               	vpbroadcastb	%xmm1, %xmm1
               	vmovq	%xmm1, %xmm1            # xmm1 = xmm1[0],zero
               	vpaddusb	%xmm0, %xmm1, %xmm1
               	vmovq	%xmm1, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x5, %r11d
               	vmovd	%r11d, %xmm1
               	vpbroadcastw	%xmm1, %xmm1
               	vmovq	%xmm1, %xmm1            # xmm1 = xmm1[0],zero
               	movl	$0x7, %r11d
               	vmovd	%r11d, %xmm2
               	vpbroadcastw	%xmm2, %xmm2
               	vmovq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero
               	vpsubusw	%xmm2, %xmm1, %xmm1
               	vmovq	%xmm1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8300, %r11d          # imm = 0x8300
               	vmovd	%r11d, %xmm1
               	vpbroadcastw	%xmm1, %xmm1
               	vmovq	%xmm1, %xmm1            # xmm1 = xmm1[0],zero
               	movl	$0x3e8, %r11d           # imm = 0x3E8
               	vmovd	%r11d, %xmm2
               	vpbroadcastw	%xmm2, %xmm2
               	vmovq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero
               	vpsubsw	%xmm2, %xmm1, %xmm1
               	vmovq	%xmm1, %rax
               	movabsq	$-0x7fff7fff7fff8000, %r11 # imm = 0x8000800080008000
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpcmpeqd	%xmm2, %xmm2, %xmm2
               	vmovq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero
               	movl	$0x1, %r11d
               	vmovd	%r11d, %xmm1
               	vpbroadcastw	%xmm1, %xmm1
               	vmovq	%xmm1, %xmm1            # xmm1 = xmm1[0],zero
               	vpaddusw	%xmm1, %xmm2, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x9c, %r11d
               	vmovd	%r11d, %xmm2
               	vpbroadcastb	%xmm2, %xmm2
               	vmovq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero
               	vpsubsb	%xmm0, %xmm2, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7f7f7f7f7f7f7f80, %r11 # imm = 0x8080808080808080
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm2
               	vpmaddwd	%xmm2, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0x3500000011, %r11     # imm = 0x3500000011
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x8000, %r11d          # imm = 0x8000
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	vpmaddwd	%xmm0, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0xfffe, %r11d          # imm = 0xFFFE
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	movl	$0x4000, %r11d          # imm = 0x4000
               	vmovd	%r11d, %xmm2
               	vpbroadcastw	%xmm2, %xmm2
               	vmovq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero
               	vpmulhw	%xmm2, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x12c, %r11d           # imm = 0x12C
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	vpmullw	%xmm0, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0x5f905f905f905f90, %r11 # imm = 0x5F905F905F905F90
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movabsq	$-0x7fff7fff7fff8000, %rax # imm = 0x8000800080008000
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fff7fff7fff8000, %r11 # imm = 0x8000800080008000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	$0x0, -0x8(%rbp)
               	movabsq	$0xf0000000f, %rax      # imm = 0xF0000000F
               	movq	%rax, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0xf0000000f, %r11      # imm = 0xF0000000F
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm2
               	vpcmpeqw	%xmm2, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0xffff0000ffff, %r11   # imm = 0xFFFF0000FFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm2
               	vpcmpgtd	%xmm2, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	vpxor	%xmm2, %xmm2, %xmm2
               	vmovq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero
               	vpcmpgtb	%xmm2, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	vpaddw	%xmm1, %xmm0, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0x5000400030002, %r11  # imm = 0x5000400030002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	emms
               	xorl	%eax, %eax
               	leave
               	retq

<sse3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm5
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	addss	%xmm3, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm4 # xmm4 = xmm0[3,0,0,0]
               	vaddss	%xmm4, %xmm3, %xmm6
               	vpermilps	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm4 # xmm4 = xmm1[1,0,0,0]
               	vaddss	%xmm4, %xmm3, %xmm7
               	vpermilps	$0x2, %xmm1, %xmm3 # xmm3 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm4 # xmm4 = xmm1[3,0,0,0]
               	addss	%xmm4, %xmm3
               	ucomiss	<rip>, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm6, %xmm2
               	ucomiss	<rip>, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm7, %xmm2
               	ucomiss	<rip>, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm2
               	ucomiss	<rip>, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	vpermilps	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	subss	%xmm3, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm4 # xmm4 = xmm0[3,0,0,0]
               	vsubss	%xmm4, %xmm3, %xmm6
               	vpermilps	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm4 # xmm4 = xmm1[1,0,0,0]
               	vsubss	%xmm4, %xmm3, %xmm7
               	vpermilps	$0x2, %xmm1, %xmm3 # xmm3 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	subss	%xmm1, %xmm3
               	movapd	%xmm2, %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm6, %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm7, %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	vpermilps	$0x0, %xmm5, %xmm2 # xmm2 = xmm5[0,0,0,0]
               	subss	%xmm2, %xmm1
               	vpermilps	$0x1, %xmm0, %xmm2 # xmm2 = xmm0[1,0,0,0]
               	vpermilps	$0x1, %xmm5, %xmm3 # xmm3 = xmm5[1,0,0,0]
               	addss	%xmm3, %xmm2
               	vpermilps	$0x2, %xmm0, %xmm3 # xmm3 = xmm0[2,0,0,0]
               	vpermilps	$0x2, %xmm5, %xmm4 # xmm4 = xmm5[2,0,0,0]
               	subss	%xmm4, %xmm3
               	vpermilps	$0x3, %xmm0, %xmm4 # xmm4 = xmm0[3,0,0,0]
               	vpermilps	$0x3, %xmm5, %xmm5 # xmm5 = xmm5[3,0,0,0]
               	addss	%xmm5, %xmm4
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm2, %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm4, %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	vpermilps	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm2 # xmm2 = xmm0[3,0,0,0]
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	vpermilps	$0x2, %xmm0, %xmm0 # xmm0 = xmm0[2,0,0,0]
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm2, %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	vpermilpd	$0x0, %xmm1, %xmm3 # xmm3 = xmm1[0,0]
               	subsd	%xmm3, %xmm2
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	vpermilpd	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0]
               	addsd	%xmm1, %xmm0
               	movapd	%xmm2, %xmm1
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	vpermilpd	$0x0, %xmm0, %xmm2 # xmm2 = xmm0[0,0]
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	addsd	%xmm0, %xmm2
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	vpermilpd	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0]
               	vaddsd	%xmm1, %xmm0, %xmm3
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	vpermilpd	$0x0, %xmm0, %xmm4 # xmm4 = xmm0[0,0]
               	vpermilpd	$0x1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
               	subsd	%xmm0, %xmm4
               	vpermilpd	$0x0, %xmm1, %xmm0 # xmm0 = xmm1[0,0]
               	vpermilpd	$0x1, %xmm1, %xmm1 # xmm1 = xmm1[1,0]
               	subsd	%xmm1, %xmm0
               	movapd	%xmm2, %xmm1
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm4, %xmm1
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0]
               	movapd	%xmm0, %xmm3
               	ucomisd	%xmm0, %xmm3
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm0, %xmm3
               	ucomisd	%xmm0, %xmm3
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm2, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm1, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movb	%al, -0x18(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x11, %eax
               	jl	<addr>
               	movups	-0x17(%rbp), %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpl	$0x4030201, %eax        # imm = 0x4030201
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %edx
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffffffbf, %r11d      # imm = 0xFFFFFFBF
               	andq	%r11, %rax
               	orq	$0x40, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %ecx
               	andq	$0x40, %rcx
               	xorq	$0x40, %rcx
               	movl	%edx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	cmpl	%edx, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<wait_on>:
               	movq	%rdi, %rax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	monitor
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	mwait
               	retq

<main>:
               	subq	$0x18, %rsp
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x18, %rsp
               	retq
               	leaq	0x8(%rsp), %rdi
               	movl	$0x40, %esi
               	movl	$0x64, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testb	$0x3f, %cl
               	jne	<addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x64, %eax
               	jl	<addr>
               	movq	%rcx, %rdi
               	callq	<addr>
               	leaq	0x8(%rsp), %rdi
               	movl	$0x8, %esi
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	jmp	<addr>
               	movq	0x8(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	testb	$0x7, %al
               	jne	<addr>
               	movq	%rax, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
