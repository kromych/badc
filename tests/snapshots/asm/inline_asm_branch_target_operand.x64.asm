
inline_asm_branch_target_operand.x64:	file format elf64-x86-64

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

<helper_1>:
               	movl	$0x1, %eax
               	retq

<helper_2>:
               	movl	$0x2, %eax
               	retq

<helper_4>:
               	movl	$0x4, %eax
               	retq

<helper_8>:
               	movl	$0x8, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	leaq	(%rax), %rbx
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	%rax, %rbx
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	%rax, %rbx
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	addq	%rbx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
