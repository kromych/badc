
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
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x30, %eax
               	leave
               	retq
               	movl	$0x0, -0x10(%rbp)
               	movw	$0x18, -0x8(%rbp)
               	movw	$0x50, -0x6(%rbp)
               	movw	$0x0, -0x4(%rbp)
               	movw	$0x0, -0x2(%rbp)
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
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x14(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
