
add_three_operand_lea.x64:	file format elf64-x86-64

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
               	movl	$0x3, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x4, %eax
               	movq	%rax, -0x10(%rbp)
               	movl	$0x5, %eax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	movq	-0x18(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x77359400, %eax       # imm = 0x77359400
               	movl	%eax, -0x20(%rbp)
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x20(%rbp), %rax
               	movslq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1194d800, %rax      # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, -0x30(%rbp)
               	movq	-0x30(%rbp), %rax
               	incq	%rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
