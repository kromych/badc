
empty_struct_member_align.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	movq	$0x1, (%rax)
               	movq	$0x2, 0x40(%rax)
               	leaq	0x40(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x40, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
