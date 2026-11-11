
struct_member_copy_from_global.x64:	file format elf64-x86-64

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

<new_client>:
               	movl	<rip>, %eax # <addr>
               	movl	$0x9, <rip> # <addr>
               	movl	$0x1, %ecx
               	movq	$-0x64, %rdx
               	cmpl	$-0x1, %eax
               	movq	%rdx, %rax
               	cmovgeq	%rcx, %rax
               	incq	%rax
               	incq	%rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
