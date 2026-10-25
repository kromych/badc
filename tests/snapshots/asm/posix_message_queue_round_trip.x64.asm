
posix_message_queue_round_trip.x64:	file format elf64-x86-64

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

<round_trip>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%esi, %esi
               	movl	%esi, -0xf8(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	$0x4, -0x78(%rbp)
               	movq	$0x40, -0x70(%rbp)
               	xorl	%ebx, %ebx
               	leaq	<rip>, %r13
               	jmp	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x11, %eax
               	jne	<addr>
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	je	<addr>
               	incq	%rbx
               	leaq	-0xe0(%rbp), %r12
               	movl	$0x20, %r14d
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r12, %rdi
               	movq	%rbx, %r8
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0xe0(%rbp), %rdi
               	movl	$0xc2, %esi
               	movl	$0x180, %edx            # imm = 0x180
               	leaq	-0x80(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r12
               	cmpl	$-0x1, %r12d
               	je	<addr>
               	cmpl	$-0x1, %r12d
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x26, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xb, %eax
               	jmp	<addr>
               	leaq	-0xe0(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	-0x38(%rbp), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x40, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x28(%rbp)
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	movl	$0x1, %ecx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x5, %edx
               	movl	$0x7, %ecx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x40(%rbp), %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rsi
               	movl	$0x40, %edx
               	leaq	-0xf8(%rbp), %rcx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	-0xf8(%rbp), %eax
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	-0xf0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xf0(%rbp), %r8
               	movq	-0xf0(%rbp), %rax
               	addq	$0x5, %rax
               	movq	%rax, -0xf0(%rbp)
               	leaq	-0xc0(%rbp), %rsi
               	movl	$0x40, %edx
               	leaq	-0xf8(%rbp), %rcx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movl	-0xf8(%rbp), %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x6, %edx
               	movl	$0x3, %ecx
               	leaq	-0xf0(%rbp), %r8
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rsi
               	movl	$0x40, %edx
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x80(%rbp), %rsi
               	movq	$0x800, -0x80(%rbp)     # imm = 0x800
               	leaq	-0x40(%rbp), %rdx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x40(%rbp)
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rsi
               	movl	$0x40, %edx
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	popq	%rbp
               	retq
