
math_errhandling_is_floating_exceptions.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x18(%rsp)
               	callq	<addr>
               	movl	$0x0, (%rax)
               	movl	$0x3d, %edi
               	callq	<addr>
               	movsd	0x18(%rsp), %xmm0
               	sqrtsd	%xmm0, %xmm0
               	movsd	%xmm0, 0x8(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	movsd	0x8(%rsp), %xmm0
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	callq	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
