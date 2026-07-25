
enum_unsigned_value_cmp.x64:	file format elf64-x86-64

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
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	%eax, -0x8(%rbp)
               	movabsq	$-0x1, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x8(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	xorq	%r11, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	xorq	%r11, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rax
               	movl	%eax, %eax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	jae	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rax
               	movl	%eax, %eax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	movl	%eax, %eax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	setae	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	movl	%eax, %eax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	setbe	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	addq	%r11, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movslq	-0x8(%rbp), %rax
               	movl	%eax, %eax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
