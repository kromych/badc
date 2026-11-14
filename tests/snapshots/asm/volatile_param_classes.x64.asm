
volatile_param_classes.x64:	file format elf64-x86-64

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

<half>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movss	%xmm0, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	mulsd	%xmm1, %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	<rip>, %xmm0
               	movl	$0x1, %eax
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	<rip>, %xmm0
               	movsd	%xmm0, -0x18(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
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
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	leave
               	retq
