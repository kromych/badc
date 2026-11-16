
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movss	<rip>, %xmm0
               	vcvtss2sd	%xmm0, %xmm0, %xmm1
               	movsd	%xmm1, -0x20(%rbp)
               	movsd	<rip>, %xmm1
               	movsd	%xmm1, -0x18(%rbp)
               	movss	%xmm0, -0x10(%rbp)
               	movl	$0x3f800000, -0x8(%rbp) # imm = 0x3F800000
               	movl	$0x3d, %edi
               	callq	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x3d, %edi
               	callq	<addr>
               	movsd	-0x18(%rbp), %xmm0
               	movsd	-0x20(%rbp), %xmm1
               	comisd	%xmm1, %xmm0
               	jae	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x3d, %edi
               	callq	<addr>
               	movss	-0x10(%rbp), %xmm0
               	movss	-0x8(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	ja	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x3d, %edi
               	callq	<addr>
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x3d, %edi
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
