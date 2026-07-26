
aggregate_init_statement_expression_element.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<check_nested_aggregate>:
               	movslq	%edi, %rdi
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rdx
               	leaq	0x3(%rdi), %rax
               	movslq	%eax, %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	%eax, %eax
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%edi, %ecx
               	movl	%edi, %edx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movl	%eax, %ecx
               	leaq	(%rdi,%rdi,2), %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	movl	%eax, %eax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1000, %ecx           # imm = 0x1000
               	movl	$0x1000, %eax           # imm = 0x1000
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movl	$0x9, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
