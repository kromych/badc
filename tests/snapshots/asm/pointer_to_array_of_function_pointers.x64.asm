
pointer_to_array_of_function_pointers.x64:	file format elf64-x86-64

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
               	vdivsd	<rip>, %xmm0, %xmm0
               	retq

<twice>:
               	vmulsd	<rip>, %xmm0, %xmm0
               	retq

<main>:
               	subq	$0x18, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rax
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	0x10(%rax), %rax
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	%xmm0, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movsd	<rip>, %xmm0
               	callq	*%rax
               	movsd	0x8(%rsp), %xmm14
               	vaddsd	%xmm0, %xmm14, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	addq	$0x28, %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x28, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
