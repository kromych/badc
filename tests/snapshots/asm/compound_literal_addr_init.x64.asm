
compound_literal_addr_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movl	(%rcx), %ecx
               	cmpl	$0x2a, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movl	0x4(%rcx), %ecx
               	cmpl	$0x2b, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
               	movl	0x8(%rax), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
