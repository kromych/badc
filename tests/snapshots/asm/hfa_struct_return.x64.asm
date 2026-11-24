
hfa_struct_return.x64:	file format elf64-x86-64

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
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1
               	addss	%xmm1, %xmm0
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
