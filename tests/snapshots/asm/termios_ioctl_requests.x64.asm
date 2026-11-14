
termios_ioctl_requests.x64:	file format elf64-x86-64

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
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x30, %eax
               	leave
               	retq
               	movl	$0x0, -0x10(%rbp)
               	movq	$0x500018, -0x8(%rbp)   # imm = 0x500018
               	movl	-0x18(%rbp), %edi
               	movl	$0x5415, %esi           # imm = 0x5415
               	leaq	-0x10(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x31, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %edi
               	movl	$0x5414, %esi           # imm = 0x5414
               	leaq	-0x8(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %edi
               	callq	<addr>
               	movl	-0x14(%rbp), %edi
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
