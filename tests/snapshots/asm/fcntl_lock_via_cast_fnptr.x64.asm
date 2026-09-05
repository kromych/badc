
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
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	-0xa0(%rbp), %rbx
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
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0x42, %esi
               	movl	$0x1a4, %edx            # imm = 0x1A4
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rdi
               	xorq	%r12, %r12
               	movl	$0x60, %edx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x60(%rbp), %rdx
               	movl	$0x1, %r14d
               	movw	%r14w, (%rdx)
               	movw	%r12w, 0x2(%rdx)
               	movslq	%ebx, %rdi
               	movl	$0x6, %r12d
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r13
               	leaq	-0x60(%rbp), %rdx
               	movl	$0x2, %eax
               	movw	%ax, (%rdx)
               	movslq	%ebx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	leaq	-0x60(%rbp), %rdx
               	movw	%r14w, (%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	%ebx, %rdi
               	movq	%rax, %rcx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	*%rcx
               	movq	%rax, %r12
               	movslq	%ebx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0xa0(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%r13, %r13
               	jne	<addr>
               	testl	%r15d, %r15d
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	testq	%r12, %r12
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

<__c5_sys_fcntl>:
               	jmp	<addr>
