
fcntl_lock_via_cast_fnptr.x64:	file format elf64-x86-64

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
               	subq	$0x88, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x42, %esi
               	movl	$0x1a4, %edx            # imm = 0x1A4
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	movq	$0x0, -0x60(%rbp)
               	movq	$0x0, -0x58(%rbp)
               	movq	$0x0, -0x50(%rbp)
               	movq	$0x0, -0x48(%rbp)
               	movw	$0x1, -0x60(%rbp)
               	movw	$0x0, -0x5e(%rbp)
               	movl	$0x6, %esi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	-0x60(%rbp), %rdx
               	movw	$0x2, -0x60(%rbp)
               	movl	$0x6, %esi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	leaq	-0x60(%rbp), %rdx
               	movw	$0x1, -0x60(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movl	$0x6, %esi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	*%rcx
               	movq	%rax, 0x18(%rsp)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x28(%rsp), %r10
               	testl	%r10d, %r10d
               	jne	<addr>
               	movq	0x20(%rsp), %r10
               	testl	%r10d, %r10d
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	movq	0x18(%rsp), %r10
               	testl	%r10d, %r10d
               	cmovneq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
