
vector_arguments_and_results.x64:	file format elf64-x86-64

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

<add>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movups	%xmm0, -0x30(%rbp)
               	movups	%xmm1, -0x20(%rbp)
               	movl	-0x30(%rbp), %eax
               	movl	-0x20(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x10(%rbp)
               	movl	-0x2c(%rbp), %eax
               	movl	-0x1c(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0xc(%rbp)
               	movl	-0x28(%rbp), %eax
               	movl	-0x18(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x24(%rbp), %eax
               	movl	-0x14(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x4(%rbp)
               	movups	-0x10(%rbp), %xmm0
               	leave
               	retq

<fma4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movups	%xmm0, -0x30(%rbp)
               	movups	%xmm1, -0x20(%rbp)
               	movups	%xmm2, -0x10(%rbp)
               	movss	-0x30(%rbp), %xmm0
               	movss	-0x20(%rbp), %xmm1
               	movss	-0x2c(%rbp), %xmm2
               	movss	-0x1c(%rbp), %xmm3
               	movss	-0x28(%rbp), %xmm4
               	movss	-0x18(%rbp), %xmm5
               	movss	-0x24(%rbp), %xmm6
               	movss	-0x14(%rbp), %xmm7
               	movss	-0x10(%rbp), %xmm8
               	vfmadd213ss	%xmm8, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm0) + xmm8
               	movss	%xmm0, -0x20(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	vfmadd231ss	%xmm3, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm3) + xmm0
               	movss	%xmm0, -0x1c(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	vfmadd231ss	%xmm5, %xmm4, %xmm0 # xmm0 = (xmm4 * xmm5) + xmm0
               	movss	%xmm0, -0x18(%rbp)
               	movss	-0x4(%rbp), %xmm0
               	vfmadd231ss	%xmm7, %xmm6, %xmm0 # xmm0 = (xmm6 * xmm7) + xmm0
               	movss	%xmm0, -0x14(%rbp)
               	movups	-0x20(%rbp), %xmm0
               	leave
               	retq

<neg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x8(%rbp)
               	movswq	-0x8(%rbp), %rax
               	negq	%rax
               	movw	%ax, -0x10(%rbp)
               	movswq	-0x6(%rbp), %rax
               	negq	%rax
               	movw	%ax, -0xe(%rbp)
               	movswq	-0x4(%rbp), %rax
               	negq	%rax
               	movw	%ax, -0xc(%rbp)
               	movswq	-0x2(%rbp), %rax
               	negq	%rax
               	movw	%ax, -0xa(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	leave
               	retq

<swap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0x50(%rbp), %rax
               	leaq	0x10(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x10(%rcx), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<spin>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movups	%xmm0, -0x20(%rbp)
               	movups	%xmm1, -0x10(%rbp)
               	xorl	%ebx, %ebx
               	cmpl	%r12d, %ebx
               	jge	<addr>
               	leaq	-0x20(%rbp), %r9
               	leaq	-0x10(%rbp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x20(%rbp)
               	incq	%rbx
               	cmpl	%r12d, %ebx
               	jl	<addr>
               	movups	-0x20(%rbp), %xmm0
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x60(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x40(%rbp)
               	movl	-0x40(%rbp), %eax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movl	-0x3c(%rbp), %eax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x21, %eax
               	jne	<addr>
               	movl	-0x34(%rbp), %eax
               	cmpl	$-0x24, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movq	%rcx, %r10
               	movups	(%r10), %xmm2
               	callq	<addr>
               	movups	%xmm0, -0x40(%rbp)
               	movss	-0x40(%rbp), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x34(%rbp), %xmm0
               	movl	$0x41080000, %eax       # imm = 0x41080000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %r9
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%r9)
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	callq	<addr>
               	movsd	%xmm0, -0x8(%rbp)
               	movzwq	-0x8(%rbp), %rax
               	movzwq	-0x6(%rbp), %rcx
               	movzwq	-0x2(%rbp), %rdx
               	movswq	%ax, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movswq	%cx, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movswq	%dx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x60(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movss	-0x60(%rbp), %xmm0
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x44(%rbp), %xmm0
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x5, %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, -0x40(%rbp)
               	movl	-0x40(%rbp), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	-0x34(%rbp), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
