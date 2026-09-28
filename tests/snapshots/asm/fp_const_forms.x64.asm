
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
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	addsd	%xmm2, %xmm0
               	retq

<ret_milli>:
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm14
               	movapd	%xmm14, %xmm0
               	retq

<ret_hundred>:
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movq	%rax, %xmm14
               	movapd	%xmm14, %xmm0
               	retq

<ret_tenth_f>:
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm14
               	movapd	%xmm14, %xmm0
               	retq

<ret_neg_zero>:
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, %xmm14
               	movapd	%xmm14, %xmm0
               	retq

<pick>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movabsq	$0x4004000000000000, %r11 # imm = 0x4004000000000000
               	movq	%r11, %xmm0
               	retq
               	movabsq	$0x3f50624dd2f1a9fc, %r11 # imm = 0x3F50624DD2F1A9FC
               	movq	%r11, %xmm0
               	jmp	<addr>

<pickf>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0xbe800000, %r11d      # imm = 0xBE800000
               	movq	%r11, %xmm0
               	retq
               	movl	$0x40490fd0, %r11d      # imm = 0x40490FD0
               	movq	%r11, %xmm0
               	jmp	<addr>

<store_all>:
               	leaq	<rip>, %rax
               	movq	$0x0, (%rax)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x8(%rax)
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x10(%rax)
               	movabsq	$0x3fd3333333333333, %rcx # imm = 0x3FD3333333333333
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x18(%rax)
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movl	$0xc0200000, 0x4(%rax)  # imm = 0xC0200000
               	movl	$0x49742400, 0x8(%rax)  # imm = 0x49742400
               	movl	$0x3dcccccd, 0xc(%rax)  # imm = 0x3DCCCCCD
               	retq

