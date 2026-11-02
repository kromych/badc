
static_linked_list.x64:	file format elf64-x86-64

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
               	movl	$0x1, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movl	$0x3, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	(%rax), %edx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq
