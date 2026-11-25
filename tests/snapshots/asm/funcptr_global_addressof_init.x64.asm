
funcptr_global_addressof_init.x64:	file format elf64-x86-64

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

<inc>:
               	leaq	0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	movl	$0x29, %edi
               	callq	*%rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x14, %edi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
