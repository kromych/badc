
math_compare_macros.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jb	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jb	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jnp	<addr>
               	movq	%rdx, %xmm14
               	ucomisd	%xmm0, %xmm14
               	jnp	<addr>
               	retq
               	movl	$0x6, %eax
               	retq
