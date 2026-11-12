
mmx_sse3_and_mm_malloc_intrinsics.x64:	file format elf64-x86-64

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

<mmx>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x64, %r11d
               	vmovd	%r11d, %xmm0
               	vpbroadcastb	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	movapd	%xmm0, %xmm1
               	paddb	%xmm0, %xmm1
               	vmovq	%xmm1, %rax
               	movabsq	$-0x3737373737373738, %r11 # imm = 0xC8C8C8C8C8C8C8C8
               	cmpq	%r11, %rax
               	jne	<addr>
               	movapd	%xmm0, %xmm1
               	paddsb	%xmm0, %xmm1
               	vmovq	%xmm1, %rax
               	movabsq	$0x7f7f7f7f7f7f7f7f, %r11 # imm = 0x7F7F7F7F7F7F7F7F
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0xc8, %r11d
               	vmovd	%r11d, %xmm1
               	vpbroadcastb	%xmm1, %xmm1
               	vmovq	%xmm1, %xmm1            # xmm1 = xmm1[0],zero
               	paddusb	%xmm0, %xmm1
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
               	psubusw	%xmm2, %xmm1
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
               	psubsw	%xmm2, %xmm1
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
               	paddusw	%xmm1, %xmm2
               	vmovq	%xmm2, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x9c, %r11d
               	vmovd	%r11d, %xmm2
               	vpbroadcastb	%xmm2, %xmm2
               	vmovq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero
               	movapd	%xmm2, %xmm15
               	psubsb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7f7f7f7f7f7f7f80, %r11 # imm = 0x8080808080808080
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm2
               	pmaddwd	%xmm2, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0x3500000011, %r11     # imm = 0x3500000011
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x8000, %r11d          # imm = 0x8000
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	movapd	%xmm0, %xmm15
               	pmaddwd	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
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
               	pmulhw	%xmm2, %xmm0
               	vmovq	%xmm0, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x12c, %r11d           # imm = 0x12C
               	vmovd	%r11d, %xmm0
               	vpbroadcastw	%xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	movapd	%xmm0, %xmm15
               	pmullw	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0x5f905f905f905f90, %r11 # imm = 0x5F905F905F905F90
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movw	$0x8000, -0x8(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x6(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x4(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x2(%rbp)     # imm = 0x8000
               	movsd	-0x8(%rbp), %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$-0x7fff7fff7fff8000, %r11 # imm = 0x8000800080008000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	$0x0, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	vmovq	%xmm0, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0xf, -0x8(%rbp)
               	movl	$0xf, -0x4(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	vmovq	%xmm0, %rcx
               	movabsq	$0xf0000000f, %r11      # imm = 0xF0000000F
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, -0x8(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movabsq	$0xfffffffffffffff, %rax # imm = 0xFFFFFFFFFFFFFFF
               	movq	%rax, -0x8(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm2
               	pcmpeqw	%xmm2, %xmm0
               	vmovq	%xmm0, %rax
               	movabsq	$0xffff0000ffff, %r11   # imm = 0xFFFF0000FFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm2
               	pcmpgtd	%xmm2, %xmm0
               	vmovq	%xmm0, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	vmovq	%xmm0, %xmm0            # xmm0 = xmm0[0],zero
               	vpxor	%xmm2, %xmm2, %xmm2
               	vmovq	%xmm2, %xmm2            # xmm2 = xmm2[0],zero
               	pcmpgtb	%xmm2, %xmm0
               	vmovq	%xmm0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	paddw	%xmm1, %xmm0
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
               	movups	(%rax), %xmm2
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm4 # xmm4 = xmm0[1,0,0,0]
               	addss	%xmm4, %xmm3
               	vpermilps	$0x2, %xmm0, %xmm4 # xmm4 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm5 # xmm5 = xmm0[3,0,0,0]
               	addss	%xmm5, %xmm4
               	vpermilps	$0x0, %xmm1, %xmm5 # xmm5 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm6 # xmm6 = xmm1[1,0,0,0]
               	addss	%xmm6, %xmm5
               	vpermilps	$0x2, %xmm1, %xmm6 # xmm6 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm7 # xmm7 = xmm1[3,0,0,0]
               	addss	%xmm7, %xmm6
               	movl	$0x40400000, %ecx       # imm = 0x40400000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm3
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm4, %xmm3
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm3
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm5, %xmm3
               	movl	$0x41300000, %eax       # imm = 0x41300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm3
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm6, %xmm3
               	movl	$0x41700000, %eax       # imm = 0x41700000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm3
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	vpermilps	$0x1, %xmm0, %xmm4 # xmm4 = xmm0[1,0,0,0]
               	subss	%xmm4, %xmm3
               	vpermilps	$0x2, %xmm0, %xmm4 # xmm4 = xmm0[2,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm5 # xmm5 = xmm0[3,0,0,0]
               	subss	%xmm5, %xmm4
               	vpermilps	$0x0, %xmm1, %xmm5 # xmm5 = xmm1[0,0,0,0]
               	vpermilps	$0x1, %xmm1, %xmm6 # xmm6 = xmm1[1,0,0,0]
               	subss	%xmm6, %xmm5
               	vpermilps	$0x2, %xmm1, %xmm6 # xmm6 = xmm1[2,0,0,0]
               	vpermilps	$0x3, %xmm1, %xmm1 # xmm1 = xmm1[3,0,0,0]
               	subss	%xmm1, %xmm6
               	movapd	%xmm3, %xmm1
               	movl	$0xbf800000, %eax       # imm = 0xBF800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm4, %xmm1
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm5, %xmm1
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm6, %xmm1
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	vpermilps	$0x0, %xmm2, %xmm3 # xmm3 = xmm2[0,0,0,0]
               	subss	%xmm3, %xmm1
               	vpermilps	$0x1, %xmm0, %xmm3 # xmm3 = xmm0[1,0,0,0]
               	vpermilps	$0x1, %xmm2, %xmm4 # xmm4 = xmm2[1,0,0,0]
               	addss	%xmm4, %xmm3
               	vpermilps	$0x2, %xmm0, %xmm4 # xmm4 = xmm0[2,0,0,0]
               	vpermilps	$0x2, %xmm2, %xmm5 # xmm5 = xmm2[2,0,0,0]
               	subss	%xmm5, %xmm4
               	vpermilps	$0x3, %xmm0, %xmm5 # xmm5 = xmm0[3,0,0,0]
               	vpermilps	$0x3, %xmm2, %xmm2 # xmm2 = xmm2[3,0,0,0]
               	vaddss	%xmm2, %xmm5, %xmm2
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm4, %xmm1
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm2, %xmm1
               	movl	$0x40900000, %eax       # imm = 0x40900000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	vpermilps	$0x1, %xmm0, %xmm1 # xmm1 = xmm0[1,0,0,0]
               	vpermilps	$0x3, %xmm0, %xmm2 # xmm2 = xmm0[3,0,0,0]
               	vpermilps	$0x0, %xmm0, %xmm3 # xmm3 = xmm0[0,0,0,0]
               	vpermilps	$0x2, %xmm0, %xmm0 # xmm0 = xmm0[2,0,0,0]
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm2, %xmm1
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
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
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x4006000000000000, %rax # imm = 0x4006000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
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
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm3, %xmm1
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm4, %xmm1
               	movabsq	$-0x4010000000000000, %rcx # imm = 0xBFF0000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movabsq	$-0x4000000000000000, %rcx # imm = 0xC000000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movabsq	$0x4019000000000000, %rcx # imm = 0x4019000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm1
               	vpermilpd	$0x0, %xmm1, %xmm2 # xmm2 = xmm1[0,0]
               	movapd	%xmm0, %xmm3
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm3
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm2, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movapd	%xmm1, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	movups	-0x1f(%rbp), %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpl	$0x4030201, %eax        # imm = 0x4030201
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %ecx
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
               	movl	-0x8(%rbp), %eax
               	andq	$0x40, %rax
               	movq	%rax, %rdx
               	xorq	$0x40, %rdx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	cmpl	%ecx, %eax
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
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
               	leave
               	retq
               	movl	$0x64, %edx
               	movl	$0x40, %esi
               	leaq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rcx
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
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x10, %edx
               	movl	$0x8, %esi
               	leaq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	testb	$0x7, %al
               	jne	<addr>
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
