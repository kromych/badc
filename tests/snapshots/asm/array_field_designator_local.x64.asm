
array_field_designator_local.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	andq	$0xff, %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	testb	$-0x1, %cl
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	testb	$-0x1, %cl
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	sarq	$0x8, %rax
               	testb	$-0x1, %al
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	andq	$0xff, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	andq	$0xff, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
