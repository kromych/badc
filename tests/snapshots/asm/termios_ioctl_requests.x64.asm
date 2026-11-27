
termios_ioctl_requests.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x30, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x0, 0x10(%rsp)
               	movq	$0x500018, 0x18(%rsp)   # imm = 0x500018
               	movl	0x8(%rsp), %edi
               	movl	$0x5415, %esi           # imm = 0x5415
               	leaq	0x10(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x31, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x8(%rsp), %edi
               	movl	$0x5414, %esi           # imm = 0x5414
               	leaq	0x18(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x8(%rsp), %edi
               	callq	<addr>
               	movl	0xc(%rsp), %edi
               	callq	<addr>
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
