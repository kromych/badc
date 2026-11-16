
unsigned_constant_to_floating.x64:	file format elf64-x86-64

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
               	movss	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm0
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	<rip>, %xmm2 # <addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	<rip>, %xmm2 # <addr>
               	movsd	<rip>, %xmm3
               	ucomisd	%xmm3, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movss	<rip>, %xmm2 # <addr>
               	ucomiss	%xmm0, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
