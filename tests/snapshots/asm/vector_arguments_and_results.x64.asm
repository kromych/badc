
vector_arguments_and_results.x64:	file format elf64-x86-64

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

<add>:
               	vpaddd	%xmm1, %xmm0, %xmm0
               	retq

<fma4>:
               	vmulps	%xmm1, %xmm0, %xmm0
               	vaddps	%xmm2, %xmm0, %xmm0
               	retq

<neg>:
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	vpsubw	%xmm0, %xmm14, %xmm0
               	retq

<swap>:
               	subq	$0x58, %rsp
               	movq	%rdi, 0x40(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x68(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x70(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x10(%rax), %rdx
               	leaq	0x20(%rsp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x10(%rcx), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	addq	$0x58, %rsp
               	retq

<spin>:
               	subq	$0x28, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movups	%xmm0, 0x10(%rsp)
               	movups	%xmm1, 0x20(%rsp)
               	xorl	%ebx, %ebx
               	cmpl	%r12d, %ebx
               	jge	<addr>
               	leaq	0x10(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movups	%xmm0, 0x10(%rsp)
               	incq	%rbx
               	cmpl	%r12d, %ebx
               	jl	<addr>
               	movups	0x10(%rsp), %xmm0
               	popq	%rbx
               	popq	%r12
               	addq	$0x28, %rsp
               	retq

<main>:
               	subq	$0x68, %rsp
               	subq	$0x20, %rsp
               	leaq	0x20(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x40(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x16, %rax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$-0x24, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	addq	$0x68, %rsp
               	retq
               	leaq	0x60(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rcx
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
               	vpermilps	$0x0, %xmm0, %xmm1 # xmm1 = xmm0[0,0,0,0]
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	jne	<addr>
               	vpermilps	$0x3, %xmm0, %xmm0 # xmm0 = xmm0[3,0,0,0]
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	addq	$0x68, %rsp
               	retq
               	leaq	0x78(%rsp), %r9
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%r9)
               	movq	%r9, %r10
               	movsd	(%r10), %xmm0
               	callq	<addr>
               	vpextrw	$0x0, %xmm0, %eax
               	movswq	%ax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	vpextrw	$0x1, %xmm0, %eax
               	movswq	%ax, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	vpextrw	$0x3, %xmm0, %eax
               	movswq	%ax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	addq	$0x68, %rsp
               	retq
               	leaq	0x20(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	leaq	0x40(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movss	0x20(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x3c(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	addq	$0x68, %rsp
               	retq
               	leaq	0x20(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x40(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	movl	$0x5, %edi
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	addq	$0x68, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x20, %rsp
               	addq	$0x68, %rsp
               	retq
