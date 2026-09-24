
arg_register_cycle.x64:	file format elf64-x86-64

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

<rec>:
               	testl	%edx, %edx
               	je	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edi, %rdi
               	movslq	%edx, %rdx
               	movslq	%esi, %rsi
               	decq	%rdx
               	xchgq	%rsi, %rdi
               	callq	<addr>
               	popq	%rbp
               	retq
               	movslq	%edi, %rax
               	movslq	%esi, %r10
               	subq	%r10, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	movl	$0x1, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	cmpl	$-0x63, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
