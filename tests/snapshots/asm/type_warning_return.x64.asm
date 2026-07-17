
type_warning_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<ret_ptr_as_int>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	%eax, %rax
               	retq

<ret_int_as_ptr>:
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<ret_wrong_struct>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<ret_null>:
               	xorq	%rax, %rax
               	retq

<ret_ok>:
               	movslq	%edi, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
