
socket_headers_abi.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x2, %ecx
               	movw	%cx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0x2(%rax)
               	leaq	-0x10(%rbp), %rax
               	movzwq	0x2(%rax), %rax
               	xorq	$0x1234, %rax           # imm = 0x1234
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
