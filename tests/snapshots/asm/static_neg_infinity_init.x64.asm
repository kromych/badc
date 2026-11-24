
static_neg_infinity_init.x64:	file format elf64-x86-64

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
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	vaddsd	%xmm0, %xmm0, %xmm2
               	ucomisd	%xmm0, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	vaddsd	%xmm0, %xmm0, %xmm2
               	ucomisd	%xmm0, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	vaddsd	%xmm0, %xmm0, %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	vxorpd	<rip>, %xmm0, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
