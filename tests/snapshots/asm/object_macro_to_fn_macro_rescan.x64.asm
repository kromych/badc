
object_macro_to_fn_macro_rescan.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<__c5_assert_fail>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edx, %rdx
               	leaq	<rip>, %rax
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	ud2
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x7, %ebx
               	cmpq	$0x7, %rbx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x13, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x14, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
