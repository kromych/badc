
struct_byval_param_followed_by_ptr.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	cmpq	$0x2a, %rdx
               	je	<addr>
               	movl	$0x1e, %ebx
               	movslq	%ebx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movslq	-0x18(%rbp), %rdx
               	movslq	(%rax), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	-0x18(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	movl	%edx, (%rcx)
               	xorq	%rbx, %rbx
               	jmp	<addr>
