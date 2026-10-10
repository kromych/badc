
posix_os_headers.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	leaq	-0x50(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x50(%rbp), %rax
               	cmpq	$0x6553f100, %rax       # imm = 0x6553F100
               	jge	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	-0x64(%rbp), %edi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdi
               	movl	-0x68(%rbp), %ecx
               	movl	%ecx, -0x60(%rbp)
               	movl	$0x1, %esi
               	movw	%si, -0x5c(%rbp)
               	movw	$0x0, -0x5a(%rbp)
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movswq	-0x5a(%rbp), %rax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	-0x68(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x64(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	-0x40(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%edi, %edi
               	movl	$0x5413, %esi           # imm = 0x5413
               	leaq	-0x58(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
