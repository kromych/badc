
zero_length_array.x64:	file format elf64-x86-64

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
               	movl	$0x3, (%rax)
               	movb	$0xa, 0x4(%rax)
               	movb	$0x14, 0x5(%rax)
               	movb	$0x1e, 0x6(%rax)
               	addq	$0x4, %rax
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, (%rax)
               	movb	$-0x55, 0x4(%rax)
               	movb	$-0x33, 0x5(%rax)
               	movzwq	0x4(%rax), %rax
               	andq	$0xff, %rax
               	cmpl	$0xab, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
