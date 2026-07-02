
add_sub_negative_imm.x64:	file format elf64-x86-64

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
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movq	%rax, -0x10(%rbp)
               	movslq	-0x8(%rbp), %rax
               	addq	$-0x5, %rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	addq	$-0xa, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	subq	$-0x7, %rax
               	movslq	%eax, %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	addq	$-0x64, %rax
               	cmpq	$0x384, %rax            # imm = 0x384
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	subq	$-0x64, %rax
               	cmpq	$0x44c, %rax            # imm = 0x44C
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	addq	$-0xfff, %rax           # imm = 0xF001
               	movslq	%eax, %rax
               	cmpq	$-0xff5, %rax           # imm = 0xF00B
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	addq	$-0x1000, %rax          # imm = 0xF000
               	movslq	%eax, %rax
               	cmpq	$-0xff6, %rax           # imm = 0xF00A
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	$0x5, %eax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rax
               	decq	%rax
               	movl	%eax, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rax
               	addq	%rax, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
