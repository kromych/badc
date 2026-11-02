
wide_char_utf8.x64:	file format elf64-x86-64

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
               	movsbq	<rip>, %rax # <addr>
               	andq	$0xff, %rax
               	xorq	$0xc3, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	andq	$0xff, %rax
               	xorq	$0xa1, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xe1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
