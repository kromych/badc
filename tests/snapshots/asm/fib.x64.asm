
fib.x64:	file format elf64-x86-64

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

<fib>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	xorl	%r12d, %r12d
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	subq	$0x2, %rbx
               	addq	%rax, %r12
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	leaq	(%r12,%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpq	$0x1a6d, %rax           # imm = 0x1A6D
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
