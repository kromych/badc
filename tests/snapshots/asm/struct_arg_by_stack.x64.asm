
struct_arg_by_stack.x64:	file format elf64-x86-64

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
               	movq	$0x7, <rip> # <addr>
               	movq	$0xb, <rip> # <addr>
               	movq	$0x16, <rip> # <addr>
               	movq	$0x21, <rip> # <addr>
               	movq	$0x2c, <rip> # <addr>
               	movq	$0x5, <rip> # <addr>
               	movq	$0x6, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x16, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x21, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2c, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
