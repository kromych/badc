
pp_number_macro_token.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
