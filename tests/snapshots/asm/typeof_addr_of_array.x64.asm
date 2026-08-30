
typeof_addr_of_array.x64:	file format elf64-x86-64

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
               	leaq	(%rax), %rcx
               	movslq	(%rcx), %rdx
               	cmpl	$0xa, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	0x4(%rax), %rdx
               	cmpl	$0x14, %edx
               	jne	<addr>
               	movslq	0x8(%rax), %rdx
               	cmpl	$0x1e, %edx
               	jne	<addr>
               	movslq	0xc(%rax), %rdx
               	cmpl	$0x28, %edx
               	jne	<addr>
               	movslq	(%rcx), %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x14, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x1e, %ecx
               	jne	<addr>
               	movslq	0xc(%rax), %rax
               	cmpl	$0x28, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	retq
