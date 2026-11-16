
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
               	movsd	<rip>, %xmm2
               	ucomisd	%xmm2, %xmm0
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jb	<addr>
               	movl	$0x2, %eax
               	retq
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x3, %eax
               	retq
               	ucomisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x4, %eax
               	retq
               	ucomisd	%xmm1, %xmm0
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	ucomisd	%xmm2, %xmm0
               	jnp	<addr>
               	ucomisd	%xmm0, %xmm2
               	jnp	<addr>
               	retq
               	movl	$0x6, %eax
               	retq
