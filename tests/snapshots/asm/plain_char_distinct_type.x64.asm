
plain_char_distinct_type.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movq	$-0x1, %rax
               	movb	%al, (%rcx)
               	movsbq	%al, %rax
               	andq	$0xff, %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0xa, %eax
               	retq
