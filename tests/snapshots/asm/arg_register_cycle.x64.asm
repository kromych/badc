
arg_register_cycle.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<rec>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	decq	%rax
               	movslq	%eax, %rdx
               	xchgq	%rsi, %rdi
               	popq	%rbp
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	cmpq	$-0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	movl	$0x1, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	cmpq	$-0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
