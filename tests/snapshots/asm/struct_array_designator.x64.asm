
struct_array_designator.x64:	file format elf64-x86-64

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
               	movslq	(%rax), %rcx
               	cmpl	$0xa, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0xb, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	0x10(%rax), %rcx
               	cmpl	$0x1e, %ecx
               	jne	<addr>
               	movslq	0x14(%rax), %rax
               	cmpl	$0x1f, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
