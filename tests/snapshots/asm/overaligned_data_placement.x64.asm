
overaligned_data_placement.x64:	file format elf64-x86-64

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
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0x7f, %al
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$-0x1, %al
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0x7f, %al
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$-0x1, %al
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0x7f, %al
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$-0x1, %al
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movl	$0xb, %eax
               	movl	%eax, <rip> # <addr>
               	movl	$0x16, <rip> # <addr>
               	movl	$0x21, <rip> # <addr>
               	movl	$0x2c, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x16, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x21, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2c, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x7, %ecx
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
