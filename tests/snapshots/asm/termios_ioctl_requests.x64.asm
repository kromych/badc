
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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x30, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x18, %edx
               	movw	%dx, (%rax)
               	movl	$0x50, %edx
               	movw	%dx, 0x2(%rax)
               	movw	%cx, 0x4(%rax)
               	movw	%cx, 0x6(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rdi
               	movl	$0x5415, %esi           # imm = 0x5415
               	leaq	-0x10(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x31, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rdi
               	movl	$0x5414, %esi           # imm = 0x5414
               	leaq	-0x8(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rbx, %rbx
               	movslq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
