
c99_comparison_macros_raise_no_invalid.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movabsq	$0x7ff8000000000000, %rax # imm = 0x7FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x38(%rbp)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x30(%rbp)
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x28(%rbp)
               	movabsq	$0x7ff0000000000000, %rax # imm = 0x7FF0000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x20(%rbp)
               	movl	$0x3f800000, -0x18(%rbp) # imm = 0x3F800000
               	movl	$0x4b800000, -0x10(%rbp) # imm = 0x4B800000
               	movl	$0x1000001, -0x8(%rbp)  # imm = 0x1000001
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	ja	<addr>
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jae	<addr>
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jae	<addr>
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jne	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	ja	<addr>
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jne	<addr>
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movsd	-0x28(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jbe	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jb	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x28(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movsd	-0x28(%rbp), %xmm0
               	movsd	-0x28(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x28(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	je	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jne	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x28(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jnp	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movsd	-0x30(%rbp), %xmm0
               	movq	%rax, %xmm14
               	ucomisd	%xmm0, %xmm14
               	jbe	<addr>
               	movss	-0x18(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	-0x28(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movss	-0x18(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	-0x10(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jae	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	movl	$0x3, <rip> # <addr>
               	movl	$0x4, <rip> # <addr>
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jbe	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x20(%rbp), %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	-0x20(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x9, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	leave
               	retq
