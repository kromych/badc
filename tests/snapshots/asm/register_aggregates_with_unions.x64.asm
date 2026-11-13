
register_aggregates_with_unions.x64:	file format elf64-x86-64

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

<make_int>:
               	movq	%rsi, %rdx
               	movl	%edi, %eax
               	movabsq	$0x5a00000000, %r11     # imm = 0x5A00000000
               	orq	%r11, %rax
               	retq

<make_double>:
               	movl	$0x7, %edx
               	movq	%xmm0, %rax
               	retq

<step>:
               	cmpq	$0x7, %rsi
               	jne	<addr>
               	movq	%rdi, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movslq	%edx, %rdx
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdx, %xmm1
               	movq	%rax, %xmm15
               	vfmadd132sd	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm0 * xmm15) + xmm1
               	movq	%xmm0, %rax
               	movq	%rsi, %rdx
               	xorq	%rcx, %rdx
               	retq
               	movslq	%edx, %rax
               	addq	%rdi, %rax
               	jmp	<addr>

<swap_fi>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movslq	-0x4(%rbp), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	cvttss2si	%xmm0, %rax
               	movl	%eax, -0xc(%rbp)
               	movq	-0x10(%rbp), %rax
               	leave
               	retq

<bump>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movw	%si, -0x8(%rbp)
               	movq	%rsi, %rax
               	shrq	$0x10, %rax
               	movw	%ax, -0x6(%rbp)
               	movsbq	-0x10(%rbp), %rax
               	incq	%rax
               	movb	%al, -0x10(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	movswq	%si, %rax
               	subq	$0x3, %rax
               	movw	%ax, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	movzwq	-0x8(%rbp), %rdx
               	leave
               	retq

<mix>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	testl	%edx, %edx
               	je	<addr>
               	movss	-0x10(%rbp), %xmm0
               	movslq	-0xc(%rbp), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movq	-0x8(%rbp), %rax
               	leaq	(%rax,%rax,2), %rdx
               	movq	%rdx, -0x18(%rbp)
               	movq	-0x20(%rbp), %rax
               	leave
               	retq
               	movl	-0x10(%rbp), %eax
               	movl	-0xc(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>

<through>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	-0x10(%rbp), %rcx
               	addq	$-0x10, %rdi
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	movsd	-0x10(%rbp), %xmm0
               	cvttsd2si	%xmm0, %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, <rip> # <addr>
               	jmp	<addr>
               	movl	<rip>, %ecx # <addr>
               	movl	-0x10(%rbp), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, <rip> # <addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	(%rdi), %eax
               	incq	%rax
               	movl	%eax, (%rdi)
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rdx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	$-0x5, %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x60(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	-0x60(%rbp), %eax
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	movzbq	-0x5c(%rbp), %rax
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movabsq	$0x3ff4000000000000, %rax # imm = 0x3FF4000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movsd	-0x50(%rbp), %xmm0
               	movabsq	$0x3ff4000000000000, %rax # imm = 0x3FF4000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	-0x50(%rbp), %xmm0
               	movabsq	$-0x3ffc000000000000, %rax # imm = 0xC004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, -0x50(%rbp)
               	movq	$0x1, -0x48(%rbp)
               	movl	$0x10, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rdi
               	movq	%rax, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rdx, -0x8(%rbp)
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x18, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x48(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movss	-0x48(%rbp), %xmm0
               	movl	$0x41100000, %eax       # imm = 0x41100000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	-0x44(%rbp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movl	0x8(%rdi), %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movl	%edx, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	(%rdi), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rdi), %r10d
               	movl	%r10d, 0x8(%rax)
               	movsbq	-0x50(%rbp), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movss	-0x4c(%rbp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movswq	-0x48(%rbp), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x1, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x50(%rbp), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	-0x4c(%rbp), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	xorl	%edx, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	cmpq	$-0x3, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, -0x48(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, -0x48(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x10, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x3, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	%rdx, -0x48(%rbp)
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x20, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x4, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movq	%rdx, -0x48(%rbp)
               	leaq	-0x40(%rbp), %rax
               	leaq	0x30(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x40(%rax), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movq	%rdx, -0x48(%rbp)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	-0x60(%rbp), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	-0x58(%rbp), %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp)
               	leaq	-0x48(%rbp), %rsi
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	movzbq	-0x58(%rbp), %rax
               	incq	%rax
               	movb	%al, -0x48(%rbp)
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
