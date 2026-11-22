
call_arg_extend_drop.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	cmpl	$0x2, %edi
               	jl	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	xorl	%r14d, %r14d
               	leaq	-0x1(%r13), %rbx
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
               	subq	$0x2, %r13
               	addq	%rax, %r14
               	cmpl	$0x2, %r13d
               	jge	<addr>
               	leaq	(%r14,%r13), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movslq	%edi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpl	$0x1a6d, %eax           # imm = 0x1A6D
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
