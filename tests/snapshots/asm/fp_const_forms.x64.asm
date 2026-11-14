
fp_const_forms.x64:	file format elf64-x86-64

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

<pass>:
               	retq

<passf>:
               	retq

<mix>:
               	movsd	<rip>, %xmm3
               	cvtss2sd	%xmm1, %xmm1
               	vfmadd213sd	%xmm1, %xmm3, %xmm0 # xmm0 = (xmm3 * xmm0) + xmm1
               	addsd	%xmm2, %xmm0
               	retq

<ret_milli>:
               	movsd	<rip>, %xmm0
               	retq

<ret_hundred>:
               	movsd	<rip>, %xmm0
               	retq

<ret_tenth_f>:
               	movss	<rip>, %xmm0
               	retq

<ret_neg_zero>:
               	movsd	<rip>, %xmm0
               	retq

<pick>:
               	testl	%edi, %edi
               	je	<addr>
               	movabsq	$0x4004000000000000, %r11 # imm = 0x4004000000000000
               	movq	%r11, %xmm0
               	retq
               	movabsq	$0x3f50624dd2f1a9fc, %r11 # imm = 0x3F50624DD2F1A9FC
               	movq	%r11, %xmm0
               	jmp	<addr>

<pickf>:
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0xbe800000, %r11d      # imm = 0xBE800000
               	movq	%r11, %xmm0
               	retq
               	movl	$0x40490fd0, %r11d      # imm = 0x40490FD0
               	movq	%r11, %xmm0
               	jmp	<addr>

<store_all>:
               	movq	$0x0, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movl	$0xc0200000, <rip> # imm = 0xC0200000
                                                # <addr>
               	movl	$0x49742400, <rip> # imm = 0x49742400
                                                # <addr>
               	movl	$0x3dcccccd, <rip> # imm = 0x3DCCCCCD
                                                # <addr>
               	retq

<loop_calls>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	xorps	%xmm1, %xmm1
               	movabsq	$0x3fe0000000000000, %r10 # imm = 0x3FE0000000000000
               	movq	%r10, 0x18(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm1, 0x10(%rsp)
               	callq	<addr>
               	movsd	0x10(%rsp), %xmm1
               	vfmadd132sd	0x18(%rsp), %xmm0, %xmm1 # xmm1 = (xmm1 * mem) + xmm0
               	movsd	%xmm1, 0x10(%rsp)
               	movapd	%xmm1, %xmm0
               	callq	<addr>
               	movsd	0x10(%rsp), %xmm1
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm0
               	jp	<addr>
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	movapd	%xmm1, %xmm0
               	popq	%rbx
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, 0x8(%rsp)
               	movss	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, (%rsp)
               	xorps	%xmm0, %xmm0
               	movsd	0x8(%rsp), %xmm1
               	vmulsd	%xmm0, %xmm1, %xmm2
               	movsd	<rip>, %xmm3
               	mulsd	%xmm3, %xmm1
               	movq	%xmm2, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	<rip>, %xmm3
               	vdivsd	%xmm2, %xmm3, %xmm4
               	comisd	%xmm4, %xmm0
               	jb	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%xmm1, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	vdivsd	%xmm1, %xmm3, %xmm2
               	comisd	%xmm0, %xmm2
               	jb	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0
               	movsd	(%rsp), %xmm14
               	vmulss	%xmm0, %xmm14, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movsd	0x8(%rsp), %xmm1
               	vmulsd	%xmm0, %xmm1, %xmm2
               	ucomisd	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	vmulsd	%xmm0, %xmm1, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$-0x3ffc000000000000, %r11 # imm = 0xC004000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	vfmsub132sd	0x8(%rsp), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) - xmm1
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0
               	movsd	(%rsp), %xmm1
               	vmulss	%xmm0, %xmm1, %xmm2
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0
               	vmulss	%xmm0, %xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0xbe800000, %eax       # imm = 0xBE800000
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	vfmadd132ss	(%rsp), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rsp), %xmm14
               	vmulsd	%xmm1, %xmm14, %xmm0
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movsd	0x8(%rsp), %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x4090000000000000, %r11 # imm = 0x4090000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rsp), %xmm14
               	vmulsd	%xmm1, %xmm14, %xmm0
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$0x3fb999999999999a, %r11 # imm = 0x3FB999999999999A
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	callq	<addr>
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	jne	<addr>
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movsd	0x8(%rsp), %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x400921fb54442d18, %r11 # imm = 0x400921FB54442D18
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0
               	movsd	(%rsp), %xmm14
               	vmulss	%xmm0, %xmm14, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x40490fd0, %eax       # imm = 0x40490FD0
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0
               	movsd	(%rsp), %xmm14
               	vmulss	%xmm0, %xmm14, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x49742400, %eax       # imm = 0x49742400
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	movsd	0x8(%rsp), %xmm14
               	vmulsd	%xmm0, %xmm14, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x412e848000000000, %r11 # imm = 0x412E848000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	$0x3dcccccd, %rax       # imm = 0x3DCCCCCD
               	jne	<addr>
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	callq	<addr>
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x40490fd0, %eax       # imm = 0x40490FD0
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	callq	<addr>
               	movsd	%xmm0, (%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	vaddsd	%xmm0, %xmm1, %xmm0
               	movsd	(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	vfmadd132sd	0x8(%rsp), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	movsd	<rip>, %xmm1
               	vfmadd132sd	0x8(%rsp), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	vmulsd	0x8(%rsp), %xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rax
               	movabsq	$0x3fd3333333333333, %r11 # imm = 0x3FD3333333333333
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	movss	%xmm0, -0x8(%rbp)
               	cmpl	$0x0, -0x8(%rbp)
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x49742400, %eax       # imm = 0x49742400
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
