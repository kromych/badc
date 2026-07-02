
setjmp_longjmp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<trigger>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movl	%esi, 0x200(%rdi)
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x240, %rsp            # imm = 0x240
               	movq	%rbx, (%rsp)
               	jmp	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x210(%rbp)
               	leaq	-0x208(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x210(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x210(%rbp)
               	leaq	-0x208(%rbp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	movslq	%ebx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	movslq	-0x210(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %rax
               	movslq	0x200(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
