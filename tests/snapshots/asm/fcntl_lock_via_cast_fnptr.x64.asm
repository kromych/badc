
fcntl_lock_via_cast_fnptr.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	pushq	%rbx
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rdx
               	leaq	0x50(%rsp), %rdi
               	movl	$0x40, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x50(%rsp), %rdi
               	movl	$0x42, %esi
               	movl	$0x1a4, %edx            # imm = 0x1A4
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x90, %rsp
               	retq
               	movq	$0x0, 0x38(%rsp)
               	movq	$0x0, 0x40(%rsp)
               	movq	$0x0, 0x48(%rsp)
               	movq	$0x1, 0x30(%rsp)
               	movq	%rbx, %rdi
               	movl	$0x6, %esi
               	leaq	0x30(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movw	$0x2, 0x30(%rsp)
               	movq	%rbx, %rdi
               	movl	$0x6, %esi
               	leaq	0x30(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	movw	$0x1, 0x30(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movq	%rbx, %rdi
               	movl	$0x6, %esi
               	leaq	0x30(%rsp), %rdx
               	movb	$0x0, %al
               	callq	*%rcx
               	movq	%rax, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x50(%rsp), %rdi
               	callq	<addr>
               	cmpl	$0x0, 0x28(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x20(%rsp)
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x90, %rsp
               	retq
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	movq	0x18(%rsp), %r10
               	testl	%r10d, %r10d
               	cmovneq	%rcx, %rax
               	popq	%rbx
               	addq	$0x90, %rsp
               	retq
