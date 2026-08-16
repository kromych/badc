
aligned_member.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	leaq	-0xd0(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	-0xd0(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x10, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rax
               	addq	$0x14, %rax
               	leaq	-0xd0(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	-0xb0(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x10, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x90(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	-0x90(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x10, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rax
               	movabsq	$0x1122334455667788, %rcx # imm = 0x1122334455667788
               	movq	%rcx, 0x10(%rax)
               	leaq	-0xb0(%rbp), %rax
               	movabsq	$-0x3, %rcx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0xb0(%rbp), %rax
               	movq	0x10(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$-0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
