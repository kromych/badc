
fp_const_forms.x64:	file format elf64-x86-64

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

<pass>:
               	retq

<passf>:
               	retq

<mix>:
               	cvtss2sd	%xmm1, %xmm1
               	vfmadd132sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
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
               	subq	$0x20, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	xorps	%xmm1, %xmm1
               	movsd	<rip>, %xmm0
               	movsd	%xmm1, 0x18(%rsp)
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm1
               	vfmadd132sd	<rip>, %xmm0, %xmm1 # xmm1 = (xmm1 * mem) + xmm0
               	movsd	%xmm1, 0x18(%rsp)
               	movapd	%xmm1, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm1
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	movapd	%xmm1, %xmm0
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	movsd	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm14 # <addr>
               	movsd	%xmm14, (%rsp)
               	xorps	%xmm1, %xmm1
               	vmulsd	%xmm1, %xmm0, %xmm2
               	vmulsd	<rip>, %xmm0, %xmm3
               	movsd	%xmm0, 0x8(%rsp)
               	movq	%xmm2, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	vdivsd	%xmm2, %xmm0, %xmm4
               	comisd	%xmm4, %xmm1
               	jb	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	%xmm3, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	divsd	%xmm3, %xmm0
               	comisd	%xmm1, %xmm0
               	jb	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	(%rsp), %xmm14
               	vmulss	<rip>, %xmm14, %xmm0
               	movss	%xmm0, 0x18(%rsp)
               	movl	0x18(%rsp), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	0x8(%rsp), %xmm0
               	vmulsd	<rip>, %xmm0, %xmm1
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vmulsd	<rip>, %xmm0, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$-0x3ffc000000000000, %r11 # imm = 0xC004000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	vfmsub132sd	0x8(%rsp), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) - xmm1
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	(%rsp), %xmm0
               	vmulss	<rip>, %xmm0, %xmm1
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vmulss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x18(%rsp)
               	movl	0x18(%rsp), %eax
               	cmpl	$0xbe800000, %eax       # imm = 0xBE800000
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	vfmadd132ss	(%rsp), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rsp), %xmm14
               	vmulsd	<rip>, %xmm14, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	0x8(%rsp), %xmm14
               	vmulsd	<rip>, %xmm14, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x4090000000000000, %r11 # imm = 0x4090000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rsp), %xmm14
               	vmulsd	<rip>, %xmm14, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%xmm0, %rax
               	movabsq	$0x3fb999999999999a, %r11 # imm = 0x3FB999999999999A
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x28, %rsp
               	retq
               	callq	<addr>
               	movss	%xmm0, 0x18(%rsp)
               	movl	0x18(%rsp), %eax
               	cmpl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	jne	<addr>
               	movss	<rip>, %xmm0
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	0x8(%rsp), %xmm14
               	vmulsd	<rip>, %xmm14, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x400921fb54442d18, %r11 # imm = 0x400921FB54442D18
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	(%rsp), %xmm14
               	vmulss	<rip>, %xmm14, %xmm0
               	movss	%xmm0, 0x18(%rsp)
               	movl	0x18(%rsp), %eax
               	cmpl	$0x40490fd0, %eax       # imm = 0x40490FD0
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	(%rsp), %xmm14
               	vmulss	<rip>, %xmm14, %xmm0
               	movss	%xmm0, 0x18(%rsp)
               	movl	0x18(%rsp), %eax
               	cmpl	$0x49742400, %eax       # imm = 0x49742400
               	jne	<addr>
               	movsd	0x8(%rsp), %xmm14
               	vmulsd	<rip>, %xmm14, %xmm0
               	movq	%xmm0, %rax
               	movabsq	$0x412e848000000000, %r11 # imm = 0x412E848000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%xmm0, %rax
               	cmpq	$0x3dcccccd, %rax       # imm = 0x3DCCCCCD
               	jne	<addr>
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	%xmm0, 0x18(%rsp)
               	movl	0x18(%rsp), %eax
               	cmpl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	callq	<addr>
               	movss	%xmm0, 0x18(%rsp)
               	movl	0x18(%rsp), %eax
               	cmpl	$0x40490fd0, %eax       # imm = 0x40490FD0
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	callq	<addr>
               	movsd	%xmm0, (%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	vaddsd	<rip>, %xmm0, %xmm0
               	movsd	(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	vfmadd132sd	0x8(%rsp), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	movsd	0x8(%rsp), %xmm14
               	vfmadd213sd	<rip>, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm0) + mem
               	vmulsd	0x8(%rsp), %xmm0, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x28, %rsp
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
               	addq	$0x28, %rsp
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movq	%xmm0, %rax
               	movabsq	$0x3fd3333333333333, %r11 # imm = 0x3FD3333333333333
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x28, %rsp
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	movss	%xmm0, 0x18(%rsp)
               	cmpl	$0x0, 0x18(%rsp)
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x28, %rsp
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	movss	%xmm0, 0x18(%rsp)
               	movl	0x18(%rsp), %eax
               	cmpl	$0x49742400, %eax       # imm = 0x49742400
               	jne	<addr>
               	movss	<rip>, %xmm0 # <addr>
               	movss	%xmm0, 0x18(%rsp)
               	movl	0x18(%rsp), %eax
               	cmpl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
