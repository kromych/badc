
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
               	xorq	%r13, %r13
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorq	%rax, %rax
               	movq	%rax, (%rbx)
               	movq	%r13, 0x8(%rbx)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movq	%rbx, 0x8(%r12)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x2, %eax
               	movq	%rax, (%rbx)
               	movq	%r12, 0x8(%rbx)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x3, %eax
               	movq	%rax, (%r12)
               	movq	%rbx, 0x8(%r12)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x4, %eax
               	movq	%rax, (%rcx)
               	movq	%r12, 0x8(%rcx)
               	jmp	<addr>
               	movq	(%rcx), %rax
               	addq	%rax, %r13
               	movq	0x8(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	%r13d, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
