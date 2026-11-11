
static_over_alignment.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x3, %eax
               	movl	%eax, <rip> # <addr>
               	testb	$0x3f, %cl
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x9, <rip> # <addr>
               	testl	$0xfff, %ecx            # imm = 0xFFF
               	je	<addr>
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0x7f, %al
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
