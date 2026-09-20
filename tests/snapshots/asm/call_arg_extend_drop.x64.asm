
call_arg_extend_drop.x64:	file format elf64-x86-64

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
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x2(%rbx), %rdi
               	callq	<addr>
               	addq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpl	$0x1a6d, %eax           # imm = 0x1A6D
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	$-0x7, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	%eax, %rax
               	leaq	(%rax,%rax,2), %rax
               	cmpq	$-0x15, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
