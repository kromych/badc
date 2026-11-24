
negative_float_in_array_init.x64:	file format elf64-x86-64

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
               	ucomisd	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	ucomisd	<rip>, %xmm1 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	<rip>, %xmm2 # <addr>
               	ucomisd	<rip>, %xmm2 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	addsd	%xmm1, %xmm0
               	addsd	%xmm2, %xmm0
               	comisd	<rip>, %xmm0 # <addr>
               	ja	<addr>
               	movsd	<rip>, %xmm1 # <addr>
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
