
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
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	leaq	0x4(%rax), %rdx
               	cmpq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %edx
               	movl	%edx, (%rax)
               	movl	$0xab, %edx
               	movb	%dl, 0x4(%rax)
               	movl	$0xcd, %edx
               	movb	%dl, 0x5(%rax)
               	movq	%rcx, %rdx
               	movzwq	0x4(%rax), %rax
               	andq	$0xff, %rax
               	cmpl	$0xab, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	%rcx, %rax
               	retq
