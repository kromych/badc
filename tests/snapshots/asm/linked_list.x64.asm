
linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%r12, %r12
               	movq	%r12, %rbx
               	movq	%r12, %r13
               	movslq	%ebx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	movq	%rcx, %r13
               	jmp	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ebx, %rax
               	movq	%rax, (%rcx)
               	movq	%r13, 0x8(%rcx)
               	jmp	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	movq	(%r13), %rax
               	addq	%rax, %r12
               	movq	0x8(%r13), %r13
               	jmp	<addr>
               	movslq	%r12d, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
