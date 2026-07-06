
mem2reg_value_across_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<cb>:
               	leaq	0x7(%rdi), %rax
               	retq

<noise>:
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	incq	%rax
               	retq

<g>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %rbx
               	leaq	-<rip>, %r12       # <addr>
               	xorq	%r13, %r13
               	movq	%r13, %rax
               	cmpq	%rbx, %r13
               	jge	<addr>
               	movq	%r13, %rcx
               	shlq	$0x1, %rcx
               	incq	%rcx
               	leaq	(%rax,%rcx), %r14
               	movq	%r12, %rax
               	movq	%r13, %rdi
               	callq	*%rax
               	addq	%r14, %rax
               	incq	%r13
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	callq	<addr>
               	andq	$0x7f, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
