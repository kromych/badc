
fma_numeric_kernels.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x98, %rsp
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x68(%rsp)
               	movsd	<rip>, %xmm1
               	movsd	%xmm1, 0x70(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x78(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x80(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x88(%rsp)
               	movsd	0x88(%rsp), %xmm0
               	movl	$0x3, %eax
               	vfmadd213sd	0x68(%rsp,%rax,8), %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + mem
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	vsubsd	<rip>, %xmm0, %xmm1
               	xorps	%xmm0, %xmm0
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	vxorpd	<rip>, %xmm1, %xmm1
               	movsd	<rip>, %xmm2
               	comisd	%xmm1, %xmm2
               	ja	<addr>
               	movl	$0x1, %eax
               	addq	$0x98, %rsp
               	retq
               	movsd	0x88(%rsp), %xmm1
               	movl	$0x3, %eax
               	vfmadd213sd	0x68(%rsp,%rax,8), %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + mem
               	decq	%rax
               	nopl	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	movsd	<rip>, %xmm0
               	subsd	%xmm0, %xmm1
               	xorl	%edx, %edx
               	movq	%rdx, %xmm14
               	comisd	%xmm1, %xmm14
               	jbe	<addr>
               	vxorpd	<rip>, %xmm1, %xmm1
               	movsd	<rip>, %xmm0
               	comisd	%xmm1, %xmm0
               	ja	<addr>
               	movl	$0x2, %eax
               	addq	$0x98, %rsp
               	retq
               	xorl	%eax, %eax
               	imulq	$0x18, %rdx, %rcx
               	leaq	(%rdx,%rdx,2), %rsi
               	jmp	<addr>
               	movsd	%xmm0, (%rdi,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	(%rsp), %rdi
               	addq	%rcx, %rdi
               	leaq	(%rsi,%rax), %r8
               	incq	%r8
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%r8, %xmm0
               	movsd	%xmm0, (%rdi,%rax,8)
               	leaq	0x48(%rsp), %rdi
               	addq	%rcx, %rdi
               	cmpl	%eax, %edx
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%r11, %xmm0
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	xorps	%xmm0, %xmm0
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x3, %edx
               	jl	<addr>
               	xorl	%edx, %edx
               	movsd	0x48(%rsp), %xmm2
               	movsd	0x60(%rsp), %xmm3
               	movsd	0x78(%rsp), %xmm4
               	movsd	0x50(%rsp), %xmm5
               	movsd	0x68(%rsp), %xmm6
               	movsd	0x80(%rsp), %xmm7
               	movsd	0x58(%rsp), %xmm8
               	movsd	0x70(%rsp), %xmm9
               	movsd	0x88(%rsp), %xmm10
               	movq	%rdx, %rax
               	leaq	(%rsp), %rcx
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %xmm0
               	vfmadd231sd	(%rcx), %xmm2, %xmm0 # xmm0 = (xmm2 * mem) + xmm0
               	vfmadd231sd	0x8(%rcx), %xmm3, %xmm0 # xmm0 = (xmm3 * mem) + xmm0
               	vfmadd231sd	0x10(%rcx), %xmm4, %xmm0 # xmm0 = (xmm4 * mem) + xmm0
               	leaq	(%rsp), %rcx
               	addq	%rcx, %rsi
               	vsubsd	(%rsi), %xmm0, %xmm0
               	xorps	%xmm1, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	vxorpd	<rip>, %xmm0, %xmm0
               	movsd	<rip>, %xmm11
               	comisd	%xmm0, %xmm11
               	jbe	<addr>
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rcx
               	movapd	%xmm5, %xmm0
               	vfmadd132sd	(%rcx), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	vfmadd231sd	0x8(%rcx), %xmm6, %xmm0 # xmm0 = (xmm6 * mem) + xmm0
               	vfmadd231sd	0x10(%rcx), %xmm7, %xmm0 # xmm0 = (xmm7 * mem) + xmm0
               	leaq	(%rsp), %rcx
               	addq	%rcx, %rsi
               	vsubsd	0x8(%rsi), %xmm0, %xmm0
               	xorps	%xmm1, %xmm1
               	nopl	(%rax)
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	vxorpd	<rip>, %xmm0, %xmm0
               	movsd	<rip>, %xmm11
               	nopw	(%rax,%rax)
               	comisd	%xmm0, %xmm11
               	jbe	<addr>
               	imulq	$0x18, %rax, %rsi
               	addq	%rsi, %rcx
               	movapd	%xmm8, %xmm0
               	vfmadd132sd	(%rcx), %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
               	vfmadd231sd	0x8(%rcx), %xmm9, %xmm0 # xmm0 = (xmm9 * mem) + xmm0
               	vfmadd231sd	0x10(%rcx), %xmm10, %xmm0 # xmm0 = (xmm10 * mem) + xmm0
               	leaq	(%rsp), %rcx
               	addq	%rsi, %rcx
               	vsubsd	0x10(%rcx), %xmm0, %xmm0
               	xorps	%xmm1, %xmm1
               	nopw	(%rax,%rax)
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	vxorpd	<rip>, %xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	nopw	%cs:(%rax,%rax)
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movsd	0x18(%rsp), %xmm0
               	movsd	0x10(%rsp), %xmm1
               	movq	%rax, %xmm15
               	vfmadd213sd	%xmm15, %xmm0, %xmm1 # xmm1 = (xmm0 * xmm1) + xmm15
               	movsd	0x20(%rsp), %xmm2
               	movsd	0x28(%rsp), %xmm0
               	vfmadd231sd	%xmm0, %xmm2, %xmm1 # xmm1 = (xmm2 * xmm0) + xmm1
               	movsd	0x40(%rsp), %xmm2
               	vfmadd213sd	%xmm1, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm0) + xmm1
               	vsubsd	<rip>, %xmm0, %xmm0
               	movq	%rax, %xmm14
               	comisd	%xmm0, %xmm14
               	jbe	<addr>
               	vxorpd	<rip>, %xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x4, %eax
               	addq	$0x98, %rsp
               	retq
               	addq	$0x98, %rsp
               	retq
               	movl	$0x3, %eax
               	addq	$0x98, %rsp
               	retq
