
library_name_defined_by_program.x64:	file format elf64-x86-64

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

<abs>:
               	testl	%edi, %edi
               	jge	<addr>
               	movl	$0x1, %eax
               	subq	%rdi, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	retq
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x6, %eax
               	movl	$0x3, %eax
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x7, %edi
               	callq	*%rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movl	$0x1, %eax
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
