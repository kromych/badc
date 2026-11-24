
sroa_object_passed_to_a_call.x64:	file format elf64-x86-64

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

<peek_lo>:
               	movq	0x8(%rdi), %rax
               	retq

<peek_n>:
               	movq	0x8(%rdi), %rax
               	retq

<main>:
               	subq	$0x40, %rsp
               	pushq	%rbx
               	leaq	0x28(%rsp), %rdi
               	movq	$0x4, 0x30(%rsp)
               	callq	<addr>
               	addq	$0x6, %rax
               	leaq	0x5(%rax), %rbx
               	leaq	0x18(%rsp), %rdi
               	movq	$0x2, 0x20(%rsp)
               	callq	<addr>
               	addq	$0x2, %rax
               	addq	$0x2, %rax
               	addq	$0x2, %rax
               	leaq	0x7(%rax), %rcx
               	cmpq	$0xf, %rbx
               	jne	<addr>
               	cmpq	$0xf, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
