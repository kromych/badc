
unnamed_field_typedef_name.x64:	file format elf64-x86-64

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
               	movq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	movl	0x10(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x28, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	0x10(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x18(%rax), %rcx
               	cmpq	$0x6, %rcx
               	jne	<addr>
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x29, %eax
               	retq
               	xorl	%eax, %eax
               	retq
