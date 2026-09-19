
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
               	leaq	<rip>, %rcx
               	leaq	0x8(%rcx), %rax
               	movslq	(%rcx), %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	(%rax), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
