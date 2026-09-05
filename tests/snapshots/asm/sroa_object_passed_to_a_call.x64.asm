
sroa_object_passed_to_a_call.x64:	file format elf64-x86-64

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

<peek_lo>:
               	movq	0x8(%rdi), %rax
               	retq

<peek_n>:
               	movq	0x8(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x4, %eax
               	movq	%rax, 0x8(%rdi)
               	callq	<addr>
               	addq	$0x6, %rax
               	leaq	0x5(%rax), %rbx
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x2, %eax
               	movq	%rax, 0x8(%rdi)
               	callq	<addr>
               	addq	$0x2, %rax
               	addq	$0x2, %rax
               	addq	$0x2, %rax
               	leaq	0x7(%rax), %rcx
               	cmpq	$0xf, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0xf, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
