
struct_tm_tm_zone_offset.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x2e0, %esi            # imm = 0x2E0
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movq	0x30(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movq	0x30(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x40, %rax
               	jle	<addr>
               	movl	$0x6, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
