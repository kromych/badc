
add_sub_negative_imm.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0xa, %eax
               	movl	%eax, -0x18(%rbp)
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movq	%rax, -0x10(%rbp)
               	movslq	-0x18(%rbp), %rax
               	addq	$-0x5, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	-0x18(%rbp), %rax
               	addq	$-0xa, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	-0x18(%rbp), %rax
               	subq	$-0x7, %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	addq	$-0x64, %rax
               	cmpq	$0x384, %rax            # imm = 0x384
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	subq	$-0x64, %rax
               	cmpq	$0x44c, %rax            # imm = 0x44C
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movslq	-0x18(%rbp), %rax
               	addq	$-0xfff, %rax           # imm = 0xF001
               	cmpl	$0xfffff00b, %eax       # imm = 0xFFFFF00B
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movslq	-0x18(%rbp), %rax
               	addq	$-0x1000, %rax          # imm = 0xF000
               	cmpl	$0xfffff00a, %eax       # imm = 0xFFFFF00A
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	$0x5, %ecx
               	movl	%ecx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	-0x8(%rbp), %rcx
               	decq	%rcx
               	movl	%ecx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
