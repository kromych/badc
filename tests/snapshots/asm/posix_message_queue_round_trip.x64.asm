
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1b0, %rsp            # imm = 0x1B0
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%esi, %esi
               	movl	%esi, -0xf8(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	$0x4, -0x98(%rbp)
               	movq	$0x40, -0x90(%rbp)
               	leaq	<rip>, %r13
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x11, %eax
               	jne	<addr>
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	je	<addr>
               	incq	%rbx
               	leaq	-0x20(%rbp), %r12
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
               	leaq	-0x20(%rbp), %rdi
               	movl	$0xc2, %esi
               	movl	$0x180, %edx            # imm = 0x180
               	leaq	-0xa0(%rbp), %rcx
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
               	leaq	-0x20(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	movq	-0xd8(%rbp), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	-0xd0(%rbp), %rax
               	cmpq	$0x40, %rax
               	jne	<addr>
               	cmpq	$0x0, -0xc8(%rbp)
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
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
               	jmp	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0xc8(%rbp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x40, %edx
               	leaq	-0xf8(%rbp), %rcx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	-0xf8(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	jmp	<addr>
               	xorl	%edi, %edi
               	leaq	-0xf0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xf0(%rbp), %r8
               	movq	-0xf0(%rbp), %rax
               	addq	$0x5, %rax
               	movq	%rax, -0xf0(%rbp)
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x40, %edx
               	leaq	-0xf8(%rbp), %rcx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movl	-0xf8(%rbp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
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
               	jmp	<addr>
               	leaq	-0x60(%rbp), %rsi
               	movl	$0x40, %edx
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	jmp	<addr>
               	leaq	-0xa0(%rbp), %rsi
               	movq	$0x800, -0xa0(%rbp)     # imm = 0x800
               	leaq	-0xe0(%rbp), %rdx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0xe0(%rbp)
               	je	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	leaq	-0x60(%rbp), %rsi
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
               	jmp	<addr>
               	leaq	-0x60(%rbp), %rsi
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
               	jmp	<addr>
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
