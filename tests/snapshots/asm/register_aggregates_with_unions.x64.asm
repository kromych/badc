
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
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movslq	0xc(%rsp), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	%xmm0, (%rsp)
               	movss	0x8(%rsp), %xmm0
               	cvttss2si	%xmm0, %rax
               	movl	%eax, 0x4(%rsp)
               	movq	(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<bump>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, %rax
               	shrq	$0x10, %rax
               	movw	%ax, 0xa(%rsp)
               	addb	$0x1, (%rsp)
               	movss	0x4(%rsp), %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, 0x4(%rsp)
               	movswq	%si, %rax
               	subq	$0x3, %rax
               	movw	%ax, 0x8(%rsp)
               	movswq	%ax, %rdx
               	movq	(%rsp), %rax
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	$0x18, %rsp
               	retq

<mix>:
               	subq	$0x28, %rsp
               	leaq	0x10(%rsp), %rax
               	movq	%rdi, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	testl	%edx, %edx
               	je	<addr>
               	movss	0x10(%rsp), %xmm0
               	movslq	0x14(%rsp), %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rsp)
               	movq	0x18(%rsp), %rax
               	leaq	(%rax,%rax,2), %rdx
               	movq	%rdx, 0x8(%rsp)
               	movq	(%rsp), %rax
               	addq	$0x28, %rsp
               	retq
               	movl	0x10(%rsp), %eax
               	movl	0x14(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, (%rsp)
               	jmp	<addr>

<through>:
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	movq	%rcx, %rdi
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%rsp), %rdx
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
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	addl	$0x1, (%rdi)
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rdx
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x88, %rsp
               	movq	$-0x5, %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rdx, %rsi
               	movq	%rcx, 0x70(%rsp)
               	movq	%rsi, 0x78(%rsp)
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
               	addq	$0x88, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movq	%rcx, 0x8(%rsp)
               	movq	%rsi, (%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	movq	(%rsp), %rsi
               	movq	%rax, 0x70(%rsp)
               	movq	%rdx, 0x78(%rsp)
               	movq	%rax, %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	cmpq	$0x7, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x88, %rsp
               	retq
               	movq	%rax, %rdi
               	xchgq	%rsi, %rcx
               	xchgq	%rsi, %rdx
               	callq	<addr>
               	movq	%rax, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	movq	%rdx, 0x78(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0x30(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x10, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, 0x70(%rsp)
               	movq	%rdx, 0x78(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	movl	$0x1, %esi
               	movq	%rcx, %rdi
               	movq	%rdx, %rcx
               	movq	%rax, %rdx
               	callq	<addr>
               	movq	%rax, 0x70(%rsp)
               	leaq	0x70(%rsp), %rdi
               	movq	%rdx, 0x78(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x18, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, 0x78(%rsp)
               	leaq	0x38(%rsp), %rcx
               	movq	%rax, (%rcx)
               	movss	0x38(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	0x3c(%rsp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x88, %rsp
               	retq
               	movabsq	$0x3fc0000000000061, %rax # imm = 0x3FC0000000000061
               	movl	$0xa, %ecx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	movl	%edx, 0x78(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movsbq	0x30(%rsp), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movss	0x34(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movswq	0x38(%rsp), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x88, %rsp
               	retq
               	movabsq	$0x23f000000, %rax      # imm = 0x23F000000
               	movl	$0x5, %ecx
               	movl	$0x1, %edx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, 0x70(%rsp)
               	leaq	0x70(%rsp), %rax
               	movq	%rdx, 0x78(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0x30(%rsp), %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	0x34(%rsp), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x88, %rsp
               	retq
               	movabsq	$0x200000028, %rax      # imm = 0x200000028
               	movq	$-0x1, %rcx
               	xorl	%edx, %edx
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, 0x70(%rsp)
               	movq	%rdx, 0x78(%rsp)
               	movl	0x70(%rsp), %eax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	cmpq	$-0x3, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x1, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, 0x30(%rsp)
               	leaq	0x30(%rsp), %rax
               	movq	%rdx, 0x38(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rax, 0x30(%rsp)
               	leaq	0x30(%rsp), %rax
               	movq	%rdx, 0x38(%rsp)
               	leaq	0x40(%rsp), %rcx
               	addq	$0x10, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x3, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, 0x30(%rsp)
               	leaq	0x30(%rsp), %rax
               	movq	%rdx, 0x38(%rsp)
               	leaq	0x40(%rsp), %rcx
               	addq	$0x20, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0x4, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, 0x30(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movq	%rdx, 0x38(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	0x30(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x40(%rax), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	movq	%rax, 0x30(%rsp)
               	leaq	0x30(%rsp), %rcx
               	movq	%rdx, 0x38(%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	0x20(%rsp), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x28(%rsp), %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x88, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x28(%rsp)
               	leaq	0x38(%rsp), %rsi
               	leaq	0x28(%rsp), %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	movzbq	0x28(%rsp), %rax
               	incq	%rax
               	movb	%al, 0x38(%rsp)
               	movl	$0x8, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x88, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x88, %rsp
               	retq
