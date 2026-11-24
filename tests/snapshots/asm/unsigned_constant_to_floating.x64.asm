
unsigned_constant_to_floating.x64:	file format elf64-x86-64

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
               	movss	<rip>, %xmm1 # <addr>
               	ucomiss	<rip>, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	ucomisd	<rip>, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
