
extern_incomplete_struct_completion.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	<rip>, %edx # <addr>
               	cmpl	$0xb, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
