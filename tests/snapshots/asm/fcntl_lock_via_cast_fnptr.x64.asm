
fcntl_lock_via_cast_fnptr.x64:	file format elf64-x86-64

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
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	-0x40(%rbp), %rbx
               	movl	$0x40, %r12d
               	leaq	<rip>, %r13
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x42, %esi
               	movl	$0x1a4, %edx            # imm = 0x1A4
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rdi
               	xorq	%r12, %r12
               	movl	$0x60, %edx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movl	$0x1, %r13d
               	movw	%r13w, (%rax)
               	leaq	-0xa8(%rbp), %rax
               	movw	%r12w, 0x2(%rax)
               	movslq	%ebx, %rdi
               	movl	$0x6, %r12d
               	leaq	-0xa8(%rbp), %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	leaq	-0xa8(%rbp), %rax
               	movl	$0x2, %ecx
               	movw	%cx, (%rax)
               	movslq	%ebx, %rdi
               	leaq	-0xa8(%rbp), %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	leaq	-0xa8(%rbp), %rax
               	movw	%r13w, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	%ebx, %rdi
               	leaq	-0xa8(%rbp), %rdx
               	movq	%rax, %rcx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	*%rcx
               	movslq	%eax, %r12
               	movslq	%ebx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%r14d, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	%r15d, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	testq	%r12, %r12
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>

<__c5_sys_fcntl>:
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
