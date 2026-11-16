
block_scope_extern_forward_ref.x64:	file format elf64-x86-64

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
               	incq	%rax
               	addq	$0x4, %rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
