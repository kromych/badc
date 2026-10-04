
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
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x64, %eax
               	movq	(%rcx), %rdx
               	addq	%rax, %rdx
               	movq	%rdx, (%rcx)
               	decq	%rax
               	testl	%eax, %eax
               	jne	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x64, %edi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x13ba, %rax           # imm = 0x13BA
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
