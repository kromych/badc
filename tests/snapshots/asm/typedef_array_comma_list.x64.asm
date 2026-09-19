
typedef_array_comma_list.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	$0x0, 0x78(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	$0x2a, 0x138(%rcx)
               	leaq	<rip>, %rax
               	movq	$-0x1, 0x1f8(%rax)
               	movq	0x138(%rcx), %rdx
               	cmpq	$0x2a, %rdx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	0x1f8(%rax), %rdx
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	cmpq	$0x0, (%rcx)
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorl	%eax, %eax
               	retq
