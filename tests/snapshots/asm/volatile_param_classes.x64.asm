
volatile_param_classes.x64:	file format elf64-x86-64

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

<half>:
               	subq	$0x18, %rsp
               	movss	%xmm0, 0x8(%rsp)
               	movss	0x8(%rsp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	vmulsd	<rip>, %xmm0, %xmm0
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x48, %rsp
               	leaq	0x30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	<rip>, %xmm0
               	movl	$0x1, %ecx
               	movsd	%xmm0, 0x8(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movsd	%xmm0, (%rsp)
               	movsd	(%rsp), %xmm0
               	movsd	0x8(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x30(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x18(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movsd	%xmm0, 0x10(%rsp)
               	movsd	0x10(%rsp), %xmm0
               	movsd	0x18(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x30(%rsp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, 0x28(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movsd	%xmm0, 0x20(%rsp)
               	movsd	0x20(%rsp), %xmm0
               	movsd	0x28(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x30(%rsp)
               	movsd	0x30(%rsp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
               	movq	%rcx, %rax
               	addq	$0x48, %rsp
               	retq
