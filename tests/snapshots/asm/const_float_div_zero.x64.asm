
const_float_div_zero.x64:	file format elf64-x86-64

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
               	movabsq	$0x7fe1ccf385ebc8a0, %rax # imm = 0x7FE1CCF385EBC8A0
               	movq	%rax, %xmm15
               	comisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$-0x1e330c7a143760, %rax # imm = 0xFFE1CCF385EBC8A0
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
