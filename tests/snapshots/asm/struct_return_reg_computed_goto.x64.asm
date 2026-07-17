
struct_return_reg_computed_goto.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<simple>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rax         # <addr>
               	jmpq	*%rax
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<ternary>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	%edi, 0x10(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	%edi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x28(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	jmpq	*%rax
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	addq	$0x40, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movl	$0x2, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x38(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	movslq	%eax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
