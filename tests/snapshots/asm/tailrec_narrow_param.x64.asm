
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
               	movsbq	%dil, %rax
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	leaq	-0x1(%rax), %rdi
               	addq	%rax, %rcx
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x64, %edi
               	callq	<addr>
               	cmpq	$0x13ba, %rax           # imm = 0x13BA
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
