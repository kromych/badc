
float_arith_in_static_init.x64:	file format elf64-x86-64

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
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	comisd	<rip>, %xmm0 # <addr>
               	jbe	<addr>
               	movl	$0x4, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	ucomisd	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
