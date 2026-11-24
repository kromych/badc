
callee_save_pair_fold.x64:	file format elf64-x86-64

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

<sink>:
               	xorl	%eax, %eax
               	testl	%edi, %edi
               	jle	<addr>
               	leaq	-0x1(%rdi), %rcx
               	addq	%rdi, %rax
               	movq	%rcx, %rdi
               	testl	%edi, %edi
               	jg	<addr>
               	incq	%rax
               	retq

<quad>:
               	subq	$0x10, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x10, %rsp
               	retq

<main>:
               	pushq	%rax
               	movl	$0x1, %edi
               	callq	<addr>
               	incq	%rax
               	addq	$0x2, %rax
               	addq	$0x3, %rax
               	addq	$0x4, %rax
               	addq	$0x5, %rax
               	popq	%r11
               	retq
