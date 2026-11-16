
tailrec_void_accumulate.x64:	file format elf64-x86-64

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

<accumulate>:
               	movl	$0x64, %eax
               	movq	<rip>, %rcx # <addr>
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	decq	%rax
               	testl	%eax, %eax
               	jne	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x64, %edi
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x13ba, %rdx           # imm = 0x13BA
               	cmovneq	%rcx, %rax
               	popq	%rbp
               	retq
