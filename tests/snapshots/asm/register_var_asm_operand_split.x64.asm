
register_var_asm_operand_split.x64:	file format elf64-x86-64

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

<through_rdx>:
               	movq	%rdi, %rdx
               	movq	%rdx, %rax
               	retq

<via_named_rdx>:
               	movq	%rdi, %rdx
               	movq	%rdx, %rax
               	retq

<main>:
               	movl	$0x2a, %edx
               	movq	%rdx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	$-0x7, %rdx
               	movq	%rdx, %rax
               	cmpq	$-0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x7b, %edx
               	movq	%rdx, %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	$-0x5, %rdx
               	movq	%rdx, %rax
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
