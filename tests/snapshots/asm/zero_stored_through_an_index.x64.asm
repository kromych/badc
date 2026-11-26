
zero_stored_through_an_index.x64:	file format elf64-x86-64

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

<index_double>:
               	movq	$0x0, (%rdi,%rsi,8)
               	retq

<index_float>:
               	movl	$0x0, (%rdi,%rsi,4)
               	retq

<index_long>:
               	movq	$0x0, (%rdi,%rsi,8)
               	retq

<index_int>:
               	movl	$0x0, (%rdi,%rsi,4)
               	retq

<through_double>:
               	movq	$0x0, (%rdi)
               	retq

<through_float>:
               	movl	$0x0, (%rdi)
               	retq

<fields>:
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movq	$0x0, 0x10(%rdi)
               	movl	$0x0, 0x18(%rdi)
               	movw	$0x0, 0x1c(%rdi)
               	movb	$0x0, 0x1e(%rdi)
               	retq

<frame_array>:
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rax
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, (%rsp)
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, 0x8(%rsp)
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, 0x10(%rsp)
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rcx, 0x18(%rsp)
               	shlq	$0x3, %rdi
               	addq	%rdi, %rax
               	movq	$0x0, (%rax)
               	movsd	(%rax), %xmm0
               	addq	$0x28, %rsp
               	retq

<spread>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	retq

<main>:
               	subq	$0x88, %rsp
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x60(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movabsq	$0x4045000000000000, %rdx # imm = 0x4045000000000000
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	movsd	0x30(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x42280000, %edx       # imm = 0x42280000
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movss	0x4(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x4d, %edx
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x0, 0x58(%rsp)
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x4d, %edx
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x0, 0x10(%rsp)
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x88, %rsp
               	retq
               	movabsq	$0x4045000000000000, %rdi # imm = 0x4045000000000000
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	xorps	%xmm0, %xmm0
               	movsd	0x20(%rsp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x42280000, %edi       # imm = 0x42280000
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	movss	(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x88, %rsp
               	retq
               	movabsq	$0x4045000000000000, %rdi # imm = 0x4045000000000000
               	movl	$0x2, %esi
               	movl	$0x4d, %edx
               	callq	<addr>
               	leaq	0x60(%rsp), %rdi
               	callq	<addr>
               	movsd	0x60(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	0x68(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	cmpq	$0x0, 0x70(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x78(%rsp)
               	jne	<addr>
               	cmpw	$0x0, 0x7c(%rsp)
               	jne	<addr>
               	cmpb	$0x0, 0x7e(%rsp)
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x88, %rsp
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x4045000000000000, %rsi # imm = 0x4045000000000000
               	movl	$0x3, %edx
               	callq	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x88, %rsp
               	retq
               	addq	$0x88, %rsp
               	retq
