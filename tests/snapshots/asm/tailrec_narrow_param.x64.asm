
tailrec_narrow_param.x64:	file format elf64-x86-64

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

<sum_to>:
               	movsbq	%dil, %rdi
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jle	<addr>
               	leaq	-0x1(%rdi), %rcx
               	addq	%rdi, %rax
               	movq	%rcx, %rdi
               	testl	%edi, %edi
               	jg	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x64, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x13ba, %rax           # imm = 0x13BA
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbp
               	retq