<loop_calls>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm14
               	movsd	%xmm14, 0x18(%rsp)
               	movabsq	$0x3fe0000000000000, %r12 # imm = 0x3FE0000000000000
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movq	%r12, %xmm15
               	movapd	%xmm0, %xmm13
               	vfmadd231sd	%xmm15, %xmm14, %xmm13 # xmm13 = (xmm14 * xmm15) + xmm13
               	movsd	%xmm13, 0x18(%rsp)
               	movsd	0x18(%rsp), %xmm0
               	callq	<addr>
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	incq	%rbx
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	movsd	0x18(%rsp), %xmm14
               	movapd	%xmm14, %xmm0
               	movq	0x18(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movabsq	$-0x4010000000000000, %rax # imm = 0xBFF0000000000000
               	movq	%rax, %xmm14
               	movapd	%xmm14, %xmm0
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	leaq	<rip>, %rax
               	movss	(%rax), %xmm14
               	movsd	%xmm14, (%rsp)
               	xorl	%eax, %eax
               	movsd	0x8(%rsp), %xmm0
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm1, -0x10(%rbp)
               	cmpq	$0x0, -0x10(%rbp)
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm2
               	divsd	%xmm1, %xmm2
               	movq	%rax, %xmm15
               	ucomisd	%xmm2, %xmm15
               	jb	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	%rcx, %xmm1
               	divsd	%xmm0, %xmm1
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jb	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movq	%rax, %xmm15
               	movsd	(%rsp), %xmm0
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movsd	0x8(%rsp), %xmm0
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	mulsd	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movabsq	$-0x3ffc000000000000, %rax # imm = 0xC004000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$-0x3ffc000000000000, %r11 # imm = 0xC004000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movabsq	$0x403f000000000000, %rax # imm = 0x403F000000000000
               	movabsq	$0x3fc0000000000000, %rcx # imm = 0x3FC0000000000000
               	movsd	0x8(%rsp), %xmm14
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	vfmsub231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movabsq	$0x403ee00000000000, %rax # imm = 0x403EE00000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movsd	(%rsp), %xmm0
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	mulss	%xmm15, %xmm1
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movl	$0xbe800000, %eax       # imm = 0xBE800000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movl	$0xbe800000, %r11d      # imm = 0xBE800000
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x3e000000, %eax       # imm = 0x3E000000
               	movl	$0x3f800000, %ecx       # imm = 0x3F800000
               	movsd	(%rsp), %xmm14
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	vfmadd231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movl	$0x3f900000, %eax       # imm = 0x3F900000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	callq	<addr>
               	movabsq	$0x4059000000000000, %rax # imm = 0x4059000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	movsd	0x8(%rsp), %xmm0
               	mulsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movabsq	$0x4090000000000000, %rax # imm = 0x4090000000000000
               	movq	%rax, %xmm15
               	movsd	0x8(%rsp), %xmm0
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x4090000000000000, %r11 # imm = 0x4090000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	callq	<addr>
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	movsd	0x8(%rsp), %xmm0
               	mulsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movabsq	$0x3fb999999999999a, %rax # imm = 0x3FB999999999999A
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
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
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm0
               	callq	<addr>
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movabsq	$0x400921fb54442d18, %rax # imm = 0x400921FB54442D18
               	movq	%rax, %xmm15
               	movsd	0x8(%rsp), %xmm0
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x400921fb54442d18, %r11 # imm = 0x400921FB54442D18
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movl	$0x40490fd0, %eax       # imm = 0x40490FD0
               	movq	%rax, %xmm15
               	movsd	(%rsp), %xmm0
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x40490fd0, %eax       # imm = 0x40490FD0
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0x49742400, %eax       # imm = 0x49742400
               	movq	%rax, %xmm15
               	movsd	(%rsp), %xmm0
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x49742400, %eax       # imm = 0x49742400
               	jne	<addr>
               	movabsq	$0x412e848000000000, %rax # imm = 0x412E848000000000
               	movq	%rax, %xmm15
               	movsd	0x8(%rsp), %xmm0
               	mulsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x412e848000000000, %r11 # imm = 0x412E848000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x3dcccccd, %rax       # imm = 0x3DCCCCCD
               	jne	<addr>
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm0
               	callq	<addr>
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	callq	<addr>
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	callq	<addr>
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdi
               	callq	<addr>
               	movl	$0xbe800000, %eax       # imm = 0xBE800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
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
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movl	$0x3f400000, %ecx       # imm = 0x3F400000
               	movabsq	$0x3f50624dd2f1a9fc, %rdx # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%rdx, %xmm2
               	callq	<addr>
               	movsd	%xmm0, (%rsp)
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4006000000000000, %rax # imm = 0x4006000000000000
               	movapd	%xmm0, %xmm15
               	movq	%rax, %xmm0
               	addsd	%xmm15, %xmm0
               	movsd	(%rsp), %xmm14
               	ucomisd	%xmm0, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movabsq	$0x3fd0000000000000, %rcx # imm = 0x3FD0000000000000
               	movsd	0x8(%rsp), %xmm14
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x3fc0000000000000, %rax # imm = 0x3FC0000000000000
               	movapd	%xmm0, %xmm14
               	movsd	0x8(%rsp), %xmm15
               	movq	%rax, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movsd	0x8(%rsp), %xmm15
               	mulsd	%xmm15, %xmm0
               	movabsq	$0x3fec000000000000, %rax # imm = 0x3FEC000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movsd	(%rax), %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	cmpq	$0x0, -0x10(%rbp)
               	jne	<addr>
               	movsd	0x8(%rax), %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movsd	0x10(%rax), %xmm0
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x18(%rax), %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x3fd3333333333333, %r11 # imm = 0x3FD3333333333333
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movss	(%rax), %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	cmpl	$0x0, -0x8(%rbp)
               	jne	<addr>
               	movss	0x4(%rax), %xmm0
               	movl	$0xc0200000, %ecx       # imm = 0xC0200000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movss	0x8(%rax), %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %ecx
               	cmpl	$0x49742400, %ecx       # imm = 0x49742400
               	jne	<addr>
               	movss	0xc(%rax), %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movabsq	$0x3fdc000000000000, %rax # imm = 0x3FDC000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
