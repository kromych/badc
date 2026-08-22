
addr_compare_same_function_inline.x64:	file format elf64-x86-64

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
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
