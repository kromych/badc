
libc_address_in_static_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
