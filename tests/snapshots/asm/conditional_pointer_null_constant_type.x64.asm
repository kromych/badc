
conditional_pointer_null_constant_type.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<then_ptr_else_voidnull>:
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x10(%rdi), %rax
               	retq
               	xorq	%rdi, %rdi
               	jmp	<addr>

<then_voidnull_else_ptr>:
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	xorq	%rdi, %rdi
               	movslq	0x10(%rdi), %rax
               	retq
               	jmp	<addr>

<then_ptr_else_intnull>:
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	0x10(%rdi), %rax
               	retq
               	xorq	%rdi, %rdi
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, %esi
               	movl	%esi, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x2a, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x10(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x10(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
