
float_relational_raises_invalid.x64:	file format elf64-x86-64

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

<invalid_after>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x7fc00000, %eax       # imm = 0x7FC00000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movq	%rax, %xmm14
               	movss	%xmm14, -0x10(%rbp)
               	movl	$0x3f800000, -0x8(%rbp) # imm = 0x3F800000
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%dil
               	movzbq	%dil, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x18(%rbp), %xmm0
               	movsd	-0x20(%rbp), %xmm1
               	comisd	%xmm1, %xmm0
               	setae	%dil
               	movzbq	%dil, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movss	-0x10(%rbp), %xmm0
               	movss	-0x8(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%dil
               	movzbq	%dil, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x3d, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	ja	<addr>
               	movsd	-0x18(%rbp), %xmm0
               	movsd	-0x20(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	jae	<addr>
               	movss	-0x10(%rbp), %xmm0
               	movss	-0x8(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jae	<addr>
               	movss	-0x10(%rbp), %xmm0
               	movss	-0x8(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
