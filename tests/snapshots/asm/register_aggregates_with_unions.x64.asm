
register_aggregates_with_unions.x64:	file format elf64-x86-64

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
               	movslq	%edx, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rax, %xmm1
               	vfmadd132sd	<rip>, %xmm1, %xmm0 # xmm0 = (xmm0 * mem) + xmm1
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
               	addb	$0x1, -0x10(%rbp)
               	movss	-0xc(%rbp), %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	movswq	%si, %rax
               	subq	$0x3, %rax
               	movw	%ax, -0x8(%rbp)
               	movswq	%ax, %rdx
               	movq	-0x10(%rbp), %rax
               	andq	$0xffff, %rdx           # imm = 0xFFFF
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
               	movq	%rcx, %rdi
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x10(%rdi), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	-0x8(%rdi), %rdx
               	cmpq	$0x7, %rdx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	movsd	-0x10(%rdi), %xmm0
               	cvttsd2si	%xmm0, %rdi
               	addq	%rdi, %rdx
               	movl	%edx, <rip> # <addr>
               	jmp	<addr>
               	movl	<rip>, %edx # <addr>
               	movl	-0x10(%rdi), %edi
               	addq	%rdi, %rdx
               	movl	%edx, <rip> # <addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	addl	$0x1, (%rdi)
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rdx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	$-0x5, %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rdx, %rsi
               	movq	%rcx, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	cmpl	$-0x5, %ecx
               	jne	<addr>
               	movq	%rcx, %rax
               	shrq	$0x20, %rax
               	andq	$0xff, %rax
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	cmpq	$0x3, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0
               	movq	%rcx, 0x8(%rsp)
               	movq	%rsi, (%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	movq	(%rsp), %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	%rax, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	xchgq	%rsi, %rdx
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	-0x50(%rbp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x10, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	movl	$0x1, %esi
               	movq	%rcx, %rdi
               	movq	%rdx, %rcx
               	movq	%rax, %rdx
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
               	leaq	-0x48(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movss	-0x48(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	-0x44(%rbp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movabsq	$0x3fc0000000000061, %rax # imm = 0x3FC0000000000061
               	movl	$0xa, %ecx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	%edx, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movsbq	-0x50(%rbp), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movss	-0x4c(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movswq	-0x48(%rbp), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movabsq	$0x23f000000, %rax      # imm = 0x23F000000
               	movl	$0x5, %ecx
               	movl	$0x1, %edx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	-0x50(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
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
               	movabsq	$0x200000028, %rax      # imm = 0x200000028
               	movq	$-0x1, %rcx
               	xorl	%edx, %edx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
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
               	movsd	<rip>, %xmm0
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
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x58(%rbp)
               	leaq	-0x48(%rbp), %rsi
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	movzbq	-0x58(%rbp), %rax
               	incq	%rax
               	movb	%al, -0x48(%rbp)
               	movl	$0x8, %edx
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
