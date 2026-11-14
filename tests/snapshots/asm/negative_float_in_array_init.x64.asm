
negative_float_in_array_init.x64:	file format elf64-x86-64

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
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm2 # <addr>
               	ucomisd	%xmm2, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	<rip>, %xmm2 # <addr>
               	movsd	<rip>, %xmm3 # <addr>
               	ucomisd	%xmm3, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	addsd	%xmm1, %xmm0
               	addsd	%xmm2, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	comisd	%xmm1, %xmm0
               	ja	<addr>
               	movsd	<rip>, %xmm1 # <addr>
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
