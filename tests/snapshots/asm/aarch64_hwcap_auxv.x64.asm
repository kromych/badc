
aarch64_hwcap_auxv.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x1a, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
