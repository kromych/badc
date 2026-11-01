
runtime_struct_array_member_init.x64:	file format elf64-x86-64

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
               	leaq	0x8(%rax), %rcx
               	movl	(%rax), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	(%rcx), %eax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
