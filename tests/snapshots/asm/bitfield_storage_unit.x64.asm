
bitfield_storage_unit.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	0x4(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	0x8(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
