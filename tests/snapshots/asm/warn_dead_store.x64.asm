
warn_dead_store.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<dead_initializer>:
               	movl	$0x1, %eax
               	retq

<self_referencing_rhs>:
               	movl	$0x5, %eax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<store_consumed_after_branch_is_silenced>:
               	movslq	%edi, %rdi
               	movl	$0x1, %ecx
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x2, %ecx
               	movslq	%ecx, %rax
               	retq
               	jmp	<addr>

<address_escapes_silences>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	incq	%rcx
               	leaq	(%rax,%rcx), %rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
