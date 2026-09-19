
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
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movl	$0xa, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x14, %ecx
               	movb	%cl, 0x5(%rax)
               	movl	$0x1e, %ecx
               	movb	%cl, 0x6(%rax)
               	addq	$0x4, %rax
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movl	$0xab, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0xcd, %ecx
               	movb	%cl, 0x5(%rax)
               	movzwq	0x4(%rax), %rax
               	andq	$0xff, %rax
               	cmpl	$0xab, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
