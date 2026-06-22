
flexible_array_member.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	movq	%r13, (%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	movl	$0x2, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x1, %edx
               	movb	%dl, 0x4(%rax)
               	movl	$0x9, %edx
               	movb	%dl, 0x7(%rax)
               	movslq	%ecx, %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x4(%rax), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x7(%rax), %rcx
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x4, %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
